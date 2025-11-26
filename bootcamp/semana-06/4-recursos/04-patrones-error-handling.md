# 📋 Patrones de Error Handling en APIs

## 🎯 Jerarquía de Excepciones

```dart
/// Excepción base para toda la app
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, {this.code});
  
  @override
  String toString() => message;
}

/// Errores de red y conectividad
class NetworkException extends AppException {
  const NetworkException([String message = 'Error de conexión'])
      : super(message, code: 'NETWORK_ERROR');
}

/// Errores de autenticación
class AuthException extends AppException {
  const AuthException([String message = 'Error de autenticación'])
      : super(message, code: 'AUTH_ERROR');
}

class UnauthorizedException extends AuthException {
  const UnauthorizedException() : super('No autorizado');
}

class SessionExpiredException extends AuthException {
  const SessionExpiredException() : super('Sesión expirada');
}

/// Errores del servidor
class ServerException extends AppException {
  final int? statusCode;
  
  const ServerException([
    String message = 'Error del servidor',
    this.statusCode,
  ]) : super(message, code: 'SERVER_ERROR');
}

/// Errores de validación
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;
  
  const ValidationException([
    String message = 'Error de validación',
    this.errors,
  ]) : super(message, code: 'VALIDATION_ERROR');
}

/// Recurso no encontrado
class NotFoundException extends AppException {
  const NotFoundException([String message = 'Recurso no encontrado'])
      : super(message, code: 'NOT_FOUND');
}

/// Request cancelado
class CancelledException extends AppException {
  const CancelledException() : super('Operación cancelada', code: 'CANCELLED');
}
```

---

## 🔧 Result Pattern

```dart
/// Sealed class para manejar resultados
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppException exception;
  const Failure(this.exception);
}

// Uso
Future<Result<User>> getUser(int id) async {
  try {
    final response = await dio.get('/users/$id');
    return Success(User.fromJson(response.data));
  } on DioException catch (e) {
    return Failure(_mapDioException(e));
  }
}

// En la UI
final result = await userService.getUser(1);

switch (result) {
  case Success(:final data):
    setState(() => user = data);
  case Failure(:final exception):
    showError(exception.message);
}
```

---

## 🛡️ Either Pattern (Funcional)

```dart
// Con dartz package
import 'package:dartz/dartz.dart';

typedef ApiResult<T> = Either<AppException, T>;

Future<ApiResult<User>> getUser(int id) async {
  try {
    final response = await dio.get('/users/$id');
    return Right(User.fromJson(response.data));
  } on DioException catch (e) {
    return Left(_mapDioException(e));
  }
}

// Uso
final result = await userService.getUser(1);

result.fold(
  (exception) => showError(exception.message),
  (user) => setState(() => this.user = user),
);

// O con pattern matching
result.match(
  onLeft: (e) => ErrorWidget(e.message),
  onRight: (user) => UserCard(user),
);
```

---

## 🎯 AsyncValue Pattern (Riverpod Style)

```dart
/// Estado que puede estar loading, con data, o con error
sealed class AsyncValue<T> {
  const AsyncValue();
  
  bool get isLoading => this is AsyncLoading<T>;
  bool get hasData => this is AsyncData<T>;
  bool get hasError => this is AsyncError<T>;
  
  T? get dataOrNull => hasData ? (this as AsyncData<T>).data : null;
  
  Widget when({
    required Widget Function(T data) data,
    required Widget Function() loading,
    required Widget Function(Object error) error,
  }) {
    return switch (this) {
      AsyncData(:final data) => data(data),
      AsyncLoading() => loading(),
      AsyncError(:final error) => error(error),
    };
  }
}

class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading();
}

class AsyncData<T> extends AsyncValue<T> {
  final T data;
  const AsyncData(this.data);
}

class AsyncError<T> extends AsyncValue<T> {
  final Object error;
  final StackTrace? stackTrace;
  const AsyncError(this.error, [this.stackTrace]);
}

// Uso en Provider
class UserProvider extends ChangeNotifier {
  AsyncValue<User> state = const AsyncLoading();
  
  Future<void> loadUser(int id) async {
    state = const AsyncLoading();
    notifyListeners();
    
    try {
      final user = await _service.getUser(id);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
    notifyListeners();
  }
}

// Uso en Widget
Widget build(BuildContext context) {
  return userProvider.state.when(
    loading: () => CircularProgressIndicator(),
    data: (user) => UserCard(user: user),
    error: (e) => ErrorWidget(message: e.toString()),
  );
}
```

---

## 📊 API Response Wrapper

```dart
/// Wrapper para respuestas de API
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final Map<String, dynamic>? errors;
  final int? statusCode;
  
  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errors,
    this.statusCode,
  });
  
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJson,
  ) {
    return ApiResponse(
      success: json['success'] ?? false,
      data: json['data'] != null && fromJson != null
          ? fromJson(json['data'])
          : json['data'],
      message: json['message'],
      errors: json['errors'],
    );
  }
  
  bool get hasError => !success || errors != null;
}

// Uso
final response = await dio.get('/users/1');
final apiResponse = ApiResponse.fromJson(
  response.data,
  (data) => User.fromJson(data),
);

if (apiResponse.success) {
  return apiResponse.data!;
} else {
  throw ServerException(apiResponse.message ?? 'Error desconocido');
}
```

---

## 🔄 Global Error Handler

```dart
class ErrorHandler {
  static void handle(Object error, {StackTrace? stackTrace}) {
    // Logging
    _logError(error, stackTrace);
    
    // Analytics
    _trackError(error, stackTrace);
    
    // Mostrar al usuario
    _showUserFriendlyError(error);
  }
  
  static void _logError(Object error, StackTrace? stackTrace) {
    debugPrint('Error: $error');
    if (stackTrace != null) {
      debugPrint('StackTrace: $stackTrace');
    }
  }
  
  static void _trackError(Object error, StackTrace? stackTrace) {
    // Enviar a Crashlytics, Sentry, etc.
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
  
  static void _showUserFriendlyError(Object error) {
    final message = _getUserMessage(error);
    // Mostrar snackbar, dialog, etc.
    _showSnackBar(message);
  }
  
  static String _getUserMessage(Object error) {
    if (error is AppException) {
      return error.message;
    }
    
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return 'La conexión tardó demasiado. Intenta de nuevo.';
        case DioExceptionType.connectionError:
          return 'Sin conexión a internet. Verifica tu conexión.';
        default:
          return 'Ocurrió un error. Intenta de nuevo.';
      }
    }
    
    return 'Ocurrió un error inesperado.';
  }
}

// Uso global
void main() {
  runZonedGuarded(
    () => runApp(const MyApp()),
    (error, stack) => ErrorHandler.handle(error, stackTrace: stack),
  );
}
```

---

## 🎨 UI Error Widgets

```dart
/// Widget de error reutilizable
class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;
  
  const ErrorDisplay({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });
  
  factory ErrorDisplay.network({VoidCallback? onRetry}) {
    return ErrorDisplay(
      message: 'Sin conexión a internet',
      icon: Icons.wifi_off,
      onRetry: onRetry,
    );
  }
  
  factory ErrorDisplay.server({VoidCallback? onRetry}) {
    return ErrorDisplay(
      message: 'Error del servidor. Intenta más tarde.',
      icon: Icons.cloud_off,
      onRetry: onRetry,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## ✅ Checklist de Error Handling

```
□ Definir jerarquía de excepciones
□ Mapear errores de HTTP a excepciones
□ Implementar Result/Either pattern
□ Crear widgets de error reutilizables
□ Configurar logging de errores
□ Integrar analytics de crashes
□ Manejar errores de red gracefully
□ Mostrar mensajes user-friendly
□ Implementar retry automático
□ Manejar sesiones expiradas
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
