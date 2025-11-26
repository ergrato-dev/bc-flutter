# 📋 Guía Rápida: Dio Package

## 🚀 Setup

```yaml
# pubspec.yaml
dependencies:
  dio: ^5.4.0
```

```dart
import 'package:dio/dio.dart';
```

---

## 🔧 Configuración Básica

### Instancia Simple

```dart
final dio = Dio();

// Con opciones base
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
));
```

### Singleton Pattern

```dart
class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  
  late final Dio dio;
  
  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    
    // Agregar interceptores
    dio.interceptors.addAll([
      LogInterceptor(responseBody: true),
      AuthInterceptor(),
    ]);
  }
}
```

---

## 🔧 Operaciones CRUD

### GET

```dart
// Simple
final response = await dio.get('/users');

// Con query parameters
final response = await dio.get(
  '/users',
  queryParameters: {
    'page': 1,
    'limit': 10,
    'search': 'john',
  },
);

// Con options adicionales
final response = await dio.get(
  '/users/1',
  options: Options(
    headers: {'X-Custom-Header': 'value'},
  ),
);
```

### POST

```dart
final response = await dio.post(
  '/users',
  data: {
    'name': 'John Doe',
    'email': 'john@example.com',
  },
);

// FormData
final formData = FormData.fromMap({
  'name': 'John',
  'file': await MultipartFile.fromFile('./image.jpg'),
});
final response = await dio.post('/upload', data: formData);
```

### PUT

```dart
final response = await dio.put(
  '/users/1',
  data: {
    'name': 'John Updated',
    'email': 'john.new@example.com',
  },
);
```

### PATCH

```dart
final response = await dio.patch(
  '/users/1',
  data: {'name': 'John Updated'},
);
```

### DELETE

```dart
final response = await dio.delete('/users/1');
```

---

## 🔄 Interceptores

### Logging Interceptor

```dart
dio.interceptors.add(LogInterceptor(
  request: true,
  requestHeader: true,
  requestBody: true,
  responseHeader: false,
  responseBody: true,
  error: true,
  logPrint: (log) => debugPrint(log.toString()),
));
```

### Auth Interceptor

```dart
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  
  AuthInterceptor(this._tokenStorage);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStorage.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Intentar refresh token
      try {
        await _refreshToken();
        // Reintentar request original
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Forzar logout
        _tokenStorage.clear();
      }
    }
    handler.next(err);
  }
  
  Future<void> _refreshToken() async {
    // Lógica de refresh
  }
  
  Future<Response> _retry(RequestOptions options) async {
    final newOptions = Options(
      method: options.method,
      headers: options.headers,
    );
    return Dio().request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: newOptions,
    );
  }
}
```

### Cache Interceptor

```dart
class CacheInterceptor extends Interceptor {
  final Map<String, CacheEntry> _cache = {};
  final Duration _cacheDuration;
  
  CacheInterceptor({Duration? duration})
      : _cacheDuration = duration ?? const Duration(minutes: 5);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'GET') {
      final cacheKey = options.uri.toString();
      final cached = _cache[cacheKey];
      
      if (cached != null && !cached.isExpired) {
        return handler.resolve(Response(
          requestOptions: options,
          data: cached.data,
          statusCode: 200,
        ));
      }
    }
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method == 'GET') {
      final cacheKey = response.requestOptions.uri.toString();
      _cache[cacheKey] = CacheEntry(
        data: response.data,
        expiry: DateTime.now().add(_cacheDuration),
      );
    }
    handler.next(response);
  }
}

class CacheEntry {
  final dynamic data;
  final DateTime expiry;
  
  CacheEntry({required this.data, required this.expiry});
  
  bool get isExpired => DateTime.now().isAfter(expiry);
}
```

### Retry Interceptor

```dart
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  
  RetryInterceptor({this.maxRetries = 3});
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
    
    // Solo retry en errores de conexión o servidor
    if (retryCount < maxRetries && _shouldRetry(err)) {
      await Future.delayed(Duration(seconds: pow(2, retryCount).toInt()));
      
      try {
        final options = err.requestOptions;
        options.extra['retryCount'] = retryCount + 1;
        
        final response = await Dio().fetch(options);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    
    handler.next(err);
  }
  
  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           (err.response?.statusCode ?? 0) >= 500;
  }
}
```

---

## 🛡️ Manejo de Errores

```dart
Future<T> safeRequest<T>(Future<Response> Function() request) async {
  try {
    final response = await request();
    return response.data as T;
  } on DioException catch (e) {
    throw _handleDioError(e);
  }
}

AppException _handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return NetworkException('Timeout de conexión');
    
    case DioExceptionType.badResponse:
      return _handleStatusCode(e.response?.statusCode, e.response?.data);
    
    case DioExceptionType.cancel:
      return RequestCancelledException();
    
    case DioExceptionType.connectionError:
      return NetworkException('Sin conexión a internet');
    
    default:
      return UnknownException(e.message ?? 'Error desconocido');
  }
}

AppException _handleStatusCode(int? statusCode, dynamic data) {
  final message = data?['message'] ?? 'Error del servidor';
  
  switch (statusCode) {
    case 400:
      return BadRequestException(message);
    case 401:
      return UnauthorizedException();
    case 403:
      return ForbiddenException();
    case 404:
      return NotFoundException(message);
    case 422:
      return ValidationException(data?['errors']);
    case 500:
      return ServerException(message);
    default:
      return UnknownException(message);
  }
}
```

---

## 📊 Cancelar Requests

```dart
class SearchService {
  final Dio _dio;
  CancelToken? _cancelToken;
  
  SearchService(this._dio);
  
  Future<List<Result>> search(String query) async {
    // Cancelar request anterior
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    
    try {
      final response = await _dio.get(
        '/search',
        queryParameters: {'q': query},
        cancelToken: _cancelToken,
      );
      return (response.data as List)
          .map((e) => Result.fromJson(e))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        return []; // Request cancelado, retornar vacío
      }
      rethrow;
    }
  }
  
  void dispose() {
    _cancelToken?.cancel();
  }
}
```

---

## 📁 Upload con Progreso

```dart
Future<void> uploadFile(File file, void Function(int, int) onProgress) async {
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    ),
  });
  
  await dio.post(
    '/upload',
    data: formData,
    onSendProgress: (sent, total) {
      onProgress(sent, total);
      print('Progreso: ${(sent / total * 100).toStringAsFixed(0)}%');
    },
  );
}
```

---

## 📥 Download con Progreso

```dart
Future<void> downloadFile(
  String url,
  String savePath,
  void Function(int, int) onProgress,
) async {
  await dio.download(
    url,
    savePath,
    onReceiveProgress: (received, total) {
      onProgress(received, total);
      if (total != -1) {
        print('Descarga: ${(received / total * 100).toStringAsFixed(0)}%');
      }
    },
  );
}
```

---

## 🔄 Comparación http vs Dio

| Feature | http | Dio |
|---------|------|-----|
| Interceptores | ❌ Manual | ✅ Integrado |
| Cancelación | ❌ No | ✅ CancelToken |
| Retry | ❌ Manual | ✅ Interceptor |
| Progreso | ⚠️ Limitado | ✅ Completo |
| FormData | ⚠️ Manual | ✅ Integrado |
| Configuración | ❌ Por request | ✅ BaseOptions |
| Tamaño | 📦 Pequeño | 📦 Mediano |

---

📅 **Semana 06** | Consumo de APIs y HTTP
