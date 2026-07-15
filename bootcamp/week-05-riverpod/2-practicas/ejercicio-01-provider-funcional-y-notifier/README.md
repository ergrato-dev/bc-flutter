# Ejercicio 01 — Provider Funcional y Notifier

> Construirás un provider funcional simple y un `Notifier` con estado mutable, usando
> generación de código, descomentando código paso a paso.

## 🎯 Objetivos

- Declarar un provider funcional con `@riverpod`
- Declarar un `Notifier` con `@riverpod` y mutar su `state`
- Consumir ambos desde un `ConsumerWidget`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

> ⚠️ **Cada vez que descomentes un paso**, vuelve a correr
> `dart run build_runner build` antes de `flutter run` — el código
> generado debe regenerarse para reflejar tus cambios.

---

## Paso 1: Provider funcional

```dart
@riverpod
String greeting(Ref ref) {
  return 'Hola, Riverpod';
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar `part 'main.g.dart';` junto a los imports). Regenera con build_runner.

✅ **Verifica**: la app compila y corre, aunque todavía no se ve nada nuevo en pantalla.

---

## Paso 2: Notifier con estado mutable

```dart
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}
```

**Descomenta la sección `PASO 2`.** Regenera con build_runner.

---

## Paso 3: ConsumerWidget consumiendo ambos

```dart
class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(greetingProvider);
    final count = ref.watch(counterProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
        Text('$count'),
        ElevatedButton(
          onPressed: () => ref.read(counterProvider.notifier).increment(),
          child: const Text('Sumar'),
        ),
      ],
    );
  }
}
```

**Descomenta la sección `PASO 3`** y reemplaza el `body:` de `HomeScreen` por
`body: const Center(child: HomeContent())`. Regenera con build_runner.

✅ **Verifica**: debe verse el saludo, el contador en 0, y al tocar "Sumar" el número aumenta.

---

## ✅ Resultado final

Un provider funcional de solo lectura y un `Notifier` mutable, ambos consumidos desde el mismo
`ConsumerWidget` con `ref.watch`/`ref.read` — el mismo patrón `watch`/`read` de Provider
(semana 4), ahora sin `BuildContext`.
