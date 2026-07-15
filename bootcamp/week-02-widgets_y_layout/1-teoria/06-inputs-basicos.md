# Inputs Básicos: TextField y Manejo de Eventos

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo capturar texto del usuario con `TextField`
- Cómo conectar un `TextEditingController` con `setState`
- La diferencia entre este manejo básico de inputs y los formularios completos de semana 7

## 📋 Conceptos Clave

### 1. TextField y TextEditingController

```dart
class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // libera recursos — obligatorio con controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Buscar',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) => debugPrint('Texto actual: $value'),
    );
  }
}
```

> ⚠️ **Nunca olvides `dispose()`**: todo `TextEditingController` (y en general, cualquier
> controller) debe liberarse en `dispose()` del `State` — de lo contrario hay fuga de memoria.

### 2. Conectar el input con el estado de la pantalla

```dart
class _SearchBoxState extends State<SearchBox> {
  final _controller = TextEditingController();
  String _query = '';

  void _onSearch() {
    setState(() => _query = _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _controller),
        ElevatedButton(onPressed: _onSearch, child: const Text('Buscar')),
        Text('Buscando: $_query'),
      ],
    );
  }
}
```

### 3. Este NO es el sistema de formularios completo

Esta semana solo capturas texto suelto con `setState`. En semana 7 verás `Form`, `FormField` y
validación estructurada con paquetes como `flutter_form_builder` — lo de aquí es la base
mínima para interactuar con el usuario mientras tanto (por ejemplo, un buscador simple en una
lista).

### 4. Filtrar una lista con el texto capturado

```dart
final filtered = items.where((item) =>
  item.name.toLowerCase().contains(_query.toLowerCase())
).toList();
```

Combina esto con `ListView.builder` (visto en el archivo anterior) para construir un buscador
funcional sobre tu lista de elementos del dominio — exactamente lo que harás en el proyecto de
esta semana.

## ⚠️ Errores Comunes

- No llamar `_controller.dispose()` — fuga de memoria silenciosa.
- Usar `setState` para actualizar el texto tecla por tecla cuando `onChanged` ya lo hace —
  innecesario y puede causar rebuilds de más.
- Confundir este input suelto con un formulario completo — no tiene validación, y no debería
  usarse para datos que requieren reglas de negocio (eso es semana 7).

## 📚 Recursos Adicionales

- [Flutter — TextField class](https://api.flutter.dev/flutter/material/TextField-class.html)
- [Flutter cookbook — Handle changes to a text field](https://docs.flutter.dev/cookbook/forms/text-field-changes)

## ✅ Checklist de Verificación

- [ ] Puedo capturar texto del usuario con TextField y TextEditingController
- [ ] Sé por qué es obligatorio hacer dispose() de un controller
- [ ] Puedo filtrar una lista en base a un texto de búsqueda
