# Introducción a Dio y APIs REST

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es Dio y por qué se prefiere sobre el paquete `http` en apps de producción
- Cómo instalar Dio y configurar `BaseOptions`
- Cómo ejecutar una petición GET y leer su `Response`

## 📋 Conceptos Clave

### 1. Dio, en una frase

Dio es un cliente HTTP para Dart/Flutter construido sobre `dart:io`, con soporte de primera
clase para **interceptors**, **timeouts configurables**, **cancelación de requests**,
**`FormData`** (subida de archivos) y **transformers** — todo lo que el paquete `http` (más
básico, parte del ecosistema oficial de Dart) requiere resolver a mano.

> 💡 **`http` no es "peor"** — es deliberadamente minimalista. Dio agrega una capa de
> conveniencia pensada para apps reales con múltiples endpoints, autenticación y manejo de
> errores centralizado. Este curso usa Dio porque es el estándar de facto en apps Flutter de
> producción.

### 2. Dio vs http — comparación

| Necesidad | `http` | Dio |
|---|---|---|
| GET/POST/PUT/DELETE básicos | ✅ | ✅ |
| Interceptors (logging, auth headers automáticos) | ❌ (hay que envolver manualmente) | ✅ nativo |
| Timeouts por request | ❌ (solo `.timeout()` por Future) | ✅ en `BaseOptions` |
| Cancelar un request en curso | ❌ | ✅ `CancelToken` |
| Subir archivos (`multipart/form-data`) | Manual | ✅ `FormData` |
| Transformar/parsear la respuesta automáticamente | ❌ | ✅ `Transformer` |

### 3. Instalación

```yaml
# pubspec.yaml
dependencies:
  dio: 5.10.0
```

```bash
flutter pub add dio
```

### 4. BaseOptions — configuración centralizada

En vez de repetir la URL base y los timeouts en cada request, se configuran una sola vez al
crear la instancia de `Dio`:

```dart
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
```

- `baseUrl`: prefijo común — luego cada request solo indica el path (`/posts`, no la URL
  completa).
- `connectTimeout`: tiempo máximo para establecer la conexión.
- `receiveTimeout`: tiempo máximo esperando la respuesta una vez conectado.

> ⚠️ Sin timeouts explícitos, un request a un servidor caído puede quedar colgado
> indefinidamente — la app parece "congelada" sin ningún error visible.

### 5. Petición GET básica

```dart
Future<void> fetchPosts() async {
  final response = await dio.get('/posts');
  print(response.statusCode); // 200
  print(response.data);       // List<dynamic> ya decodificado de JSON
}
```

`response.data` llega **ya decodificado** — Dio detecta el `Content-Type: application/json` de
la respuesta y lo convierte automáticamente a `Map`/`List` de Dart. No necesitas llamar
`jsonDecode()` manualmente (a diferencia de `http`, donde `response.body` es un `String` crudo).

### 6. Response<T> — qué trae además de `data`

```dart
final response = await dio.get('/posts/1');

response.statusCode;   // int? — 200, 404, 500...
response.statusMessage; // String? — "OK", "Not Found"...
response.headers;      // Headers — headers de la respuesta
response.requestOptions; // el request original que generó esta respuesta
```

Estos campos permiten decisiones sin lanzar excepciones para casos esperados (por ejemplo, un
`statusCode == 404` que la UI debe mostrar como "no encontrado", no como un error genérico).

## ✅ Checklist de Verificación

- [ ] Puedo explicar 2 ventajas concretas de Dio sobre `http`
- [ ] Sé configurar `baseUrl` y timeouts con `BaseOptions`
- [ ] Sé ejecutar un GET y leer `response.data` y `response.statusCode`

## 📚 Próximo paso

[Interceptors y Configuración Avanzada →](02-interceptors-y-configuracion-avanzada.md)
