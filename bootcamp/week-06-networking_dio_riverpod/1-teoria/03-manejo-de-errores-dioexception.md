# Manejo de Errores con DioException

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué Dio lanza `DioException` en vez de retornar `null` o un código de error
- Los tipos de `DioExceptionType` más comunes y qué representa cada uno
- Cómo capturar `DioException` y convertirla en un mensaje entendible para la UI

## 📋 Conceptos Clave

### 1. Dio lanza excepciones, no retorna null

Cuando un request falla (sin conexión, timeout, o el servidor responde 4xx/5xx), Dio **lanza**
una `DioException` — no retorna `null` ni un `Response` vacío. Esto obliga a manejar el error
explícitamente con `try`/`catch`, en vez de arriesgarte a un `NoSuchMethodError` sobre un `null`
olvidado.

```dart
try {
  final response = await dio.get('/posts');
  return response.data;
} on DioException catch (e) {
  // toda la lógica de manejo de errores vive acá
  rethrow;
}
```

### 2. DioExceptionType — qué falló, exactamente

`DioException` trae un campo `.type` que clasifica la falla:

| `DioExceptionType` | Cuándo ocurre |
|---|---|
| `connectionTimeout` | No se pudo conectar al servidor dentro de `connectTimeout` |
| `receiveTimeout` | Se conectó, pero no llegó respuesta dentro de `receiveTimeout` |
| `badResponse` | El servidor respondió, pero con un status code de error (4xx/5xx) |
| `connectionError` | Sin conexión a internet, DNS no resuelve, etc. |
| `cancel` | El request fue cancelado explícitamente con un `CancelToken` |
| `unknown` | Cualquier otro error no clasificado |

```dart
try {
  final response = await dio.get('/posts');
} on DioException catch (e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
      throw Exception('El servidor tardó demasiado en responder');
    case DioExceptionType.connectionError:
      throw Exception('Sin conexión a internet');
    case DioExceptionType.badResponse:
      throw Exception('Error del servidor (${e.response?.statusCode})');
    default:
      throw Exception('Ocurrió un error inesperado');
  }
}
```

> 💡 **No muestres `e.toString()` directo en la UI.** El mensaje crudo de `DioException` está
> en inglés, expone detalles técnicos (URLs, stack traces) y es ilegible para el usuario final.
> Siempre tradúcelo a un mensaje propio, como en el ejemplo de arriba.

### 3. badResponse — inspeccionar el status code

Cuando el tipo es `badResponse`, el `Response` original sigue disponible en `e.response`:

```dart
if (e.type == DioExceptionType.badResponse) {
  final statusCode = e.response?.statusCode;
  if (statusCode == 404) {
    throw Exception('El recurso no existe');
  }
  if (statusCode == 500) {
    throw Exception('Error interno del servidor');
  }
}
```

Esto permite distinguir "el elemento que buscabas no existe" (404, un caso esperado de la UI) de
"el servidor está caído" (500, un caso genuinamente excepcional).

### 4. rethrow vs lanzar un error propio

```dart
} on DioException catch (e) {
  rethrow; // propaga la MISMA excepción, con su stack trace original
}

} on DioException catch (e) {
  throw Exception('Mensaje traducido'); // reemplaza la excepción por una nueva
}
```

En un repository (archivo 4), la convención de este curso es **capturar `DioException` y
relanzar una excepción propia con mensaje traducido** — así el `AsyncNotifier` que consume el
repository nunca necesita saber que Dio existe.

## ✅ Checklist de Verificación

- [ ] Sé explicar por qué Dio usa excepciones en vez de retornar `null`
- [ ] Conozco al menos 4 valores de `DioExceptionType` y cuándo ocurre cada uno
- [ ] Sé distinguir `badResponse` con status 404 de uno con status 500
- [ ] Entiendo por qué no se debe mostrar `e.toString()` directamente en la UI

## 📚 Próximo paso

[Repository Pattern con Dio →](04-repository-pattern-con-dio.md)
