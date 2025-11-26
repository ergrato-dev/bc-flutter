# Módulo 01: Estado Local y `setState()`

## 🎯 Objetivos

- Entender qué es el estado local y cuándo usar `setState()`.
- Conocer el ciclo de vida de un `StatefulWidget`.
- Evitar malas prácticas al usar `setState()`.

---

## 1. ¿Qué es el estado local?

El estado local es la información que vive dentro de un `StatefulWidget` y que solo interesa a ese widget o su subtree directo. Ejemplos: contador de un botón, estado de expansion de un panel, formulario pequeño.

---

## 2. `StatefulWidget` vs `StatelessWidget`

```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: \\$_count'),
        ElevatedButton(onPressed: _increment, child: Text('Increment')),
      ],
    );
  }
}
```

### Buenas prácticas con `setState()`
- Llamar a `setState()` únicamente cuando cambias datos que afectan `build()`.
- Evitar lógica costosa dentro del callback de `setState()`.
- Mantener el `State` pequeño y delegar lógica a clases/servicios cuando sea necesario.

---

## 3. Ciclo de vida relevante

- `initState()` → inicializar controladores, listeners.
- `didChangeDependencies()` → cuando cambian dependencias del contexto.
- `build()` → renderizado.
- `dispose()` → limpiar controladores, suscripciones.

Ejemplo de uso:

```dart
@override
void initState() {
  super.initState();
  // inicializar
}

@override
void dispose() {
  // limpiar
  super.dispose();
}
```

---

## 4. Limitaciones de `setState()` y cuándo migrar

`setState()` es ideal para estados locales simples. Para estado compartido entre pantallas o que debe persistir, preferir soluciones como `Provider`, `BLoC` o `Riverpod`.

---

## 5. Ejercicio rápido (10 min)

- Crear un `StatefulWidget` que muestre una lista y un botón para añadir elementos.
- Usar `setState()` para actualizar la lista y mantener el scroll.

---

## Recursos
- Documentación oficial: https://docs.flutter.dev
- Artículo: "When to use setState" (link en recursos)
