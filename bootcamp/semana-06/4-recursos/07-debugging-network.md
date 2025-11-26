# 🔍 Debugging de Peticiones HTTP

## 🛠️ Herramientas Esenciales

### 1. DevTools Network Tab

Flutter DevTools incluye una pestaña Network para inspeccionar peticiones.

```bash
# Abrir DevTools
flutter pub global activate devtools
devtools
```

**Características:**

- Ver todas las peticiones HTTP
- Inspeccionar headers y body
- Ver tiempo de respuesta
- Filtrar por estado

---

### 2. Logging Interceptor (Dio)

```dart
final dio = Dio();

// Logging básico
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

### Logging Personalizado

```dart
class PrettyLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('╔══════════════════════════════════════════════════════════');
    debugPrint('║ REQUEST: ${options.method} ${options.uri}');
    debugPrint('╠══════════════════════════════════════════════════════════');
    debugPrint('║ Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('║ Body: ${options.data}');
    }
    debugPrint('╚══════════════════════════════════════════════════════════');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('╔══════════════════════════════════════════════════════════');
    debugPrint('║ RESPONSE: ${response.statusCode}');
    debugPrint('╠══════════════════════════════════════════════════════════');
    debugPrint('║ Data: ${_prettyJson(response.data)}');
    debugPrint('╚══════════════════════════════════════════════════════════');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('╔══════════════════════════════════════════════════════════');
    debugPrint('║ ❌ ERROR: ${err.type}');
    debugPrint('╠══════════════════════════════════════════════════════════');
    debugPrint('║ Message: ${err.message}');
    debugPrint('║ Response: ${err.response?.data}');
    debugPrint('╚══════════════════════════════════════════════════════════');
    handler.next(err);
  }

  String _prettyJson(dynamic json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (e) {
      return json.toString();
    }
  }
}
```

---

### 3. Charles Proxy / Proxyman

Herramientas para interceptar tráfico HTTP/HTTPS.

**Charles Proxy:** https://www.charlesproxy.com/
**Proxyman:** https://proxyman.io/

```dart
// Configurar proxy en Dio
final dio = Dio();
(dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
  client.findProxy = (uri) => 'PROXY localhost:8888';
  // Ignorar certificados para debug
  client.badCertificateCallback = (cert, host, port) => true;
  return client;
};
```

---

### 4. cURL Export

Exportar requests como cURL para testing.

```dart
extension DioRequestToCurl on RequestOptions {
  String toCurl() {
    final components = ['curl -X $method'];

    headers.forEach((key, value) {
      components.add("-H '$key: $value'");
    });

    if (data != null) {
      final body = data is String ? data : jsonEncode(data);
      components.add("-d '$body'");
    }

    components.add("'$uri'");

    return components.join(' \\\n  ');
  }
}

// En interceptor
debugPrint('cURL: ${options.toCurl()}');
```

**Salida:**

```bash
curl -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer token123' \
  -d '{"name": "John"}' \
  'https://api.example.com/users'
```

---

## 🔎 Debugging de Errores Comunes

### Error de Conexión

```dart
// Verificar conectividad
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasConnection() async {
  final result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
}

// Antes de hacer request
if (!await hasConnection()) {
  throw NetworkException('Sin conexión a internet');
}
```

### Error de Certificado SSL

```dart
// SOLO PARA DEBUG - Nunca en producción
(dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
  client.badCertificateCallback = (cert, host, port) => true;
  return client;
};
```

### Timeout Debugging

```dart
class TimeoutDebugInterceptor extends Interceptor {
  final _stopwatch = Stopwatch();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _stopwatch.reset();
    _stopwatch.start();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _stopwatch.stop();
    debugPrint('⏱️ Request took: ${_stopwatch.elapsedMilliseconds}ms');

    if (_stopwatch.elapsedMilliseconds > 5000) {
      debugPrint('⚠️ WARNING: Slow request detected!');
    }

    handler.next(response);
  }
}
```

### Error de Parsing

```dart
T safeJsonDecode<T>(String source, T Function(Map<String, dynamic>) parser) {
  try {
    final json = jsonDecode(source);
    debugPrint('📦 Raw JSON: $json');
    return parser(json);
  } on FormatException catch (e) {
    debugPrint('❌ JSON Parse Error: $e');
    debugPrint('📄 Raw response: $source');
    rethrow;
  } on TypeError catch (e) {
    debugPrint('❌ Type Error: $e');
    rethrow;
  }
}
```

---

## 📊 Network Mock para Testing

```dart
// Mock client para tests
class MockHttpClient extends Mock implements http.Client {}

// Usando mockito
void main() {
  late MockHttpClient mockClient;
  late UserService userService;

  setUp(() {
    mockClient = MockHttpClient();
    userService = UserService(client: mockClient);
  });

  test('fetchUsers returns list of users', () async {
    // Arrange
    when(mockClient.get(any)).thenAnswer((_) async => http.Response(
      jsonEncode([{'id': 1, 'name': 'John'}]),
      200,
    ));

    // Act
    final users = await userService.fetchUsers();

    // Assert
    expect(users.length, 1);
    expect(users.first.name, 'John');
  });
}
```

---

## 🎯 Checklist de Debugging

```
□ Verificar URL correcta
□ Verificar headers (especialmente Content-Type)
□ Verificar body del request
□ Revisar status code de respuesta
□ Revisar body de respuesta
□ Verificar conectividad a internet
□ Verificar certificados SSL
□ Revisar timeouts configurados
□ Probar con Postman/Insomnia primero
□ Exportar como cURL y probar en terminal
```

---

## 🔧 Herramientas Recomendadas

| Herramienta      | Uso               | Plataforma    |
| ---------------- | ----------------- | ------------- |
| Flutter DevTools | Debugging general | Todas         |
| Charles Proxy    | Inspección HTTP   | Mac/Win/Linux |
| Proxyman         | Inspección HTTP   | Mac           |
| Postman          | Testing APIs      | Todas         |
| Insomnia         | Testing APIs      | Todas         |
| HTTPie           | cURL alternativo  | Terminal      |

---

📅 **Semana 06** | Consumo de APIs y HTTP
