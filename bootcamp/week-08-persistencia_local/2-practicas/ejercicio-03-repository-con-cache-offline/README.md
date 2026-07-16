# Ejercicio 03 — Repository con Cache Offline

> Combinarás Dio y Hive en un `AsyncNotifier`: red primero, cache local como respaldo si falla —
> el mismo patrón que usarás en el proyecto de esta semana. Es el ejercicio más largo de la
> semana.

## 🎯 Objetivos

- Guardar en un `Box` de Hive el resultado de un fetch exitoso
- Leer del `Box` como fallback cuando el fetch falla
- Verificar el comportamiento offline probando en modo avión

## 📋 Requisitos

- Ejercicios 01 y 02 completados
- Semana 6 completada (Dio, `DioException`)
- Conexión a internet (usa la API pública `jsonplaceholder.typicode.com`)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

---

## Paso 1: dioProvider + itemsBoxProvider

```dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
}

@riverpod
Box<dynamic> itemsBox(Ref ref) {
  throw UnimplementedError('Debe sobreescribirse en main() — ver overrides de ProviderScope.');
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar
`part 'main.g.dart';` junto a los imports, y el `main()` async que abre el Box y lo inyecta con
`overrideWithValue()`). Regenera con build_runner.

> 💡 `itemsBoxProvider` nunca ejecuta su cuerpo real en la app — `main()` lo sobreescribe con el
> Box ya abierto antes de `runApp()`. El `throw` es solo una red de seguridad si alguien olvida
> el override (por ejemplo, en un test). Mismo patrón que `sharedPreferencesProvider` de la
> teoría de esta semana.

---

## Paso 2: QuotesNotifier — red primero, cache como respaldo

```dart
@riverpod
class QuotesNotifier extends _$QuotesNotifier {
  static const _cacheKey = 'titles';

  @override
  Future<List<String>> build() async {
    final box = ref.watch(itemsBoxProvider);
    try {
      final response = await ref.read(dioProvider).get('/posts');
      final titles = (response.data as List)
          .map((json) => json['title'] as String)
          .toList();
      await box.put(_cacheKey, titles);
      return titles;
    } catch (_) {
      final cached = box.get(_cacheKey) as List?;
      if (cached != null) return cached.cast<String>();
      rethrow;
    }
  }
}
```

**Descomenta la sección `PASO 2`** (la clase `QuotesNotifier` completa). Regenera con
build_runner.

- El `catch (_)` es intencionalmente genérico — no distingue `DioException` de otros errores,
  porque la respuesta es la misma en ambos casos: intentar leer el cache.
- `rethrow` solo ocurre si **ni la red ni el cache** tienen datos — típicamente, la primera vez
  que se abre la app sin conexión.

---

## Paso 3: UI reactiva con reintento

```dart
final quotesAsync = ref.watch(quotesProvider);

quotesAsync.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stackTrace) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$error'),
        ElevatedButton(
          onPressed: () => ref.invalidate(quotesProvider),
          child: const Text('Reintentar'),
        ),
      ],
    ),
  ),
  data: (titles) => ListView.builder(
    itemCount: titles.length,
    itemBuilder: (context, index) => ListTile(title: Text(titles[index])),
  ),
);
```

**Descomenta la sección `PASO 3`** — reemplaza el `Placeholder` del body por este widget.

✅ **Verifica**: corre la app con conexión — debe listar títulos. Actívale modo avión y haz un
**hot restart** — debe seguir mostrando la misma lista (ahora desde el Box). Desinstala la app
(o borra sus datos) y vuelve a abrirla en modo avión — ahí sí debe mostrar el error, porque no
hay cache todavía.

---

## ✅ Resultado final

Un `AsyncNotifier` que combina Dio y Hive con la estrategia network-first-con-fallback — el
patrón exacto de `CachedItemsRepository` que completarás en el proyecto de esta semana.
