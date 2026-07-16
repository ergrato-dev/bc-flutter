# Bloc — Eventos y Estados

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un `Bloc<Event, State>` y en qué se diferencia de un `Cubit<State>`
- Cómo se ve el mismo `ItemsCubit` de este proyecto expresado como `Bloc`
- Cuándo preferir Bloc sobre Cubit en un proyecto real

> 📌 Este archivo es **solo teoría** — el proyecto de esta semana usa Cubit (ver teoría 03). El
> ejercicio 02 practica Bloc de forma aislada, sin migrar todo el proyecto.

## 📋 Conceptos Clave

### 1. Bloc — eventos que producen estados

Un `Cubit` cambia de estado con una llamada directa a un método (`cubit.fetchItems()`). Un
`Bloc<Event, State>` en cambio recibe **eventos** (clases que describen "qué pasó", no "qué
hacer") y los traduce a estados con un handler registrado:

```dart
sealed class ItemsEvent extends Equatable {
  const ItemsEvent();
  @override
  List<Object?> get props => [];
}

class ItemsFetchRequested extends ItemsEvent {
  const ItemsFetchRequested();
}
```

```dart
class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc(this._getItems) : super(const ItemsInitial()) {
    on<ItemsFetchRequested>(_onFetchRequested);
  }

  final GetItems _getItems;

  Future<void> _onFetchRequested(
    ItemsFetchRequested event,
    Emitter<ItemsState> emit,
  ) async {
    emit(const ItemsLoading());
    try {
      emit(ItemsLoaded(await _getItems()));
    } catch (e) {
      emit(ItemsError('$e'));
    }
  }
}
```

Desde la UI, en vez de `context.read<ItemsCubit>().fetchItems()`, se **dispara un evento**:

```dart
context.read<ItemsBloc>().add(const ItemsFetchRequested());
```

`ItemsState` (con sus subclases `ItemsInitial`/`ItemsLoading`/`ItemsLoaded`/`ItemsError`) es
**exactamente la misma** clase de estado de teoría 03 — Bloc y Cubit comparten el mismo modelo de
estado, la diferencia está en cómo se dispara la transición.

### 2. Comparación directa

| | Cubit | Bloc |
|---|---|---|
| Dispara una transición | Llamada a método (`cubit.fetchItems()`) | Evento (`bloc.add(ItemsFetchRequested())`) |
| Clases extra necesarias | Solo estados | Estados + eventos |
| Rastro de "qué pasó y cuándo" | Solo ves el estado final | Cada evento queda registrado — más fácil de loguear/depurar en producción |
| Multiplexar varias fuentes hacia una acción | Cada llamador invoca el método directo | Varios triggers (botón, deep link, WebSocket) pueden mandar el mismo evento sin coordinarse entre sí |
| Curva de aprendizaje | Igual de directa que un método normal | Requiere modelar eventos explícitamente |

### 3. Cuándo preferir Bloc sobre Cubit

- **Necesitas un registro auditable de qué disparó cada cambio** — en logs de producción, un
  evento (`ItemsFetchRequested`, `ItemsRefreshRequested`) es más informativo que "se llamó
  fetchItems() otra vez".
- **Varias fuentes de UI disparan la misma acción** de formas distintas (un botón, un pull-to-
  refresh, un deep link) — modelarlas como eventos separados (`ItemsFetchRequested` vs
  `ItemsRefreshRequested`) que comparten handler evita duplicar lógica.
- **Equipos grandes / contextos enterprise** — el evento como "contrato" explícito entre quien
  dispara la acción y quien la maneja facilita coordinar cambios entre varios desarrolladores sin
  leer la implementación completa del Bloc.

Para el resto de casos — la mayoría de features de una app típica — Cubit es más directo y con
menos código, por eso es el que usa el proyecto de esta semana.

### 4. `on<Event>()` — transformers (mención)

`Bloc` permite controlar cómo se procesan eventos concurrentes con transformers de la librería
`bloc_concurrency` (`droppable()`, `sequential()`, `restartable()`) — útil, por ejemplo, para
cancelar una búsqueda en curso si el usuario escribe una nueva letra antes de que la anterior
responda. Queda fuera del alcance de esta semana, pero ahora sabes que existe cuando lo
necesites.

## ✅ Checklist de Verificación

- [ ] Sé la diferencia entre disparar una acción con un método (Cubit) y con un evento (Bloc)
- [ ] Sé escribir un evento, un handler con `on<Event>()`, y disparar el evento con `.add()`
- [ ] Sé por qué Bloc y Cubit comparten el mismo modelo de estado
- [ ] Sé cuándo preferir Bloc sobre Cubit en un proyecto real

## 📚 Próximo paso

[Inyección de Dependencias con get_it →](05-inyeccion-de-dependencias-con-get-it.md)
