# Ejercicio 01 — Cubit Básico

> Construirás un contador con `Cubit<int>`, descomentando código paso a paso, para practicar el
> ciclo completo: emit(), BlocProvider y BlocBuilder.

## 🎯 Objetivos

- Escribir un `Cubit<int>` con métodos que llaman `emit()`
- Proveerlo con `BlocProvider` y consumirlo con `BlocBuilder`
- Disparar un efecto secundario con `BlocListener` sin reconstruir la UI

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: CounterCubit

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

> 💡 `state` dentro de un Cubit siempre es el valor actual — `emit(state + 1)` calcula el
> siguiente estado a partir del actual, igual que `state = state + 1` en un `StateNotifier` de
> Riverpod.

---

## Paso 2: BlocProvider + BlocBuilder

```dart
BlocProvider(
  create: (context) => CounterCubit(),
  child: Scaffold(
    body: Center(
      child: BlocBuilder<CounterCubit, int>(
        builder: (context, count) => Text('$count'),
      ),
    ),
    floatingActionButton: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().decrement(),
          child: const Icon(Icons.remove),
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: const Icon(Icons.add),
        ),
      ],
    ),
  ),
)
```

**Descomenta la sección `PASO 2`** y reemplaza el `body` de `HomeScreen` por este árbol.

✅ **Verifica**: los botones +/- deben cambiar el número en pantalla.

---

## Paso 3: BlocListener — efecto secundario sin reconstruir

```dart
BlocListener<CounterCubit, int>(
  listener: (context, count) {
    if (count == 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Llegaste a 5!')),
      );
    }
  },
  child: /* el BlocProvider del PASO 2 */,
)
```

**Descomenta la sección `PASO 3`** y envuelve el árbol del PASO 2 con este `BlocListener`.

✅ **Verifica**: al llegar a 5 (presionando "+" cinco veces), debe aparecer un `SnackBar` — una
sola vez, no en cada rebuild.

---

## ✅ Resultado final

Un Cubit completo: estado, `emit()`, `BlocBuilder` para reconstruir la UI y `BlocListener` para
efectos secundarios — la base que usarás en el proyecto de esta semana con `ItemsCubit`,
`AuthCubit` y `CreateItemCubit`.
