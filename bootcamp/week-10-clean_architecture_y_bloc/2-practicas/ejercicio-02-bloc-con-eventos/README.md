# Ejercicio 02 — Bloc con Eventos

> Reescribirás el contador del ejercicio 01 con `Bloc<Event, State>` en vez de `Cubit<int>`,
> descomentando código paso a paso, para sentir la diferencia entre disparar un método y
> disparar un evento.

## 🎯 Objetivos

- Modelar eventos con `Equatable` (`CounterIncremented`/`CounterDecremented`)
- Registrar un handler con `on<Event>()`
- Disparar un evento con `bloc.add()` en vez de llamar un método directo

## 📋 Requisitos

- Ejercicio 01 completado

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: eventos

```dart
sealed class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object?> get props => [];
}

class CounterIncremented extends CounterEvent {
  const CounterIncremented();
}

class CounterDecremented extends CounterEvent {
  const CounterDecremented();
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

> 💡 Un evento describe **qué pasó** ("el usuario pidió incrementar"), no **qué hacer** — esa
> lógica vive en el handler del Bloc, no en el evento.

---

## Paso 2: CounterBloc con on<Event>()

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncremented>((event, emit) => emit(state + 1));
    on<CounterDecremented>((event, emit) => emit(state - 1));
  }
}
```

**Descomenta la sección `PASO 2`**.

`on<CounterIncremented>(...)` registra el handler **una sola vez**, en el constructor — cada vez
que llegue un evento de ese tipo, Bloc ejecuta ese handler automáticamente.

---

## Paso 3: BlocProvider + disparar eventos con .add()

```dart
BlocProvider(
  create: (context) => CounterBloc(),
  child: Scaffold(
    body: Center(
      child: BlocBuilder<CounterBloc, int>(
        builder: (context, count) => Text('$count'),
      ),
    ),
    floatingActionButton: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () => context.read<CounterBloc>().add(const CounterDecremented()),
          child: const Icon(Icons.remove),
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          onPressed: () => context.read<CounterBloc>().add(const CounterIncremented()),
          child: const Icon(Icons.add),
        ),
      ],
    ),
  ),
)
```

**Descomenta la sección `PASO 3`** y reemplaza el `body` de `HomeScreen` por este árbol.

✅ **Verifica**: mismo comportamiento visual que el ejercicio 01 — pero ahora cada toque de botón
dispara un evento (`context.read<CounterBloc>().add(...)`) en vez de llamar un método directo
(`context.read<CounterCubit>().increment()`).

---

## ✅ Resultado final

El mismo contador del ejercicio 01, ahora orientado a eventos — compara ambos archivos
`main.dart` lado a lado para ver exactamente qué cambia entre Cubit y Bloc (teoría 03 y 04) y qué
se mantiene igual (`BlocProvider`, `BlocBuilder`, el estado `int`).
