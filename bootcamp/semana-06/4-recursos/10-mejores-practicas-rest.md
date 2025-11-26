# 📋 Mejores Prácticas REST

## 🎯 Diseño de URLs

### Convenciones

```
✅ BIEN
GET  /users              → Lista de usuarios
GET  /users/123          → Usuario específico
GET  /users/123/posts    → Posts de un usuario
POST /users              → Crear usuario
PUT  /users/123          → Actualizar usuario completo
PATCH /users/123         → Actualizar parcialmente
DELETE /users/123        → Eliminar usuario

❌ MAL
GET  /getUsers
GET  /user/get/123
POST /createUser
GET  /users/delete/123
```

### Nomenclatura

```
✅ Plural para colecciones
/users, /posts, /comments

✅ Sustantivos, no verbos
/users (no /getUsers)

✅ Kebab-case para múltiples palabras
/user-profiles (no /userProfiles)

✅ IDs en la ruta, filtros en query
/users/123
/users?role=admin&status=active
```

---

## 📊 Query Parameters

### Filtrado

```dart
// Múltiples filtros
final uri = Uri.parse('$baseUrl/users').replace(
  queryParameters: {
    'status': 'active',
    'role': 'admin',
    'department': 'engineering',
  },
);
// /users?status=active&role=admin&department=engineering
```

### Paginación

```dart
// Offset-based
/users?offset=0&limit=20
/users?page=1&per_page=20

// Cursor-based (más eficiente para grandes datasets)
/users?cursor=abc123&limit=20
```

### Ordenamiento

```dart
// Simple
/users?sort=created_at
/users?sort=-created_at  // Descendente

// Múltiple
/users?sort=status,-created_at
```

### Selección de Campos

```dart
// Solo ciertos campos
/users?fields=id,name,email

// Expandir relaciones
/users?expand=posts,comments
/users?include=profile
```

---

## 🔧 Implementación en Flutter

### Service Layer Limpio

```dart
abstract class UserService {
  Future<List<User>> getUsers({
    int page = 1,
    int limit = 20,
    String? status,
    String? sortBy,
  });

  Future<User> getUser(String id);
  Future<User> createUser(CreateUserDto dto);
  Future<User> updateUser(String id, UpdateUserDto dto);
  Future<void> deleteUser(String id);
}

class UserServiceImpl implements UserService {
  final Dio _dio;

  UserServiceImpl(this._dio);

  @override
  Future<List<User>> getUsers({
    int page = 1,
    int limit = 20,
    String? status,
    String? sortBy,
  }) async {
    final response = await _dio.get(
      '/users',
      queryParameters: {
        'page': page,
        'limit': limit,
        if (status != null) 'status': status,
        if (sortBy != null) 'sort': sortBy,
      },
    );

    return (response.data as List)
        .map((json) => User.fromJson(json))
        .toList();
  }

  // ... otros métodos
}
```

### DTOs (Data Transfer Objects)

```dart
// Separar modelos de request y response
class CreateUserDto {
  final String name;
  final String email;
  final String password;

  const CreateUserDto({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };
}

class UpdateUserDto {
  final String? name;
  final String? email;

  const UpdateUserDto({this.name, this.email});

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (email != null) 'email': email,
  };
}
```

### Repository Pattern

```dart
abstract class UserRepository {
  Future<Result<List<User>>> getUsers();
  Future<Result<User>> getUser(String id);
  Future<Result<User>> createUser(CreateUserDto dto);
  Future<Result<void>> deleteUser(String id);
}

class UserRepositoryImpl implements UserRepository {
  final UserService _service;
  final CacheService _cache;

  UserRepositoryImpl(this._service, this._cache);

  @override
  Future<Result<List<User>>> getUsers() async {
    try {
      // Intentar caché
      final cached = await _cache.getUsers();
      if (cached != null) {
        return Success(cached);
      }

      // Fetch de red
      final users = await _service.getUsers();
      await _cache.saveUsers(users);
      return Success(users);
    } catch (e) {
      return Failure(_mapException(e));
    }
  }
}
```

---

## 📦 Response Structures

### Respuesta de Lista

```json
{
  "data": [...],
  "meta": {
    "page": 1,
    "per_page": 20,
    "total": 100,
    "total_pages": 5
  },
  "links": {
    "self": "/users?page=1",
    "next": "/users?page=2",
    "prev": null,
    "first": "/users?page=1",
    "last": "/users?page=5"
  }
}
```

```dart
class PaginatedResponse<T> {
  final List<T> data;
  final PaginationMeta meta;
  final PaginationLinks? links;

  bool get hasNextPage => meta.page < meta.totalPages;
}
```

### Respuesta de Error

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input",
    "details": {
      "email": ["Email is required", "Must be valid email"],
      "password": ["Must be at least 8 characters"]
    }
  }
}
```

```dart
class ApiError {
  final String code;
  final String message;
  final Map<String, List<String>>? details;

  factory ApiError.fromJson(Map<String, dynamic> json) {
    final error = json['error'];
    return ApiError(
      code: error['code'],
      message: error['message'],
      details: error['details']?.cast<String, List<String>>(),
    );
  }
}
```

---

## ⚡ Optimizaciones

### Batch Requests

```dart
// En lugar de múltiples requests
for (final id in ids) {
  await api.getUser(id);  // ❌ N requests
}

// Usar endpoint de batch
await api.getUsers(ids: ids);  // ✅ 1 request
// GET /users?ids=1,2,3,4,5
```

### Conditional Requests

```dart
// Usar ETag/If-None-Match
final response = await dio.get(
  '/users',
  options: Options(
    headers: {
      'If-None-Match': cachedETag,
    },
  ),
);

if (response.statusCode == 304) {
  // Usar datos cacheados
}
```

### Compresión

```dart
// Aceptar compresión gzip
final dio = Dio(BaseOptions(
  headers: {
    'Accept-Encoding': 'gzip, deflate',
  },
));
```

---

## ✅ Checklist

```
□ URLs usan sustantivos en plural
□ Métodos HTTP correctos (GET, POST, PUT, PATCH, DELETE)
□ Query params para filtros, paginación, ordenamiento
□ Códigos de estado HTTP apropiados
□ Respuestas consistentes (data, error, meta)
□ Manejo de errores estructurado
□ Versionado de API (/v1/, /v2/)
□ Rate limiting considerado
□ Caché implementado donde corresponde
□ DTOs separados para request/response
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
