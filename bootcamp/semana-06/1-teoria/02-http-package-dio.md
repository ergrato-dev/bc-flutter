# 📚 Módulo 02: Paquete HTTP y Dio

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Configurar y usar el paquete `http` de Dart
- ✅ Realizar peticiones GET, POST, PUT, DELETE
- ✅ Configurar headers y autenticación
- ✅ Utilizar Dio para peticiones avanzadas
- ✅ Implementar interceptores para logging y autenticación
- ✅ Manejar timeouts y cancelación de peticiones

---

## 📖 Contenido Teórico

### 1. El Paquete HTTP

El paquete `http` es la forma más simple de hacer peticiones HTTP en Dart/Flutter.

#### Instalación

```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0
```

```bash
flutter pub get
```

#### Importación

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';  // Para jsonEncode/jsonDecode
```

### 2. Peticiones GET

```dart
/**
 * fetchUsers
 *
 * ¿Qué hace?
 * Obtiene la lista de usuarios desde la API
 *
 * ¿Para qué?
 * Cargar datos de usuarios para mostrar en una lista
 *
 * ¿Cómo funciona?
 * 1. Construye la URI con los parámetros
 * 2. Realiza la petición GET
 * 3. Verifica el código de estado
 * 4. Decodifica el JSON de respuesta
 * 5. Retorna la lista de usuarios
 */
Future<List<User>> fetchUsers() async {
  // Construir la URL
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');

  try {
    // Realizar petición GET
    final response = await http.get(uri);

    // Verificar respuesta exitosa
    if (response.statusCode == 200) {
      // Decodificar JSON
      final List<dynamic> jsonData = jsonDecode(response.body);

      // Convertir a lista de objetos
      return jsonData.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de red: $e');
  }
}
```

#### GET con Query Parameters

```dart
/**
 * fetchUsersWithParams
 *
 * ¿Qué hace?
 * Obtiene usuarios filtrados por parámetros
 *
 * ¿Cómo funciona?
 * Usa Uri con queryParameters para construir URL con filtros
 */
Future<List<User>> fetchUsersWithParams({
  int? page,
  int? limit,
  String? role,
}) async {
  // Construir URI con query parameters
  final uri = Uri.https(
    'api.example.com',
    '/users',
    {
      if (page != null) 'page': page.toString(),
      if (limit != null) 'limit': limit.toString(),
      if (role != null) 'role': role,
    },
  );
  // Resultado: https://api.example.com/users?page=1&limit=10&role=admin

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => User.fromJson(json)).toList();
  }

  throw HttpException('Error ${response.statusCode}');
}
```

#### GET con Headers

```dart
/**
 * fetchUserWithAuth
 *
 * ¿Qué hace?
 * Obtiene un usuario específico con autenticación
 *
 * ¿Por qué headers?
 * - Enviar token de autenticación
 * - Especificar formato de datos
 * - Enviar información adicional
 */
Future<User> fetchUserWithAuth(int userId, String token) async {
  final uri = Uri.parse('https://api.example.com/users/$userId');

  // Headers de la petición
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    throw UnauthorizedException('Token inválido o expirado');
  } else if (response.statusCode == 404) {
    throw NotFoundException('Usuario no encontrado');
  }

  throw HttpException('Error ${response.statusCode}');
}
```

### 3. Peticiones POST

```dart
/**
 * createUser
 *
 * ¿Qué hace?
 * Crea un nuevo usuario en el servidor
 *
 * ¿Para qué?
 * Registrar nuevos usuarios desde la app
 *
 * ¿Cómo funciona?
 * 1. Prepara los datos del usuario como JSON
 * 2. Envía la petición POST con el body
 * 3. Verifica que se haya creado (201)
 * 4. Retorna el usuario creado con su ID
 */
Future<User> createUser(User user) async {
  final uri = Uri.parse('https://api.example.com/users');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Convertir objeto a JSON string
  final body = jsonEncode(user.toJson());

  final response = await http.post(
    uri,
    headers: headers,
    body: body,
  );

  // 201 = Created (recurso creado exitosamente)
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    throw ValidationException('Datos inválidos');
  } else if (response.statusCode == 409) {
    throw ConflictException('El usuario ya existe');
  }

  throw HttpException('Error al crear usuario: ${response.statusCode}');
}
```

#### POST con Form Data

```dart
/**
 * loginUser
 *
 * ¿Qué hace?
 * Autentica un usuario con email y contraseña
 *
 * ¿Cuándo usar form data?
 * - Cuando la API espera application/x-www-form-urlencoded
 * - Formularios tradicionales
 */
Future<AuthResponse> loginUser(String email, String password) async {
  final uri = Uri.parse('https://api.example.com/auth/login');

  // Enviar como form data
  final response = await http.post(
    uri,
    body: {
      'email': email,
      'password': password,
    },
    // Content-Type será automáticamente application/x-www-form-urlencoded
  );

  if (response.statusCode == 200) {
    return AuthResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    throw UnauthorizedException('Credenciales incorrectas');
  }

  throw HttpException('Error de autenticación');
}
```

### 4. Peticiones PUT y PATCH

```dart
/**
 * updateUser (PUT)
 *
 * ¿Qué hace?
 * Actualiza completamente un usuario existente
 *
 * PUT vs PATCH:
 * - PUT: Reemplaza todo el recurso
 * - PATCH: Actualiza solo los campos enviados
 */
Future<User> updateUser(int userId, User user) async {
  final uri = Uri.parse('https://api.example.com/users/$userId');

  final headers = {
    'Content-Type': 'application/json',
  };

  final response = await http.put(
    uri,
    headers: headers,
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 404) {
    throw NotFoundException('Usuario no encontrado');
  }

  throw HttpException('Error al actualizar: ${response.statusCode}');
}

/**
 * patchUser (PATCH)
 *
 * ¿Qué hace?
 * Actualiza solo los campos especificados
 *
 * ¿Cuándo usar?
 * Cuando solo necesitas cambiar 1 o 2 campos
 */
Future<User> patchUser(int userId, Map<String, dynamic> fields) async {
  final uri = Uri.parse('https://api.example.com/users/$userId');

  final response = await http.patch(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(fields),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  }

  throw HttpException('Error al actualizar: ${response.statusCode}');
}

// Uso de PATCH
await patchUser(123, {'email': 'new@email.com'});
```

### 5. Peticiones DELETE

```dart
/**
 * deleteUser
 *
 * ¿Qué hace?
 * Elimina un usuario del servidor
 *
 * ¿Cómo funciona?
 * 1. Envía petición DELETE a la URL del recurso
 * 2. Verifica respuesta (200 o 204)
 * 3. No retorna datos (el recurso ya no existe)
 */
Future<void> deleteUser(int userId) async {
  final uri = Uri.parse('https://api.example.com/users/$userId');

  final response = await http.delete(uri);

  // 200 = OK, 204 = No Content (ambos indican éxito)
  if (response.statusCode == 200 || response.statusCode == 204) {
    return; // Éxito
  } else if (response.statusCode == 404) {
    throw NotFoundException('Usuario no encontrado');
  } else if (response.statusCode == 403) {
    throw ForbiddenException('No tienes permiso para eliminar');
  }

  throw HttpException('Error al eliminar: ${response.statusCode}');
}
```

### 6. Clase de Servicio API

```dart
/**
 * ApiService
 *
 * ¿Qué hace?
 * Centraliza todas las peticiones HTTP de la aplicación
 *
 * ¿Para qué?
 * - Reutilizar configuración (headers, base URL)
 * - Manejar errores de forma consistente
 * - Facilitar testing y mantenimiento
 *
 * ¿Cómo funciona?
 * - Configura base URL y headers por defecto
 * - Provee métodos para cada tipo de petición
 * - Maneja errores de forma centralizada
 */
class ApiService {
  static const String _baseUrl = 'https://api.example.com';
  String? _token;

  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Setter para el token
  void setToken(String token) {
    _token = token;
  }

  // Headers por defecto
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  // GET genérico
  Future<dynamic> get(String endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse('$_baseUrl$endpoint').replace(
      queryParameters: params,
    );

    final response = await http.get(uri, headers: _headers);
    return _handleResponse(response);
  }

  // POST genérico
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');

    final response = await http.post(
      uri,
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  // PUT genérico
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');

    final response = await http.put(
      uri,
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  // DELETE genérico
  Future<void> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');

    final response = await http.delete(uri, headers: _headers);
    _handleResponse(response);
  }

  // Manejo centralizado de respuestas
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw BadRequestException(_parseError(response));
      case 401:
        throw UnauthorizedException('No autenticado');
      case 403:
        throw ForbiddenException('Sin permisos');
      case 404:
        throw NotFoundException('Recurso no encontrado');
      case 422:
        throw ValidationException(_parseError(response));
      case >= 500:
        throw ServerException('Error del servidor');
      default:
        throw HttpException('Error: ${response.statusCode}');
    }
  }

  String _parseError(http.Response response) {
    try {
      final json = jsonDecode(response.body);
      return json['message'] ?? json['error'] ?? 'Error desconocido';
    } catch (_) {
      return response.body;
    }
  }
}

// Uso
final api = ApiService();
api.setToken('mi-token');

final users = await api.get('/users');
final newUser = await api.post('/users', body: {'name': 'John'});
await api.delete('/users/123');
```

---

## 📦 Dio - Cliente HTTP Avanzado

### 1. ¿Por qué Dio?

| Característica   | http   | Dio        |
| ---------------- | ------ | ---------- |
| Interceptores    | ❌     | ✅         |
| Cancelación      | ❌     | ✅         |
| FormData         | Manual | ✅         |
| Transformers     | ❌     | ✅         |
| Timeout global   | ❌     | ✅         |
| Retry automático | ❌     | Con plugin |
| Progress         | ❌     | ✅         |

#### Instalación

```yaml
dependencies:
  dio: ^5.4.0
```

### 2. Configuración Básica

```dart
/**
 * DioClient
 *
 * ¿Qué hace?
 * Configura y provee una instancia de Dio para toda la app
 *
 * ¿Para qué?
 * - Configuración centralizada
 * - Interceptores para logging/auth
 * - Timeout y opciones globales
 */
import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  // Singleton
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Agregar interceptores
    _dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      _AuthInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  Dio get dio => _dio;
}
```

### 3. Interceptores

Los interceptores permiten ejecutar código antes/después de cada petición.

```dart
/**
 * AuthInterceptor
 *
 * ¿Qué hace?
 * Añade automáticamente el token a todas las peticiones
 *
 * ¿Cómo funciona?
 * 1. Antes de cada petición (onRequest)
 * 2. Obtiene el token almacenado
 * 3. Lo añade al header Authorization
 */
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Obtener token (de SharedPreferences, Provider, etc.)
    final token = AuthStorage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Continuar con la petición
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Si el token expiró, intentar refrescar
    if (err.response?.statusCode == 401) {
      // Implementar lógica de refresh token
      // ...
    }

    handler.next(err);
  }
}

/**
 * ErrorInterceptor
 *
 * ¿Qué hace?
 * Maneja errores de forma centralizada
 *
 * ¿Para qué?
 * - Logging de errores
 * - Transformar errores a excepciones propias
 * - Manejo global de errores de red
 */
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log del error
    print('Error: ${err.type} - ${err.message}');

    // Transformar a excepción propia
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: TimeoutException('La conexión tardó demasiado'),
        ));
        break;
      case DioExceptionType.connectionError:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: NetworkException('Sin conexión a internet'),
        ));
        break;
      default:
        handler.next(err);
    }
  }
}
```

### 4. Logging Interceptor

```dart
/**
 * CustomLogInterceptor
 *
 * ¿Qué hace?
 * Registra todas las peticiones y respuestas para debugging
 *
 * ¿Cuándo usar?
 * - Durante desarrollo para ver qué se envía/recibe
 * - Debugging de problemas con APIs
 */
class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────');
    print('│ 📤 REQUEST: ${options.method} ${options.uri}');
    print('│ Headers: ${options.headers}');
    if (options.data != null) {
      print('│ Body: ${options.data}');
    }
    print('└─────────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────');
    print('│ 📥 RESPONSE: ${response.statusCode}');
    print('│ Data: ${response.data}');
    print('└─────────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────');
    print('│ ❌ ERROR: ${err.type}');
    print('│ Message: ${err.message}');
    print('│ Response: ${err.response?.data}');
    print('└─────────────────────────────────────────────────');
    handler.next(err);
  }
}
```

### 5. Peticiones con Dio

```dart
/**
 * UserService con Dio
 *
 * ¿Qué hace?
 * Servicio de usuarios usando Dio para peticiones HTTP
 */
class UserService {
  final Dio _dio = DioClient().dio;

  // GET - Obtener usuarios
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users');

      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // GET - Obtener usuario por ID
  Future<User> getUserById(int id) async {
    try {
      final response = await _dio.get('/users/$id');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST - Crear usuario
  Future<User> createUser(User user) async {
    try {
      final response = await _dio.post(
        '/users',
        data: user.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT - Actualizar usuario
  Future<User> updateUser(int id, User user) async {
    try {
      final response = await _dio.put(
        '/users/$id',
        data: user.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE - Eliminar usuario
  Future<void> deleteUser(int id) async {
    try {
      await _dio.delete('/users/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Manejo de errores
  Exception _handleError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return BadRequestException(e.response?.data['message']);
      case 401:
        return UnauthorizedException('No autenticado');
      case 404:
        return NotFoundException('Usuario no encontrado');
      case 500:
        return ServerException('Error del servidor');
      default:
        return NetworkException(e.message ?? 'Error de red');
    }
  }
}
```

### 6. Cancelación de Peticiones

```dart
/**
 * Cancelación de peticiones
 *
 * ¿Para qué?
 * - Cancelar búsquedas cuando el usuario cambia el query
 * - Cancelar descargas
 * - Evitar peticiones innecesarias
 */
class SearchService {
  final Dio _dio = DioClient().dio;
  CancelToken? _cancelToken;

  Future<List<SearchResult>> search(String query) async {
    // Cancelar petición anterior si existe
    _cancelToken?.cancel('Nueva búsqueda iniciada');

    // Crear nuevo token
    _cancelToken = CancelToken();

    try {
      final response = await _dio.get(
        '/search',
        queryParameters: {'q': query},
        cancelToken: _cancelToken,
      );

      return (response.data as List)
          .map((json) => SearchResult.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        // Petición cancelada - no es un error real
        return [];
      }
      rethrow;
    }
  }

  void cancelSearch() {
    _cancelToken?.cancel('Búsqueda cancelada por el usuario');
  }
}
```

### 7. Subida de Archivos

```dart
/**
 * uploadFile
 *
 * ¿Qué hace?
 * Sube un archivo al servidor con progreso
 *
 * ¿Cómo funciona?
 * 1. Crea FormData con el archivo
 * 2. Usa onSendProgress para reportar progreso
 * 3. Retorna la URL del archivo subido
 */
Future<String> uploadFile(
  File file, {
  void Function(int sent, int total)? onProgress,
}) async {
  final dio = DioClient().dio;

  // Crear FormData
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    ),
  });

  final response = await dio.post(
    '/upload',
    data: formData,
    onSendProgress: onProgress,
  );

  return response.data['url'];
}

// Uso
await uploadFile(
  myFile,
  onProgress: (sent, total) {
    final progress = sent / total * 100;
    print('Progreso: ${progress.toStringAsFixed(1)}%');
  },
);
```

---

## 💻 Comparativa http vs Dio

```dart
// ============ CON HTTP ============
import 'package:http/http.dart' as http;

Future<User> getUser(int id) async {
  final response = await http.get(
    Uri.parse('https://api.example.com/users/$id'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  }
  throw Exception('Error ${response.statusCode}');
}

// ============ CON DIO ============
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  headers: {'Authorization': 'Bearer $token'},
));

Future<User> getUser(int id) async {
  final response = await dio.get('/users/$id');
  return User.fromJson(response.data);
}
```

---

## 📝 Resumen

| Aspecto       | http          | Dio                   |
| ------------- | ------------- | --------------------- |
| Complejidad   | Simple        | Moderada              |
| Configuración | Por petición  | Global + por petición |
| Interceptores | ❌            | ✅                    |
| Cancelación   | ❌            | ✅                    |
| Mejor para    | Apps pequeñas | Apps medianas/grandes |

---

## 🔗 Recursos

- [http Package](https://pub.dev/packages/http)
- [Dio Package](https://pub.dev/packages/dio)
- [Dio Interceptors](https://pub.dev/packages/dio#interceptors)

---

📅 **Anterior:** [← Módulo 01](./01-fundamentos-http-rest.md) | **Siguiente:** [Módulo 03 →](./03-serializacion-json.md)
