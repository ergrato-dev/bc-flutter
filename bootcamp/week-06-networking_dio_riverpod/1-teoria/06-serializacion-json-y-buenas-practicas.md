# Serialización JSON y Buenas Prácticas

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo escribir un `fromJson` manual robusto ante datos inesperados
- Las buenas prácticas de networking que cierran esta semana
- Errores comunes al integrar Dio + Riverpod en mobile

## 📋 Conceptos Clave

### 1. fromJson manual

Este curso aún no introduce generación de código para modelos (`json_serializable` llega más
adelante) — por ahora, `fromJson` se escribe a mano como un constructor factory:

```dart
class Item {
  final String id;
  final String name;
  final String description;

  const Item({required this.id, required this.name, required this.description});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'].toString(),
      name: json['title'] as String? ?? '',
      description: json['body'] as String? ?? '',
    );
  }
}
```

Puntos clave:

- `json['id'].toString()`: las APIs REST suelen retornar IDs numéricos (`int`) donde tu modelo
  espera `String` — convertir explícitamente evita un `TypeError` en runtime.
- `as String? ?? ''`: castea con `?` (nullable) y da un valor por defecto — si el campo viene
  `null` o falta, la app no crashea, solo muestra un valor vacío.
- **Nunca uses `as String` sin el `?`** contra datos de una API externa — no controlas ese
  contrato, y un campo faltante lanza una excepción no capturada en medio del parseo.

### 2. Parsear una lista completa

```dart
final items = (response.data as List)
    .map((json) => Item.fromJson(json as Map<String, dynamic>))
    .toList();
```

Si un solo elemento de la lista tiene un formato inesperado, este patrón falla **toda la lista**
completa (una excepción dentro de `.map()` se propaga). Para una API que controlas y confías,
esto es aceptable — el archivo de proyecto (semana 6) documenta cuándo valdría la pena envolver
cada elemento individualmente en un `try`/`catch` (omitir el elemento roto, no toda la lista).

### 3. No hardcodear URLs dispersas

```dart
// ❌ MAL — la URL base repetida en cada archivo que la necesita
final response = await Dio().get('https://jsonplaceholder.typicode.com/posts');

// ✅ BIEN — un solo lugar de verdad
final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
final response = await dio.get('/posts');
```

`baseUrl` centralizado en `dioProvider` (archivo 2) es el único lugar que cambia si la API
migra de dominio o versión (`/v1/` → `/v2/`).

### 4. No exponer Dio a la UI

Un widget **nunca** debe importar `package:dio/dio.dart` ni conocer `DioException` — esa capa
queda encapsulada en el repository. La UI solo conoce `AsyncValue<List<Item>>` y, en el peor
caso, un `String` con un mensaje de error ya traducido.

### 5. Checklist de buenas prácticas de la semana

- ✅ Una sola instancia de `Dio` (vía `dioProvider` con `keepAlive: true`)
- ✅ `LogInterceptor` solo en `kDebugMode`
- ✅ Toda llamada HTTP vive dentro de un repository, nunca directo en un widget o Notifier
- ✅ `DioException` se traduce a un mensaje propio antes de llegar a la UI
- ✅ `fromJson` castea de forma defensiva (`as Tipo?`, valores por defecto)
- ✅ Timeouts configurados explícitamente en `BaseOptions`
- ✅ Estados de error en la UI incluyen una acción de reintentar (`ref.invalidate`)

## ✅ Checklist de Verificación

- [ ] Sé escribir un `fromJson` que no crashea ante campos faltantes o de tipo inesperado
- [ ] Sé explicar por qué la URL base vive en un solo lugar (`BaseOptions`)
- [ ] Sé explicar por qué la UI no debe importar Dio directamente
- [ ] Repasé el checklist completo de buenas prácticas de la semana

## 📚 Siguiente paso

Con la teoría completa, continúa con las [prácticas guiadas](../2-practicas/) — el primer
ejercicio configura Dio desde cero e inspecciona requests con `LogInterceptor`.
