# ConsumerWidget, Consumer y ref

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo convertir un widget en observador de providers con `ConsumerWidget`
- La diferencia entre `ref.watch()`, `ref.read()` y `ref.listen()`
- Cuándo usar `Consumer` en vez de `ConsumerWidget`

## 📋 Conceptos Clave

### 1. ConsumerWidget: el reemplazo de StatelessWidget

```dart
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      body: Center(child: Text('$count')),
    );
  }
}
```

`ConsumerWidget` es idéntico a `StatelessWidget`, salvo que su `build()` recibe un parámetro
extra: `WidgetRef ref`, la puerta de entrada a todos los providers de la app.

### 2. ref.watch() — leer y suscribirse (dentro de build)

```dart
final count = ref.watch(counterProvider); // se reconstruye si counterProvider cambia
```

Igual que `context.watch<T>()` en Provider: úsalo dentro de `build()`.

### 3. ref.read() — leer sin suscribirse (en callbacks)

```dart
ElevatedButton(
  onPressed: () => ref.read(counterProvider.notifier).increment(),
  child: const Text('Sumar'),
)
```

Igual que `context.read<T>()`: úsalo en `onPressed`/`onTap`, nunca dentro de `build()` para
leer el valor a mostrar (usa `watch` para eso).

### 4. ref.listen() — reaccionar a cambios sin reconstruir la UI

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  ref.listen(counterProvider, (previous, next) {
    if (next == 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Llegaste a 10!')),
      );
    }
  });

  final count = ref.watch(counterProvider);
  return Text('$count');
}
```

`ref.listen` es para **efectos secundarios** (mostrar un `SnackBar`, navegar, loguear) que no
deberían disparar un rebuild por sí mismos — no tiene equivalente directo en Provider.

### 5. ConsumerStatefulWidget: cuando además necesitas estado local

```dart
class SearchBox extends ConsumerStatefulWidget {
  const SearchBox({super.key});

  @override
  ConsumerState<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends ConsumerState<SearchBox> {
  final _controller = TextEditingController(); // estado local, como StatefulWidget normal

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider); // `ref` disponible como propiedad
    return TextField(controller: _controller);
  }
}
```

Úsalo cuando necesitas **ambos**: estado local (`TextEditingController`, `AnimationController`)
y acceso a providers. Es a `ConsumerWidget` lo que `StatefulWidget` es a `StatelessWidget`.

### 6. Consumer: suscribirse a una parte pequeña del árbol

```dart
Column(
  children: [
    const ExpensiveStaticHeader(), // no se reconstruye
    Consumer(
      builder: (context, ref, child) {
        final count = ref.watch(counterProvider);
        return Text('$count'); // solo esto se reconstruye
      },
    ),
  ],
)
```

Igual que `Selector`/`Consumer<T>` en Provider (semana 4): úsalo cuando solo una parte pequeña
de un `StatelessWidget`/`ConsumerWidget` necesita reconstruirse.

## ⚠️ Errores Comunes

- Usar `ref.watch()` dentro de un callback (`onPressed`) — igual que en Provider, lanza una
  excepción; usa `ref.read()` ahí.
- Poner lógica de efectos secundarios (`SnackBar`, navegación) directamente en el `build()`
  sin `ref.listen()` — puede ejecutarse múltiples veces de forma impredecible.
- Olvidar que `ConsumerStatefulWidget`/`ConsumerState` exponen `ref` como **propiedad**, no
  como parámetro de `build()` (a diferencia de `ConsumerWidget`).

## 📚 Recursos Adicionales

- [riverpod.dev — Getting started (ConsumerWidget)](https://riverpod.dev/docs/introduction/getting_started)
- [Riverpod — WidgetRef class (API)](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/WidgetRef-class.html)

## ✅ Checklist de Verificación

- [ ] Puedo convertir una pantalla en ConsumerWidget y usar ref.watch
- [ ] Sé cuándo usar ref.read() vs ref.watch() vs ref.listen()
- [ ] Sé cuándo usar ConsumerStatefulWidget en vez de ConsumerWidget
