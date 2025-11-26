# 📋 Guía Rápida: http Package

## 🚀 Setup

```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0
```

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
```

---

## 🔧 Operaciones Básicas

### GET Request

```dart
Future<List<User>> fetchUsers() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/users'),
  );
  
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}
```

### GET con Query Parameters

```dart
final uri = Uri.parse('https://api.example.com/users').replace(
  queryParameters: {
    'page': '1',
    'limit': '10',
    'sort': 'name',
  },
);
// Resultado: https://api.example.com/users?page=1&limit=10&sort=name

final response = await http.get(uri);
```

### POST Request

```dart
Future<User> createUser(String name, String email) async {
  final response = await http.post(
    Uri.parse('https://api.example.com/users'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'email': email,
    }),
  );
  
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al crear usuario');
  }
}
```

### PUT Request

```dart
Future<User> updateUser(int id, User user) async {
  final response = await http.put(
    Uri.parse('https://api.example.com/users/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(user.toJson()),
  );
  
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al actualizar');
  }
}
```

### PATCH Request

```dart
Future<User> patchUser(int id, Map<String, dynamic> changes) async {
  final response = await http.patch(
    Uri.parse('https://api.example.com/users/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(changes),
  );
  
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al actualizar');
  }
}
```

### DELETE Request

```dart
Future<void> deleteUser(int id) async {
  final response = await http.delete(
    Uri.parse('https://api.example.com/users/$id'),
  );
  
  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Error al eliminar');
  }
}
```

---

## 🔐 Headers y Autenticación

### Headers Personalizados

```dart
final response = await http.get(
  Uri.parse('https://api.example.com/data'),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
    'X-API-Key': apiKey,
    'User-Agent': 'MyApp/1.0',
  },
);
```

### Cliente Reutilizable

```dart
class ApiClient {
  final http.Client _client = http.Client();
  final String _baseUrl = 'https://api.example.com';
  String? _token;
  
  void setToken(String token) => _token = token;
  
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };
  
  Future<http.Response> get(String path) {
    return _client.get(
      Uri.parse('$_baseUrl$path'),
      headers: _headers,
    );
  }
  
  Future<http.Response> post(String path, Map<String, dynamic> body) {
    return _client.post(
      Uri.parse('$_baseUrl$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
  }
  
  void dispose() => _client.close();
}
```

---

## ⏱️ Timeout

```dart
final response = await http.get(
  Uri.parse('https://api.example.com/data'),
).timeout(
  const Duration(seconds: 10),
  onTimeout: () {
    throw TimeoutException('La solicitud tardó demasiado');
  },
);
```

---

## 🛡️ Manejo de Errores

```dart
Future<T> safeRequest<T>(
  Future<http.Response> Function() request,
  T Function(dynamic json) parser,
) async {
  try {
    final response = await request().timeout(
      const Duration(seconds: 30),
    );
    
    switch (response.statusCode) {
      case 200:
      case 201:
        return parser(jsonDecode(response.body));
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorizedException();
      case 403:
        throw ForbiddenException();
      case 404:
        throw NotFoundException();
      case 500:
        throw ServerException();
      default:
        throw HttpException('Error: ${response.statusCode}');
    }
  } on SocketException {
    throw NetworkException('Sin conexión a internet');
  } on TimeoutException {
    throw NetworkException('Timeout de conexión');
  } on FormatException {
    throw ParseException('Error al parsear respuesta');
  }
}
```

---

## 📁 Subir Archivos

```dart
Future<void> uploadFile(File file) async {
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('https://api.example.com/upload'),
  );
  
  request.headers['Authorization'] = 'Bearer $token';
  
  request.files.add(await http.MultipartFile.fromPath(
    'file',
    file.path,
    filename: 'image.jpg',
  ));
  
  request.fields['description'] = 'Mi imagen';
  
  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  
  if (response.statusCode != 200) {
    throw Exception('Error al subir archivo');
  }
}
```

---

## 🔄 Retry Pattern

```dart
Future<http.Response> getWithRetry(
  String url, {
  int maxRetries = 3,
}) async {
  int attempts = 0;
  
  while (attempts < maxRetries) {
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return response;
      }
      
      // Solo retry en errores de servidor
      if (response.statusCode < 500) {
        return response;
      }
    } catch (e) {
      attempts++;
      if (attempts >= maxRetries) rethrow;
    }
    
    // Espera exponencial
    await Future.delayed(Duration(seconds: pow(2, attempts).toInt()));
    attempts++;
  }
  
  throw Exception('Max retries exceeded');
}
```

---

## 📊 Patrones Comunes

### Service Completo

```dart
class UserService {
  static const _baseUrl = 'https://api.example.com';
  final http.Client _client;
  
  UserService({http.Client? client}) : _client = client ?? http.Client();
  
  Future<List<User>> getUsers({int page = 1, int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl/users').replace(
      queryParameters: {'page': '$page', 'limit': '$limit'},
    );
    
    final response = await _client.get(uri);
    
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => User.fromJson(e)).toList();
    }
    
    throw _handleError(response);
  }
  
  Exception _handleError(http.Response response) {
    final body = jsonDecode(response.body);
    return Exception(body['message'] ?? 'Error desconocido');
  }
  
  void dispose() => _client.close();
}
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
