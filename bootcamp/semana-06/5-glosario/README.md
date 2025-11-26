# 📖 Glosario - Semana 06

## Consumo de APIs y HTTP

### 📑 Índice Alfabético

| Término                             | Categoría    | Descripción Breve            |
| ----------------------------------- | ------------ | ---------------------------- |
| [API](#api)                         | Arquitectura | Interfaz de programación     |
| [async/await](#asyncawait)          | Dart         | Programación asíncrona       |
| [Body](#body)                       | HTTP         | Cuerpo de la petición        |
| [Cache](#cache)                     | Performance  | Almacenamiento temporal      |
| [CRUD](#crud)                       | Operaciones  | Create, Read, Update, Delete |
| [Debounce](#debounce)               | Optimización | Retraso de ejecución         |
| [Deserialización](#deserialización) | JSON         | JSON a objeto                |
| [Dio](#dio)                         | Paquete      | Cliente HTTP avanzado        |
| [Endpoint](#endpoint)               | API          | URL de recurso               |
| [Future](#future)                   | Dart         | Valor futuro asíncrono       |
| [GET](#get)                         | HTTP         | Obtener recursos             |
| [Headers](#headers)                 | HTTP         | Metadatos de petición        |
| [HTTP](#http)                       | Protocolo    | Protocolo de transferencia   |
| [Interceptor](#interceptor)         | Dio          | Middleware de peticiones     |
| [JSON](#json)                       | Formato      | Notación de objetos          |
| [POST](#post)                       | HTTP         | Crear recursos               |
| [PUT](#put)                         | HTTP         | Actualizar recursos          |
| [DELETE](#delete)                   | HTTP         | Eliminar recursos            |
| [REST](#rest)                       | Arquitectura | Estilo arquitectónico        |
| [Serialización](#serialización)     | JSON         | Objeto a JSON                |
| [Status Code](#status-code)         | HTTP         | Código de respuesta          |
| [Timeout](#timeout)                 | Network      | Tiempo de espera             |
| [URI/URL](#uriurl)                  | Network      | Identificador de recurso     |

---

## Definiciones Detalladas

### API

**Application Programming Interface**

Conjunto de reglas y protocolos que permiten que diferentes aplicaciones se comuniquen entre sí.

```dart
// Ejemplo: Consumir una API
final response = await http.get(Uri.parse('https://api.example.com/users'));
```

**Relacionado:** REST, Endpoint, HTTP

---

### async/await

**Programación Asíncrona**

Palabras clave de Dart para trabajar con operaciones asíncronas de forma legible.

```dart
// async marca la función como asíncrona
// await espera el resultado
Future<String> fetchData() async {
  final response = await http.get(url);
  return response.body;
}
```

**Relacionado:** Future, then, catchError

---

### Body

**Cuerpo de la Petición**

Datos enviados o recibidos en una petición HTTP.

```dart
// Request body (POST)
final response = await http.post(
  url,
  body: jsonEncode({'name': 'John'}),
);

// Response body
final data = jsonDecode(response.body);
```

---

### Cache

**Almacenamiento en Caché**

Almacenamiento temporal de datos para evitar peticiones repetidas.

```dart
// Ejemplo conceptual
Map<String, dynamic> _cache = {};

Future<Data> getData(String key) async {
  if (_cache.containsKey(key)) return _cache[key];
  final data = await fetchFromApi();
  _cache[key] = data;
  return data;
}
```

---

### CRUD

**Create, Read, Update, Delete**

Operaciones básicas de persistencia de datos.

```dart
// Create (POST)
http.post(url, body: data);

// Read (GET)
http.get(url);

// Update (PUT/PATCH)
http.put(url, body: data);

// Delete (DELETE)
http.delete(url);
```

---

### Debounce

**Retardo de Ejecución**

Técnica para evitar múltiples ejecuciones seguidas, esperando que el usuario termine.

```dart
Timer? _debounce;

void onSearchChanged(String query) {
  _debounce?.cancel();
  _debounce = Timer(Duration(milliseconds: 500), () {
    // Ejecutar búsqueda
  });
}
```

---

### Deserialización

**JSON a Objeto**

Proceso de convertir JSON en objetos Dart.

```dart
factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'],
    name: json['name'],
  );
}
```

**Opuesto:** Serialización

---

### Dio

**Cliente HTTP Avanzado**

Paquete de Flutter para peticiones HTTP con características avanzadas.

```dart
final dio = Dio();
dio.options.baseUrl = 'https://api.example.com';
dio.interceptors.add(LogInterceptor());

final response = await dio.get('/users');
```

**Características:** Interceptores, cancelación, FormData, timeout

---

### Endpoint

**Punto Final de API**

URL específica que representa un recurso en una API.

```
Base URL: https://api.example.com
Endpoints:
  /users     → Lista de usuarios
  /users/1   → Usuario específico
  /posts     → Lista de posts
```

---

### Future

**Valor Futuro**

Representa un valor que estará disponible en el futuro.

```dart
Future<String> fetchData() async {
  return await http.get(url).then((r) => r.body);
}

// Estados: uncompleted, completed with value, completed with error
```

---

### GET

**Método HTTP**

Solicita datos de un recurso específico. No modifica datos.

```dart
final response = await http.get(
  Uri.parse('https://api.example.com/users'),
  headers: {'Authorization': 'Bearer token'},
);
```

**Idempotente:** Sí | **Body:** No

---

### Headers

**Encabezados HTTP**

Metadatos enviados con peticiones y respuestas HTTP.

```dart
final headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $token',
  'Accept': 'application/json',
};

await http.get(url, headers: headers);
```

---

### HTTP

**HyperText Transfer Protocol**

Protocolo de comunicación para la transferencia de datos en la web.

```
Estructura de Request:
- Método (GET, POST, etc.)
- URL
- Headers
- Body (opcional)

Estructura de Response:
- Status Code
- Headers
- Body
```

---

### Interceptor

**Middleware de Peticiones**

Código que se ejecuta antes/después de cada petición HTTP.

```dart
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    // Antes de enviar
    options.headers['token'] = 'xxx';
    return handler.next(options);
  },
  onResponse: (response, handler) {
    // Después de recibir
    return handler.next(response);
  },
  onError: (error, handler) {
    // Si hay error
    return handler.next(error);
  },
));
```

---

### JSON

**JavaScript Object Notation**

Formato ligero de intercambio de datos.

```json
{
  "id": 1,
  "name": "John",
  "active": true,
  "tags": ["dart", "flutter"]
}
```

**En Dart:**

```dart
import 'dart:convert';
final map = jsonDecode(jsonString);
final json = jsonEncode(map);
```

---

### POST

**Método HTTP**

Envía datos para crear un nuevo recurso.

```dart
final response = await http.post(
  Uri.parse('https://api.example.com/users'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'name': 'John', 'email': 'john@email.com'}),
);
```

**Idempotente:** No | **Body:** Sí

---

### PUT

**Método HTTP**

Actualiza completamente un recurso existente.

```dart
await http.put(
  Uri.parse('https://api.example.com/users/1'),
  body: jsonEncode({'name': 'John Updated', 'email': 'john@new.com'}),
);
```

**Idempotente:** Sí | **Body:** Sí

---

### DELETE

**Método HTTP**

Elimina un recurso especificado.

```dart
await http.delete(Uri.parse('https://api.example.com/users/1'));
```

**Idempotente:** Sí | **Body:** Opcional

---

### REST

**Representational State Transfer**

Estilo arquitectónico para diseñar APIs web.

**Principios:**

- Interfaz uniforme
- Sin estado (stateless)
- Cacheable
- Sistema en capas
- Recursos identificables (URLs)

---

### Serialización

**Objeto a JSON**

Proceso de convertir objetos Dart a JSON.

```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
  };
}
```

**Opuesto:** Deserialización

---

### Status Code

**Código de Estado HTTP**

Número que indica el resultado de una petición.

```dart
// Categorías
200-299: Éxito
300-399: Redirección
400-499: Error del cliente
500-599: Error del servidor

// Comunes
200 OK
201 Created
400 Bad Request
401 Unauthorized
404 Not Found
500 Internal Server Error
```

---

### Timeout

**Tiempo de Espera**

Límite de tiempo para completar una operación.

```dart
final response = await http.get(url).timeout(
  Duration(seconds: 10),
  onTimeout: () => throw TimeoutException('Timeout'),
);
```

---

### URI/URL

**Uniform Resource Identifier/Locator**

Identificador único de un recurso en internet.

```dart
final uri = Uri.parse('https://api.example.com/users?page=1');

print(uri.scheme);    // https
print(uri.host);      // api.example.com
print(uri.path);      // /users
print(uri.query);     // page=1
```

---

## 📚 Referencias Rápidas

### Códigos de Estado Comunes

| Código | Significado                      |
| ------ | -------------------------------- |
| 200    | OK - Éxito                       |
| 201    | Created - Creado                 |
| 204    | No Content - Sin contenido       |
| 400    | Bad Request - Petición inválida  |
| 401    | Unauthorized - No autorizado     |
| 403    | Forbidden - Prohibido            |
| 404    | Not Found - No encontrado        |
| 500    | Server Error - Error de servidor |

### Métodos HTTP Resumen

| Método | Acción             | Idempotente | Body     |
| ------ | ------------------ | ----------- | -------- |
| GET    | Leer               | ✅          | ❌       |
| POST   | Crear              | ❌          | ✅       |
| PUT    | Reemplazar         | ✅          | ✅       |
| PATCH  | Actualizar parcial | ❌          | ✅       |
| DELETE | Eliminar           | ✅          | Opcional |

---

📅 **Semana:** 06 | 📝 **Términos:** 23
