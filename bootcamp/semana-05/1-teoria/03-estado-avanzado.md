# Módulo 03: Estado Avanzado (BLoC / Riverpod / Comparación)

## 🎯 Objetivos

- Introducir `BLoC`/`Cubit` y `Riverpod` como alternativas más escalables.
- Comparar ventajas y desventajas de cada enfoque.

---

## 1. BLoC / Cubit (Resumen)

- Basado en Streams y eventos.
- Buen para apps grandes y testables.
- `flutter_bloc` y `bloc` son las librerías más usadas.

Ejemplo corto con `Cubit`:

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit(): super(0);
  void increment() => emit(state + 1);
}

// Proveer
BlocProvider(
  create: (_) => CounterCubit(),
  child: MyApp(),
)

// Consumir
BlocBuilder<CounterCubit, int>(
  builder: (_, count) => Text('\\$count'),
)
```

---

## 2. Riverpod (Resumen)

- Declarativo y sin dependencias del `BuildContext`.
- Muy testable y flexible.
- `hooks_riverpod` ofrece syntactic sugar para Hooks.

Ejemplo básico:

```dart
final counterProvider = StateProvider<int>((ref) => 0);

// Leer
final count = ref.watch(counterProvider).state;

// Actualizar
ref.read(counterProvider).state++;
```

---

## 3. Comparación rápida

- `setState()`: simple, local, rápido de implementar.
- `Provider`: oficial, simple para estado compartido, buena curva de aprendizaje.
- `BLoC`: más boilerplate, excelente para lógica compleja y testeo.
- `Riverpod`: moderno, declarativo, sin contexto, ideal para proyectos grandes.

---

## 4. Ejercicio (30-45 min)

- Reescribir el `CartModel` anterior usando `Cubit` o `Riverpod` y comparar la experiencia.
- Escribir pruebas unitarias básicas para la lógica de carrito.

---

## Recursos

- `flutter_bloc` docs
- `riverpod` docs
- Artículos comparativos en `4-recursos`
