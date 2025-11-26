# 💻 Práctica 04: Dio con Interceptores

## 🎯 Objetivos

- ✅ Configurar Dio como cliente HTTP
- ✅ Implementar interceptores para logging
- ✅ Crear interceptor de autenticación
- ✅ Manejar errores de forma centralizada
- ✅ Implementar retry automático

---

## 📋 Descripción

Aprenderás a usar Dio, un cliente HTTP más potente que el paquete `http`, implementando interceptores para logging, autenticación y manejo de errores.

**Tiempo estimado:** 50 minutos

---

## 🔧 Configuración

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
  shared_preferences: ^2.2.2  # Para almacenar token
```

```bash
flutter pub get
```

---

## 📝 Implementación

### Paso 1: Configuración base de Dio

```dart
/**
 * lib/core/network/dio_client.dart
 * 
 * DioClient - Cliente HTTP configurado
 * 
 * ¿Qué hace?
 * - Configura Dio con opciones base
 * - Agrega interceptores
 * - Provee instancia única (singleton)
 * 
 * ¿Por qué singleton?
 * - Una sola configuración para toda la app
 * - Interceptores compartidos
 * - Eficiencia en recursos
 */
import 'package:dio/dio.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class DioClient {
  late final Dio _dio;
  
  // Singleton pattern
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        // URL base de la API
        baseUrl: 'https://jsonplaceholder.typicode.com',
        
        // Timeouts
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        
        // Headers por defecto
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        
        // Validar status codes (2xx son éxito)
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    
    // Agregar interceptores en orden
    _dio.interceptors.addAll([
      LoggingInterceptor(),      // 1. Logging (primero para ver todo)
      AuthInterceptor(),         // 2. Autenticación
      ErrorInterceptor(),        // 3. Manejo de errores (último)
    ]);
  }
  
  // Acceso a la instancia de Dio
  Dio get dio => _dio;
  
  // Métodos de conveniencia
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
  
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
  
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }
  
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
```

### Paso 2: Interceptor de Logging

```dart
/**
 * lib/core/network/interceptors/logging_interceptor.dart
 * 
 * LoggingInterceptor - Registra todas las peticiones y respuestas
 * 
 * ¿Para qué?
 * - Debugging durante desarrollo
 * - Ver qué se envía y recibe
 * - Detectar problemas de comunicación
 * 
 * ⚠️ Desactivar o reducir en producción
 */
import 'dart:developer' as developer;
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  
  /**
   * onRequest - Se ejecuta ANTES de enviar cada petición
   */
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timestamp = DateTime.now().toIso8601String();
    
    _log('┌──────────────────────────────────────────────────────');
    _log('│ 📤 REQUEST [$timestamp]');
    _log('├──────────────────────────────────────────────────────');
    _log('│ ${options.method} ${options.uri}');
    _log('│ Headers: ${_formatHeaders(options.headers)}');
    
    if (options.data != null) {
      _log('│ Body: ${options.data}');
    }
    
    if (options.queryParameters.isNotEmpty) {
      _log('│ Query: ${options.queryParameters}');
    }
    
    _log('└──────────────────────────────────────────────────────');
    
    // IMPORTANTE: Continuar con la petición
    handler.next(options);
  }
  
  /**
   * onResponse - Se ejecuta cuando llega una respuesta exitosa
   */
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final duration = response.requestOptions.extra['startTime'] != null
        ? DateTime.now().difference(response.requestOptions.extra['startTime'])
        : null;
    
    _log('┌──────────────────────────────────────────────────────');
    _log('│ 📥 RESPONSE [${response.statusCode}]');
    _log('├──────────────────────────────────────────────────────');
    _log('│ ${response.requestOptions.method} ${response.requestOptions.uri}');
    if (duration != null) {
      _log('│ ⏱️ Duration: ${duration.inMilliseconds}ms');
    }
    _log('│ Status: ${response.statusCode} ${response.statusMessage}');
    
    // Limitar tamaño del log de datos
    final data = response.data.toString();
    if (data.length > 500) {
      _log('│ Data: ${data.substring(0, 500)}... [truncated]');
    } else {
      _log('│ Data: $data');
    }
    
    _log('└──────────────────────────────────────────────────────');
    
    // Continuar con la respuesta
    handler.next(response);
  }
  
  /**
   * onError - Se ejecuta cuando hay un error
   */
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('┌──────────────────────────────────────────────────────');
    _log('│ ❌ ERROR');
    _log('├──────────────────────────────────────────────────────');
    _log('│ ${err.requestOptions.method} ${err.requestOptions.uri}');
    _log('│ Type: ${err.type}');
    _log('│ Message: ${err.message}');
    
    if (err.response != null) {
      _log('│ Status: ${err.response?.statusCode}');
      _log('│ Data: ${err.response?.data}');
    }
    
    _log('└──────────────────────────────────────────────────────');
    
    // Continuar con el error
    handler.next(err);
  }
  
  void _log(String message) {
    developer.log(message, name: 'HTTP');
    // También puedes usar print para desarrollo
    // print(message);
  }
  
  String _formatHeaders(Map<String, dynamic> headers) {
    final filtered = Map.from(headers);
    // Ocultar valores sensibles
    if (filtered.containsKey('Authorization')) {
      filtered['Authorization'] = '***';
    }
    return filtered.toString();
  }
}
```

### Paso 3: Interceptor de Autenticación

```dart
/**
 * lib/core/network/interceptors/auth_interceptor.dart
 * 
 * AuthInterceptor - Maneja autenticación automática
 * 
 * ¿Qué hace?
 * - Añade token a todas las peticiones
 * - Detecta tokens expirados (401)
 * - Puede refrescar tokens automáticamente
 */
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  
  // Key para almacenar el token
  static const String _tokenKey = 'auth_token';
  
  /**
   * onRequest - Añadir token antes de cada petición
   */
  @override
  void onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler,
  ) async {
    // Guardar tiempo de inicio para medir duración
    options.extra['startTime'] = DateTime.now();
    
    // Obtener token almacenado
    final token = await _getToken();
    
    if (token != null && token.isNotEmpty) {
      // Añadir header de autorización
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
  
  /**
   * onError - Manejar errores de autenticación
   */
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Si el error es 401 (No autorizado)
    if (err.response?.statusCode == 401) {
      // Opción 1: Intentar refrescar token
      final refreshed = await _tryRefreshToken();
      
      if (refreshed) {
        // Reintentar la petición original
        try {
          final response = await _retryRequest(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          // Si falla el retry, continuar con el error
        }
      }
      
      // Opción 2: Limpiar sesión y notificar
      await _clearToken();
      // Aquí podrías emitir un evento para redirigir al login
    }
    
    handler.next(err);
  }
  
  // ==================== Métodos auxiliares ====================
  
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
  
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
  
  Future<bool> _tryRefreshToken() async {
    // Implementar lógica de refresh token
    // Por ahora retornamos false
    return false;
  }
  
  Future<Response> _retryRequest(RequestOptions options) async {
    final dio = Dio();
    final token = await _getToken();
    
    options.headers['Authorization'] = 'Bearer $token';
    
    return dio.fetch(options);
  }
  
  // ==================== Métodos estáticos para uso externo ====================
  
  /// Guardar token después del login
  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
  
  /// Limpiar token en logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
  
  /// Verificar si hay sesión activa
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }
}
```

### Paso 4: Interceptor de Errores

```dart
/**
 * lib/core/network/interceptors/error_interceptor.dart
 * 
 * ErrorInterceptor - Manejo centralizado de errores
 * 
 * ¿Qué hace?
 * - Transforma DioException a excepciones propias
 * - Maneja diferentes tipos de errores
 * - Proporciona mensajes amigables
 */
import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';

class ErrorInterceptor extends Interceptor {
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _handleError(err);
    
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }
  
  /**
   * _handleError - Transformar DioException a ApiException
   */
  ApiException _handleError(DioException error) {
    switch (error.type) {
      // Errores de conexión
      case DioExceptionType.connectionTimeout:
        return ApiException(
          message: 'Tiempo de conexión agotado',
          code: 'CONNECTION_TIMEOUT',
        );
        
      case DioExceptionType.sendTimeout:
        return ApiException(
          message: 'Tiempo de envío agotado',
          code: 'SEND_TIMEOUT',
        );
        
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Tiempo de respuesta agotado',
          code: 'RECEIVE_TIMEOUT',
        );
        
      case DioExceptionType.connectionError:
        return ApiException(
          message: 'Sin conexión a internet',
          code: 'NO_CONNECTION',
        );
        
      // Error de respuesta (status code)
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
        
      // Petición cancelada
      case DioExceptionType.cancel:
        return ApiException(
          message: 'Petición cancelada',
          code: 'CANCELLED',
        );
        
      // Certificado inválido
      case DioExceptionType.badCertificate:
        return ApiException(
          message: 'Certificado de seguridad inválido',
          code: 'BAD_CERTIFICATE',
        );
        
      // Otros errores
      case DioExceptionType.unknown:
      default:
        return ApiException(
          message: error.message ?? 'Error desconocido',
          code: 'UNKNOWN',
        );
    }
  }
  
  /**
   * _handleResponseError - Manejar errores según status code
   */
  ApiException _handleResponseError(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;
    
    // Intentar obtener mensaje del servidor
    String? serverMessage;
    if (data is Map) {
      serverMessage = data['message'] ?? data['error'];
    }
    
    switch (statusCode) {
      case 400:
        return ApiException(
          message: serverMessage ?? 'Petición inválida',
          code: 'BAD_REQUEST',
          statusCode: 400,
        );
        
      case 401:
        return ApiException(
          message: serverMessage ?? 'No autorizado',
          code: 'UNAUTHORIZED',
          statusCode: 401,
        );
        
      case 403:
        return ApiException(
          message: serverMessage ?? 'Acceso denegado',
          code: 'FORBIDDEN',
          statusCode: 403,
        );
        
      case 404:
        return ApiException(
          message: serverMessage ?? 'Recurso no encontrado',
          code: 'NOT_FOUND',
          statusCode: 404,
        );
        
      case 409:
        return ApiException(
          message: serverMessage ?? 'Conflicto con el recurso',
          code: 'CONFLICT',
          statusCode: 409,
        );
        
      case 422:
        return ApiException(
          message: serverMessage ?? 'Datos inválidos',
          code: 'VALIDATION_ERROR',
          statusCode: 422,
          data: data,
        );
        
      case 429:
        return ApiException(
          message: 'Demasiadas peticiones, intenta más tarde',
          code: 'RATE_LIMIT',
          statusCode: 429,
        );
        
      case 500:
        return ApiException(
          message: 'Error del servidor',
          code: 'SERVER_ERROR',
          statusCode: 500,
        );
        
      case 502:
        return ApiException(
          message: 'Servidor no disponible',
          code: 'BAD_GATEWAY',
          statusCode: 502,
        );
        
      case 503:
        return ApiException(
          message: 'Servicio no disponible',
          code: 'SERVICE_UNAVAILABLE',
          statusCode: 503,
        );
        
      default:
        return ApiException(
          message: 'Error del servidor ($statusCode)',
          code: 'HTTP_ERROR',
          statusCode: statusCode,
        );
    }
  }
}
```

### Paso 5: Excepciones personalizadas

```dart
/**
 * lib/core/network/exceptions/api_exception.dart
 * 
 * ApiException - Excepción personalizada para errores de API
 */
class ApiException implements Exception {
  final String message;
  final String code;
  final int? statusCode;
  final dynamic data;
  
  const ApiException({
    required this.message,
    required this.code,
    this.statusCode,
    this.data,
  });
  
  @override
  String toString() => 'ApiException: [$code] $message';
  
  /// ¿Es error de red?
  bool get isNetworkError => [
    'CONNECTION_TIMEOUT',
    'SEND_TIMEOUT', 
    'RECEIVE_TIMEOUT',
    'NO_CONNECTION',
  ].contains(code);
  
  /// ¿Es error de autenticación?
  bool get isAuthError => code == 'UNAUTHORIZED' || code == 'FORBIDDEN';
  
  /// ¿Es error del servidor?
  bool get isServerError => statusCode != null && statusCode! >= 500;
}
```

### Paso 6: Uso en servicio

```dart
/**
 * lib/services/user_service_dio.dart
 * 
 * UserService usando DioClient
 */
import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../core/network/exceptions/api_exception.dart';
import '../models/user.dart';

class UserServiceDio {
  final DioClient _client = DioClient();
  
  Future<List<User>> getUsers() async {
    try {
      final response = await _client.get('/users');
      
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      // El error ya viene transformado por ErrorInterceptor
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      rethrow;
    }
  }
  
  Future<User> getUserById(int id) async {
    try {
      final response = await _client.get('/users/$id');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      rethrow;
    }
  }
  
  Future<User> createUser(User user) async {
    try {
      final response = await _client.post(
        '/users',
        data: user.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      rethrow;
    }
  }
}
```

---

## ✅ Puntos de Verificación

- [ ] Dio está configurado como singleton
- [ ] LoggingInterceptor muestra peticiones en consola
- [ ] AuthInterceptor añade token a headers
- [ ] ErrorInterceptor transforma errores correctamente
- [ ] Los mensajes de error son amigables para el usuario

---

## 🎯 Retos Adicionales

### Reto 1: Retry Interceptor
Implementa un interceptor que reintente automáticamente en errores 5xx.

### Reto 2: Cache Interceptor
Crea un interceptor que cache respuestas GET por un tiempo.

### Reto 3: Refresh Token
Implementa la lógica completa de refresh token en AuthInterceptor.

---

📅 **Anterior:** [← Práctica 03](./practica-03-futurebuilder-lista.md) | **Siguiente:** [Práctica 05 →](./practica-05-busqueda-tiempo-real.md)
