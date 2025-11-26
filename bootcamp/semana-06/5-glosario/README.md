# 📖 Glosario - Semana 06: Consumo de APIs y HTTP

## A

### API (Application Programming Interface)
Interfaz que permite la comunicación entre diferentes sistemas de software. En Flutter, comúnmente consumimos APIs REST para obtener y enviar datos.

### API Key
Clave única que identifica y autoriza el acceso a una API. Debe mantenerse segura y nunca exponerse en código público.

### async/await
Sintaxis de Dart para manejar operaciones asíncronas de forma legible. `async` marca una función como asíncrona y `await` pausa la ejecución hasta que el Future se complete.

```dart
Future<void> fetchData() async {
  final data = await api.getData();
}
```

### AsyncValue
Patrón que representa los tres estados posibles de una operación asíncrona: loading, data, o error. Popular en Riverpod.

---

## B

### BaseOptions
Configuración por defecto para todas las peticiones de una instancia de Dio. Incluye baseUrl, timeouts, headers predeterminados.

### Body
Contenido enviado en el cuerpo de una petición HTTP (POST, PUT, PATCH). Generalmente en formato JSON.

---

## C

### Cache
Almacenamiento temporal de datos para evitar peticiones repetidas. Mejora rendimiento y permite funcionamiento offline.

### CancelToken
En Dio, objeto que permite cancelar una petición HTTP en progreso. Útil para búsquedas donde el usuario escribe rápido.

### Content-Type
Header HTTP que indica el formato del body. Para JSON: `application/json`.

### CORS (Cross-Origin Resource Sharing)
Mecanismo de seguridad del navegador que restringe peticiones entre diferentes dominios. Relevante en Flutter Web.

### CRUD
Acrónimo para Create, Read, Update, Delete - las cuatro operaciones básicas de persistencia de datos.

---

## D

### Debounce
Técnica que retrasa la ejecución de una función hasta que pase un tiempo sin nuevas llamadas. Útil para búsquedas en tiempo real.

```dart
// Espera 500ms después del último cambio antes de buscar
Timer? _debounce;
void onSearchChanged(String query) {
  _debounce?.cancel();
  _debounce = Timer(Duration(milliseconds: 500), () => search(query));
}
```

### DELETE
Método HTTP para eliminar un recurso del servidor.

### Deserialización
Proceso de convertir datos (JSON) a objetos Dart. Opuesto a serialización.

### Dio
Popular package de Dart para HTTP con features avanzados: interceptores, FormData, cancelación, etc.

### DTO (Data Transfer Object)
Objeto que transporta datos entre procesos. Separa la estructura de la API de los modelos internos.

---

## E

### Either
Tipo funcional que representa uno de dos valores posibles: Left (error) o Right (éxito). Popular en programación funcional.

### Endpoint
URL específica de una API que proporciona acceso a un recurso particular.

### ETag
Header HTTP para caché condicional. El servidor envía un identificador único del recurso.

---

## F

### FormData
Formato para enviar datos de formulario, especialmente archivos (multipart/form-data).

### freezed
Package de Dart para generar clases inmutables con pattern matching, copyWith, y serialización JSON.

### Future
Representa un valor que estará disponible en el futuro. Resultado de operaciones asíncronas.

### FutureBuilder
Widget de Flutter que construye UI basado en el estado de un Future.

```dart
FutureBuilder<List<User>>(
  future: fetchUsers(),
  builder: (context, snapshot) {
    if (snapshot.hasData) return UserList(snapshot.data!);
    if (snapshot.hasError) return ErrorWidget();
    return LoadingWidget();
  },
);
```

---

## G

### GET
Método HTTP para obtener recursos. No debe modificar datos en el servidor.

### gzip
Algoritmo de compresión usado para reducir el tamaño de respuestas HTTP.

---

## H

### Header
Metadatos enviados con peticiones/respuestas HTTP. Ej: Authorization, Content-Type.

### HTTP (HyperText Transfer Protocol)
Protocolo de comunicación para transferir datos en la web.

### http package
Package oficial de Dart para realizar peticiones HTTP simples.

### HTTPS
Versión segura de HTTP con encriptación SSL/TLS.

---

## I

### Idempotente
Operación que produce el mismo resultado sin importar cuántas veces se ejecute. GET, PUT, DELETE son idempotentes; POST no lo es.

### Interceptor
En Dio, middleware que intercepta peticiones/respuestas para agregar lógica común (logging, auth, retry).

```dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, handler) {
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
```

---

## J

### JSON (JavaScript Object Notation)
Formato de texto ligero para intercambio de datos. Estándar de facto en APIs REST.

### json_serializable
Package de Dart que genera código para serializar/deserializar JSON automáticamente.

### jsonDecode
Función de Dart que convierte una String JSON a Map o List.

### jsonEncode
Función de Dart que convierte un Map o List a String JSON.

---

## L

### Latencia
Tiempo que tarda una petición en viajar del cliente al servidor y regresar.

### LogInterceptor
Interceptor de Dio que imprime información de peticiones/respuestas para debugging.

---

## M

### Mock
Objeto simulado que reemplaza uno real durante testing. Permite probar sin llamar APIs reales.

### MultipartFile
Representación de un archivo para subir a través de FormData.

---

## N

### NetworkException
Excepción personalizada para errores de red (sin conexión, timeout).

---

## O

### Offset Pagination
Paginación basada en número de página y cantidad por página.

---

## P

### PATCH
Método HTTP para actualizar parcialmente un recurso (solo los campos enviados).

### Payload
Datos transmitidos en el body de una petición.

### POST
Método HTTP para crear nuevos recursos.

### PUT
Método HTTP para reemplazar completamente un recurso existente.

---

## Q

### Query Parameters
Parámetros añadidos a la URL después de `?`. Ej: `/users?page=1&limit=10`.

---

## R

### Rate Limiting
Restricción en el número de peticiones permitidas en un período de tiempo.

### Repository Pattern
Patrón que abstrae el acceso a datos, separando la lógica de negocio de los detalles de implementación.

### Request
Petición HTTP enviada del cliente al servidor.

### Response
Respuesta HTTP enviada del servidor al cliente.

### REST (Representational State Transfer)
Estilo arquitectónico para diseñar APIs usando métodos HTTP estándar y URLs descriptivas.

### Result Pattern
Patrón que encapsula éxito o error en un tipo sealed, evitando excepciones.

### Retry
Reintentar una petición fallida, generalmente con espera exponencial.

---

## S

### Serialización
Proceso de convertir objetos Dart a formato JSON para enviar en peticiones.

### Status Code
Código numérico en respuestas HTTP que indica el resultado:
- 2xx: Éxito
- 3xx: Redirección
- 4xx: Error del cliente
- 5xx: Error del servidor

### StreamBuilder
Widget que construye UI basado en eventos de un Stream.

---

## T

### Throttle
Limitar la frecuencia de ejecución de una función (diferente a debounce).

### Timeout
Tiempo máximo de espera antes de considerar una petición como fallida.

### Token
Credencial de autenticación, generalmente JWT (JSON Web Token).

---

## U

### URI (Uniform Resource Identifier)
Identificador único de un recurso. En Dart, clase que representa URLs.

```dart
final uri = Uri.parse('https://api.example.com/users');
```

### URL (Uniform Resource Locator)
Dirección específica de un recurso en internet.

---

## W

### WebSocket
Protocolo de comunicación bidireccional en tiempo real entre cliente y servidor.

---

## Símbolos y Números

### 200 OK
Código de estado para petición exitosa.

### 201 Created
Código de estado cuando se crea un recurso exitosamente.

### 204 No Content
Código de estado para éxito sin contenido en respuesta.

### 400 Bad Request
Error del cliente - petición mal formada.

### 401 Unauthorized
Error de autenticación - se requiere login.

### 403 Forbidden
Error de autorización - no tienes permisos.

### 404 Not Found
El recurso solicitado no existe.

### 500 Internal Server Error
Error genérico del servidor.

---

📅 **Semana 06** | Consumo de APIs y HTTP
