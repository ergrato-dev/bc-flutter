# Ejercicio 02 — AsyncNotifier y AsyncValue

> Construirás un provider asíncrono que simula una carga de red, y manejarás sus 3 estados con
> `.when()`, descomentando código paso a paso.

## 🎯 Objetivos

- Declarar un provider con `build()` async retornando `Future<T>`
- Manejar `AsyncValue<T>` con `.when()` (loading/error/data)
- Mutar estado async agregando un elemento

## 📋 Requisitos

- Ejercicio 01 completado

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

---

## Paso 1: Provider asíncrono

```dart
@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  Future<List<String>> build() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return ['Elemento 1', 'Elemento 2', 'Elemento 3'];
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar `part 'main.g.dart';` junto a los imports). Regenera con build_runner.

---

## Paso 2: Manejar AsyncValue con .when()

```dart
itemsAsync.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stackTrace) => Center(child: Text('Error: $error')),
  data: (items) => ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  ),
)
```

**Descomenta la sección `PASO 2`.** Regenera con build_runner.

✅ **Verifica**: durante ~800ms debe verse un spinner, luego la lista de 3 elementos.

---

## Paso 3: Mutar estado async — agregar un elemento

```dart
Future<void> addItem(String name) async {
  final current = await future;
  state = AsyncData([...current, name]);
}
```

**Descomenta la sección `PASO 3`** (el método en `ItemsNotifier` y el botón que lo llama).
Regenera con build_runner.

✅ **Verifica**: al tocar "Agregar elemento", la lista debe crecer sin volver a mostrar el
spinner (la carga inicial ya terminó).

---

## ✅ Resultado final

Una pantalla que carga datos de forma asíncrona, maneja los 3 estados correctamente, y permite
mutar el resultado ya cargado — el mismo patrón que usarás con Dio en semana 6, solo que ahí
`Future.delayed` será una llamada HTTP real.
