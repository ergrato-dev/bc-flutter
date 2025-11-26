# 📖 Glosario - Semana 05

## Gestión de Estado en Flutter

---

## 📋 Índice Alfabético

[B](#b) | [C](#c) | [D](#d) | [E](#e) | [I](#i) | [L](#l) | [M](#m) | [N](#n) | [P](#p) | [R](#r) | [S](#s) | [W](#w)

---

## B

### BLoC (Business Logic Component)

Patrón de arquitectura que separa la lógica de negocio de la UI usando Streams. Recibe Events y emite States.

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
  }
}
```

### BlocBuilder

Widget que reconstruye su hijo cuando el estado del Bloc cambia.

```dart
BlocBuilder<CounterBloc, int>(
  builder: (context, count) => Text('$count'),
)
```

### BlocProvider

Widget que provee un Bloc a sus descendientes en el árbol de widgets.

```dart
BlocProvider(
  create: (_) => CounterBloc(),
  child: MyApp(),
)
```

### BlocObserver

Clase para observar y monitorear todos los Blocs de la aplicación.

---

## C

### ChangeNotifier

Clase base que provee notificaciones de cambio a sus listeners. Fundamento de Provider.

```dart
class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  void add(Item item) {
    _items.add(item);
    notifyListeners(); // Notifica a los listeners
  }
}
```

### ChangeNotifierProvider

Widget que crea y provee un `ChangeNotifier` a sus descendientes.

```dart
ChangeNotifierProvider(
  create: (_) => CartModel(),
  child: MyApp(),
)
```

### Consumer

Widget que escucha cambios en un Provider y reconstruye solo su contenido.

```dart
Consumer<CartModel>(
  builder: (context, cart, child) => Text('Items: ${cart.items.length}'),
)
```

### context.read()

Método para obtener el valor de un Provider sin escuchar cambios. Usar en callbacks.

```dart
onPressed: () => context.read<CartModel>().add(item)
```

### context.watch()

Método para obtener y escuchar un Provider. Reconstruye cuando cambia.

```dart
final cart = context.watch<CartModel>();
```

### context.select()

Método para escuchar solo una parte específica del estado.

```dart
final count = context.select<CartModel, int>((c) => c.items.length);
```

### Cubit

Versión simplificada de BLoC que no usa Events, solo métodos directos.

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}
```

---

## D

### didChangeDependencies()

Método del ciclo de vida llamado cuando cambian las dependencias del contexto.

### dispose()

Método del ciclo de vida para limpiar recursos (controllers, subscriptions).

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

## E

### emit()

Método en Cubit/BLoC para emitir un nuevo estado.

```dart
void increment() => emit(state + 1);
```

### Estado de Aplicación (App State)

Estado compartido entre múltiples partes de la app (usuario logueado, carrito, preferencias).

### Estado Efímero (Ephemeral State)

Estado local que solo importa a un widget (animación, página actual de PageView).

### Event

En BLoC, entrada que dispara un cambio de estado.

```dart
abstract class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}
```

---

## I

### InheritedWidget

Widget base de Flutter para propagar datos hacia abajo en el árbol. Base de Provider.

### initState()

Método del ciclo de vida llamado una vez al crear el State.

```dart
@override
void initState() {
  super.initState();
  _controller = TextEditingController();
}
```

---

## L

### Listener (BlocListener)

Widget que ejecuta código cuando el estado cambia sin reconstruir UI.

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      Navigator.pushNamed(context, '/home');
    }
  },
  child: LoginForm(),
)
```

---

## M

### MultiProvider

Widget para proveer múltiples Providers en un solo lugar.

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthModel()),
    ChangeNotifierProvider(create: (_) => CartModel()),
  ],
  child: MyApp(),
)
```

---

## N

### notifyListeners()

Método de `ChangeNotifier` que notifica a todos los listeners de un cambio.

```dart
void updateName(String name) {
  _name = name;
  notifyListeners();
}
```

---

## P

### Provider

Paquete oficial de Flutter para gestión de estado simple usando InheritedWidget.

### Provider.of\<T\>()

Método para acceder a un Provider (preferir `context.watch()` o `context.read()`).

```dart
final cart = Provider.of<CartModel>(context);
```

### ProxyProvider

Provider que depende de otros Providers.

```dart
ProxyProvider<AuthModel, ApiService>(
  update: (_, auth, __) => ApiService(auth.token),
)
```

---

## R

### Rebuild

Reconstrucción de un widget cuando cambia su estado o dependencias.

### ref (Riverpod)

Objeto para leer y escuchar providers en Riverpod.

```dart
final count = ref.watch(counterProvider);
```

### Riverpod

Evolución de Provider sin dependencia del BuildContext, más testable y flexible.

```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

---

## S

### Selector

Widget que escucha solo una parte específica del estado (optimización).

```dart
Selector<CartModel, int>(
  selector: (_, cart) => cart.items.length,
  builder: (_, count, __) => Text('$count'),
)
```

### setState()

Método para actualizar estado local en un StatefulWidget.

```dart
setState(() {
  _counter++;
});
```

### State

Clase que contiene el estado mutable de un StatefulWidget.

### StatefulWidget

Widget que puede cambiar durante su tiempo de vida.

### StatelessWidget

Widget inmutable que no tiene estado interno.

### StateNotifier (Riverpod)

Clase para manejar estado complejo en Riverpod.

```dart
class CartNotifier extends StateNotifier<List<Item>> {
  CartNotifier() : super([]);
  void add(Item item) => state = [...state, item];
}
```

### StateProvider (Riverpod)

Provider para estado simple en Riverpod.

```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

### Stream

Secuencia asíncrona de datos. Base del patrón BLoC.

---

## W

### watch (Riverpod)

Método para escuchar cambios de un provider.

```dart
final count = ref.watch(counterProvider);
```

---

## 🔄 Relaciones entre Conceptos

```
┌─────────────────────────────────────────────────────────┐
│                    GESTIÓN DE ESTADO                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Estado Local          Estado Global                    │
│  ─────────────         ─────────────                    │
│  StatefulWidget   →    Provider                         │
│  setState()       →    ChangeNotifier                   │
│                   →    BLoC / Cubit                     │
│                   →    Riverpod                         │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Provider                BLoC                           │
│  ────────                ────                           │
│  ChangeNotifier          Event → Bloc → State           │
│  Consumer                Cubit (simplificado)           │
│  Selector                BlocBuilder                    │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Riverpod                                               │
│  ────────                                               │
│  StateProvider (simple)                                 │
│  StateNotifierProvider (complejo)                       │
│  ref.watch / ref.read                                   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 📊 Comparación Rápida

| Aspecto         | setState | Provider | BLoC   | Riverpod |
| --------------- | -------- | -------- | ------ | -------- |
| **Complejidad** | Baja     | Media    | Alta   | Media    |
| **Alcance**     | Local    | Global   | Global | Global   |
| **Testing**     | Difícil  | Medio    | Fácil  | Fácil    |
| **Boilerplate** | Mínimo   | Bajo     | Alto   | Medio    |
| **Curva**       | Fácil    | Fácil    | Media  | Media    |

---

## 🔗 Navegación

| ⬅️ Anterior                         | 🏠 Índice                 | ➡️ Siguiente                           |
| ----------------------------------- | ------------------------- | -------------------------------------- |
| [Recursos](../4-recursos/README.md) | [Semana 05](../README.md) | [Semana 06](../../semana-06/README.md) |

---

_Glosario Semana 05 - Gestión de Estado en Flutter_
