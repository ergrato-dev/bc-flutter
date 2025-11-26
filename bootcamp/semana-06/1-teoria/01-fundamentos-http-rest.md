# 📚 Módulo 01: Fundamentos HTTP y REST

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Comprender el protocolo HTTP y su funcionamiento
- ✅ Conocer los métodos HTTP y cuándo usar cada uno
- ✅ Interpretar códigos de estado HTTP correctamente
- ✅ Entender los principios de la arquitectura REST
- ✅ Diseñar URLs siguiendo convenciones RESTful

---

## 📖 Contenido Teórico

### 1. ¿Qué es HTTP?

**HTTP (HyperText Transfer Protocol)** es el protocolo de comunicación que utilizan las aplicaciones web para intercambiar información. Es el fundamento de la comunicación de datos en la World Wide Web.

```
┌─────────────────────────────────────────────────────────────────┐
│                    COMUNICACIÓN HTTP                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│    ┌──────────┐         Request          ┌──────────┐           │
│    │          │  ───────────────────────▶ │          │           │
│    │  Cliente │                           │ Servidor │           │
│    │  (App)   │  ◀─────────────────────── │  (API)   │           │
│    │          │         Response          │          │           │
│    └──────────┘                           └──────────┘           │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

#### Características de HTTP

| Característica | Descripción |
|----------------|-------------|
| **Sin estado** | Cada petición es independiente |
| **Basado en texto** | Fácil de leer y depurar |
| **Cliente-Servidor** | Roles claramente definidos |
| **Extensible** | Soporta headers personalizados |

### 2. Anatomía de una Petición HTTP

Una petición HTTP consta de varios componentes:

```http
GET /api/users/123 HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
Accept: application/json
Content-Type: application/json

{
  "name": "John Doe"
}
```

#### Componentes

```
┌─────────────────────────────────────────────────────────────────┐
│                    REQUEST HTTP                                  │
├─────────────────────────────────────────────────────────────────┤
│  1. LÍNEA DE PETICIÓN                                           │
│     ┌──────────────────────────────────────────────────────┐    │
│     │  GET  /api/users/123  HTTP/1.1                       │    │
│     │  ↑         ↑              ↑                          │    │
│     │ Método    Path         Versión                       │    │
│     └──────────────────────────────────────────────────────┘    │
│                                                                  │
│  2. HEADERS (Metadatos)                                         │
│     ┌──────────────────────────────────────────────────────┐    │
│     │  Host: api.example.com                               │    │
│     │  Authorization: Bearer xxx                           │    │
│     │  Content-Type: application/json                      │    │
│     └──────────────────────────────────────────────────────┘    │
│                                                                  │
│  3. BODY (Opcional - datos)                                     │
│     ┌──────────────────────────────────────────────────────┐    │
│     │  { "name": "John", "email": "john@email.com" }       │    │
│     └──────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

### 3. Métodos HTTP

Los métodos HTTP definen la acción que queremos realizar sobre un recurso.

#### Tabla de Métodos

| Método | Acción | Idempotente | Body | Uso |
|--------|--------|-------------|------|-----|
| **GET** | Leer | ✅ Sí | ❌ No | Obtener datos |
| **POST** | Crear | ❌ No | ✅ Sí | Crear recursos |
| **PUT** | Reemplazar | ✅ Sí | ✅ Sí | Actualizar completo |
| **PATCH** | Modificar | ❌ No | ✅ Sí | Actualizar parcial |
| **DELETE** | Eliminar | ✅ Sí | Opcional | Borrar recursos |

#### Ejemplos por Método

##### GET - Obtener datos

```dart
/**
 * GET: Obtener lista de usuarios
 * 
 * ¿Qué hace?
 * Solicita datos de un recurso sin modificarlo
 * 
 * ¿Cuándo usar?
 * - Listar recursos
 * - Obtener detalles de un recurso
 * - Búsquedas y filtros
 */
 
// Obtener todos los usuarios
// GET /api/users

// Obtener un usuario específico
// GET /api/users/123

// Obtener con filtros
// GET /api/users?role=admin&active=true
```

##### POST - Crear recursos

```dart
/**
 * POST: Crear nuevo usuario
 * 
 * ¿Qué hace?
 * Envía datos para crear un nuevo recurso
 * 
 * ¿Cuándo usar?
 * - Crear nuevos registros
 * - Enviar formularios
 * - Acciones que no son idempotentes
 */

// Crear usuario
// POST /api/users
// Body: { "name": "John", "email": "john@email.com" }
```

##### PUT - Reemplazar completo

```dart
/**
 * PUT: Actualizar usuario completo
 * 
 * ¿Qué hace?
 * Reemplaza completamente un recurso existente
 * 
 * ¿Cuándo usar?
 * - Actualizar todos los campos de un recurso
 * - Cuando necesitas idempotencia
 */

// Actualizar usuario completo
// PUT /api/users/123
// Body: { "name": "John Updated", "email": "new@email.com" }
```

##### PATCH - Actualizar parcial

```dart
/**
 * PATCH: Actualizar campos específicos
 * 
 * ¿Qué hace?
 * Modifica solo los campos especificados
 * 
 * ¿Cuándo usar?
 * - Actualizar uno o pocos campos
 * - No quieres enviar todo el objeto
 */

// Actualizar solo el email
// PATCH /api/users/123
// Body: { "email": "new@email.com" }
```

##### DELETE - Eliminar

```dart
/**
 * DELETE: Eliminar usuario
 * 
 * ¿Qué hace?
 * Elimina un recurso del servidor
 * 
 * ¿Cuándo usar?
 * - Borrar registros
 * - Desactivar recursos
 */

// Eliminar usuario
// DELETE /api/users/123
```

### 4. Códigos de Estado HTTP

Los códigos de estado indican el resultado de una petición HTTP.

#### Categorías

```
┌─────────────────────────────────────────────────────────────────┐
│                  CÓDIGOS DE ESTADO HTTP                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1xx ─ Informativos    → Petición recibida, procesando          │
│                                                                  │
│  2xx ─ Éxito           → Petición recibida y aceptada           │
│        200 OK                                                    │
│        201 Created                                               │
│        204 No Content                                            │
│                                                                  │
│  3xx ─ Redirección     → Se requiere acción adicional           │
│        301 Moved Permanently                                     │
│        302 Found                                                 │
│        304 Not Modified                                          │
│                                                                  │
│  4xx ─ Error Cliente   → Error en la petición                   │
│        400 Bad Request                                           │
│        401 Unauthorized                                          │
│        403 Forbidden                                             │
│        404 Not Found                                             │
│        422 Unprocessable Entity                                  │
│                                                                  │
│  5xx ─ Error Servidor  → Error en el servidor                   │
│        500 Internal Server Error                                 │
│        502 Bad Gateway                                           │
│        503 Service Unavailable                                   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Códigos Más Comunes

| Código | Nombre | Significado | Acción |
|--------|--------|-------------|--------|
| 200 | OK | Petición exitosa | Procesar datos |
| 201 | Created | Recurso creado | Mostrar confirmación |
| 204 | No Content | Éxito sin contenido | Continuar |
| 400 | Bad Request | Petición malformada | Validar datos |
| 401 | Unauthorized | No autenticado | Pedir login |
| 403 | Forbidden | Sin permisos | Mostrar error |
| 404 | Not Found | Recurso no existe | Mostrar "no encontrado" |
| 422 | Unprocessable | Validación fallida | Mostrar errores |
| 500 | Server Error | Error interno | Reintentar/contactar |

#### Manejo en Dart

```dart
/**
 * handleStatusCode
 * 
 * ¿Qué hace?
 * Interpreta el código de estado y ejecuta la acción apropiada
 * 
 * ¿Para qué?
 * Centralizar el manejo de respuestas HTTP
 * 
 * ¿Cómo funciona?
 * 1. Recibe la respuesta HTTP
 * 2. Evalúa el código de estado
 * 3. Devuelve datos o lanza excepción apropiada
 */
void handleStatusCode(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      // Éxito - procesar respuesta
      return;
    case 204:
      // Éxito sin contenido
      return;
    case 400:
      throw BadRequestException('Petición inválida');
    case 401:
      throw UnauthorizedException('No autenticado');
    case 403:
      throw ForbiddenException('Sin permisos');
    case 404:
      throw NotFoundException('Recurso no encontrado');
    case 422:
      throw ValidationException('Error de validación');
    case >= 500:
      throw ServerException('Error del servidor');
    default:
      throw UnknownException('Error desconocido: ${response.statusCode}');
  }
}
```

### 5. Headers HTTP

Los headers proporcionan información adicional sobre la petición o respuesta.

#### Headers Comunes

```dart
/**
 * Headers HTTP más utilizados
 * 
 * ¿Para qué sirven?
 * - Autenticación
 * - Formato de datos
 * - Cache
 * - Metadatos
 */

final headers = {
  // Tipo de contenido que enviamos
  'Content-Type': 'application/json',
  
  // Tipo de contenido que aceptamos
  'Accept': 'application/json',
  
  // Autenticación con token
  'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIs...',
  
  // API Key (algunas APIs lo requieren)
  'X-API-Key': 'tu-api-key-aqui',
  
  // Idioma preferido
  'Accept-Language': 'es-ES',
  
  // User Agent (identificación del cliente)
  'User-Agent': 'MiApp/1.0.0',
};
```

#### Headers de Respuesta

| Header | Propósito |
|--------|-----------|
| `Content-Type` | Tipo de dato devuelto |
| `Content-Length` | Tamaño en bytes |
| `Cache-Control` | Política de cache |
| `Set-Cookie` | Establecer cookies |
| `Location` | URL de redirección |

### 6. Arquitectura REST

**REST (Representational State Transfer)** es un estilo arquitectónico para diseñar APIs web.

#### Principios REST

```
┌─────────────────────────────────────────────────────────────────┐
│                    PRINCIPIOS REST                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. CLIENTE-SERVIDOR                                            │
│     → Separación de responsabilidades                           │
│                                                                  │
│  2. SIN ESTADO (Stateless)                                      │
│     → Cada petición es independiente                            │
│     → No se guarda información del cliente                      │
│                                                                  │
│  3. CACHEABLE                                                   │
│     → Las respuestas pueden guardarse en cache                  │
│                                                                  │
│  4. INTERFAZ UNIFORME                                           │
│     → URLs predecibles para recursos                            │
│     → Métodos HTTP estándar                                     │
│                                                                  │
│  5. SISTEMA EN CAPAS                                            │
│     → El cliente no sabe si habla con el servidor final         │
│                                                                  │
│  6. CÓDIGO BAJO DEMANDA (Opcional)                              │
│     → El servidor puede enviar código ejecutable                │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Diseño de URLs RESTful

```
✅ CORRECTO (RESTful)
────────────────────────────────────────

GET    /users              → Listar usuarios
GET    /users/123          → Obtener usuario 123
POST   /users              → Crear usuario
PUT    /users/123          → Actualizar usuario 123
DELETE /users/123          → Eliminar usuario 123

GET    /users/123/posts    → Posts del usuario 123
GET    /posts?userId=123   → Posts filtrados por usuario


❌ INCORRECTO (No RESTful)
────────────────────────────────────────

GET    /getUsers           → Verbo en URL
GET    /getAllUsers        → Redundante
POST   /createUser         → Verbo en URL
GET    /user/delete/123    → GET para eliminar
POST   /users/123/update   → POST para actualizar
```

#### Ejemplo de API RESTful Completa

```
API de Blog - Diseño RESTful
────────────────────────────────────────

RECURSOS PRINCIPALES:
/users    - Usuarios
/posts    - Publicaciones
/comments - Comentarios

ENDPOINTS:

Usuarios:
GET    /users              - Listar todos
GET    /users/:id          - Obtener uno
POST   /users              - Crear
PUT    /users/:id          - Actualizar
DELETE /users/:id          - Eliminar

Posts:
GET    /posts              - Listar todos
GET    /posts/:id          - Obtener uno
POST   /posts              - Crear
PUT    /posts/:id          - Actualizar
DELETE /posts/:id          - Eliminar

Relaciones:
GET    /users/:id/posts    - Posts de un usuario
GET    /posts/:id/comments - Comentarios de un post

Filtros y Paginación:
GET    /posts?page=1&limit=10
GET    /posts?category=tech&sort=date
GET    /users?search=john&role=admin
```

### 7. Formato JSON

**JSON (JavaScript Object Notation)** es el formato estándar para intercambio de datos en APIs REST.

#### Estructura JSON

```json
{
  "string": "texto",
  "number": 42,
  "float": 3.14,
  "boolean": true,
  "null": null,
  "array": [1, 2, 3],
  "object": {
    "key": "value"
  }
}
```

#### Ejemplo Real

```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "age": 30,
  "active": true,
  "roles": ["admin", "user"],
  "profile": {
    "avatar": "https://example.com/avatar.jpg",
    "bio": "Developer"
  },
  "createdAt": "2024-01-15T10:30:00Z"
}
```

---

## 💻 Ejercicios de Comprensión

### Ejercicio 1: Identificar Métodos

Para cada acción, indica el método HTTP correcto:

1. Obtener lista de productos → `____`
2. Crear nueva orden → `____`
3. Actualizar dirección de envío → `____`
4. Cancelar pedido → `____`
5. Buscar productos por nombre → `____`

<details>
<summary>Ver respuestas</summary>

1. GET
2. POST
3. PATCH o PUT
4. DELETE (o PATCH para cambiar estado)
5. GET con query params

</details>

### Ejercicio 2: Diseñar URLs

Diseña URLs RESTful para un sistema de biblioteca:

- Libros
- Autores
- Préstamos

<details>
<summary>Ver solución</summary>

```
# Libros
GET    /books              - Listar libros
GET    /books/:id          - Obtener libro
POST   /books              - Crear libro
PUT    /books/:id          - Actualizar libro
DELETE /books/:id          - Eliminar libro

# Autores
GET    /authors            - Listar autores
GET    /authors/:id        - Obtener autor
POST   /authors            - Crear autor
GET    /authors/:id/books  - Libros de un autor

# Préstamos
GET    /loans              - Listar préstamos
POST   /loans              - Crear préstamo
PATCH  /loans/:id/return   - Devolver libro
GET    /users/:id/loans    - Préstamos de un usuario
```

</details>

### Ejercicio 3: Interpretar Códigos

¿Qué acción tomarías en tu app para cada código?

| Código | Acción |
|--------|--------|
| 200 | |
| 401 | |
| 404 | |
| 500 | |

<details>
<summary>Ver respuestas</summary>

- 200: Mostrar los datos al usuario
- 401: Redirigir a login, refrescar token
- 404: Mostrar pantalla "No encontrado"
- 500: Mostrar error, opción de reintentar

</details>

---

## 📝 Resumen

| Concepto | Puntos Clave |
|----------|--------------|
| **HTTP** | Protocolo de comunicación web |
| **Métodos** | GET, POST, PUT, PATCH, DELETE |
| **Status Codes** | 2xx éxito, 4xx error cliente, 5xx error servidor |
| **REST** | Arquitectura basada en recursos y URLs |
| **JSON** | Formato estándar de intercambio de datos |

---

## 🔗 Recursos Adicionales

- [MDN - HTTP](https://developer.mozilla.org/es/docs/Web/HTTP)
- [REST API Tutorial](https://restfulapi.net/)
- [HTTP Status Codes](https://httpstatuses.com/)
- [JSON.org](https://www.json.org/json-es.html)

---

📅 **Siguiente:** [Módulo 02 - Paquete HTTP y Dio →](./02-http-package-dio.md)
