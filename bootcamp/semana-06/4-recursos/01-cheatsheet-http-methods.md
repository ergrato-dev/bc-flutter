# 📋 Cheatsheet: Métodos HTTP

## 🎯 Referencia Rápida

### Métodos HTTP y sus Usos

| Método | Propósito | Body | Idempotente | Cacheable |
|--------|-----------|------|-------------|-----------|
| **GET** | Obtener recursos | ❌ No | ✅ Sí | ✅ Sí |
| **POST** | Crear recursos | ✅ Sí | ❌ No | ⚠️ Raramente |
| **PUT** | Reemplazar completo | ✅ Sí | ✅ Sí | ❌ No |
| **PATCH** | Actualizar parcial | ✅ Sí | ❌ No | ❌ No |
| **DELETE** | Eliminar recursos | ⚠️ Opcional | ✅ Sí | ❌ No |
| **HEAD** | Solo headers | ❌ No | ✅ Sí | ✅ Sí |
| **OPTIONS** | Opciones permitidas | ❌ No | ✅ Sí | ❌ No |

---

## 📊 Códigos de Estado HTTP

### 2xx - Éxito ✅

```
200 OK              → Solicitud exitosa
201 Created         → Recurso creado (POST)
204 No Content      → Éxito sin contenido (DELETE)
```

### 3xx - Redirección 🔄

```
301 Moved Permanently  → URL cambió permanentemente
302 Found              → Redirección temporal
304 Not Modified       → Usar cache
```

### 4xx - Error del Cliente ⚠️

```
400 Bad Request        → Solicitud mal formada
401 Unauthorized       → No autenticado
403 Forbidden          → Sin permisos
404 Not Found          → Recurso no existe
422 Unprocessable      → Validación falló
429 Too Many Requests  → Rate limit excedido
```

### 5xx - Error del Servidor ❌

```
500 Internal Server Error  → Error genérico
502 Bad Gateway            → Proxy/gateway error
503 Service Unavailable    → Servicio no disponible
504 Gateway Timeout        → Timeout del gateway
```

---

## 🔧 Headers Comunes

### Request Headers

```http
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>
User-Agent: MyApp/1.0
Cache-Control: no-cache
```

### Response Headers

```http
Content-Type: application/json
Content-Length: 1234
Cache-Control: max-age=3600
X-Rate-Limit-Remaining: 99
```

---

## 🎯 Patrones REST

### URLs por Recurso

```
GET    /users          → Listar usuarios
GET    /users/123      → Obtener usuario 123
POST   /users          → Crear usuario
PUT    /users/123      → Reemplazar usuario 123
PATCH  /users/123      → Actualizar campos de usuario 123
DELETE /users/123      → Eliminar usuario 123
```

### URLs Anidadas

```
GET    /users/123/posts      → Posts del usuario 123
POST   /users/123/posts      → Crear post para usuario 123
GET    /posts/456/comments   → Comentarios del post 456
```

---

## 💻 Dart/Flutter Quick Reference

### GET

```dart
// http package
final response = await http.get(Uri.parse('$baseUrl/users'));

// Dio
final response = await dio.get('/users');
```

### POST

```dart
// http package
final response = await http.post(
  Uri.parse('$baseUrl/users'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'name': 'John'}),
);

// Dio
final response = await dio.post('/users', data: {'name': 'John'});
```

### PUT

```dart
// http package
final response = await http.put(
  Uri.parse('$baseUrl/users/1'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'name': 'John', 'email': 'john@example.com'}),
);

// Dio
final response = await dio.put('/users/1', data: {...});
```

### DELETE

```dart
// http package
final response = await http.delete(Uri.parse('$baseUrl/users/1'));

// Dio
final response = await dio.delete('/users/1');
```

---

## ⚡ Decision Tree

```
¿Qué quieres hacer?
│
├── Obtener datos → GET
│   ├── Lista → GET /recursos
│   └── Detalle → GET /recursos/{id}
│
├── Crear nuevo → POST /recursos
│
├── Modificar existente
│   ├── Reemplazar todo → PUT /recursos/{id}
│   └── Solo algunos campos → PATCH /recursos/{id}
│
└── Eliminar → DELETE /recursos/{id}
```

---

## 🔐 Autenticación

### Bearer Token

```dart
headers: {'Authorization': 'Bearer $token'}
```

### API Key

```dart
// En header
headers: {'X-API-Key': apiKey}

// En query
Uri.parse('$baseUrl/data?api_key=$apiKey')
```

### Basic Auth

```dart
import 'dart:convert';
final credentials = base64Encode(utf8.encode('$username:$password'));
headers: {'Authorization': 'Basic $credentials'}
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
