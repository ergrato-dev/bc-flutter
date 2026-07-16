# Introducción a Formularios en Flutter

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo Flutter maneja formularios de forma nativa (`Form` + `TextEditingController`)
- Qué problema resuelve `flutter_form_builder` sobre ese enfoque
- Cómo instalar y estructurar tu primer `FormBuilder`

## 📋 Conceptos Clave

### 1. El enfoque nativo: Form + TextEditingController

Flutter provee `Form` y `TextFormField` de forma nativa. Para 1-2 campos funciona bien, pero
escala mal:

```dart
final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _emailController = TextEditingController();

// Por cada campo: un controller, disponer cada uno en dispose(),
// y un validator inline repetido en cada TextFormField.
```

Con 5+ campos, esto significa 5+ `TextEditingController`, 5+ líneas de `.dispose()`, y lógica de
validación dispersa por todo el widget.

### 2. flutter_form_builder — un solo estado para todo el formulario

`flutter_form_builder` centraliza el estado de **todos** los campos en un solo objeto
(`FormBuilderState`), accesible mediante un `GlobalKey<FormBuilderState>` — sin
`TextEditingController` por campo.

```yaml
# pubspec.yaml
dependencies:
  flutter_form_builder: 10.3.0+2
  form_builder_validators: 11.3.0
```

```bash
flutter pub add flutter_form_builder form_builder_validators
```

| Necesidad | `Form` nativo | `FormBuilder` |
|---|---|---|
| Leer todos los valores a la vez | Un `TextEditingController` por campo | `formKey.currentState!.value` (un `Map`) |
| Validar todos los campos | `_formKey.currentState!.validate()` | `formKey.currentState!.saveAndValidate()` |
| Validadores reutilizables (email, requerido, rango) | Escribirlos a mano | `form_builder_validators` los trae listos |
| Tipos de campo (dropdown, checkbox, fecha) | Cada uno con su propio widget y estado | Familia `FormBuilderField*` con la misma API |

### 3. Estructura mínima de un FormBuilder

```dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyFormScreen extends StatefulWidget {
  const MyFormScreen({super.key});

  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(name: 'name'),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                print(_formKey.currentState!.value); // {'name': '...'}
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
```

- `name: 'name'` — cada campo se identifica por una clave `String`, no por un controller. Ese
  nombre es la clave que usarás para leer el valor en `formKey.currentState!.value`.
- `FormBuilder` es un `StatefulWidget` — necesita un `GlobalKey<FormBuilderState>` propio (no
  confundir con el `GlobalKey<FormState>` del `Form` nativo).

### 4. Por qué GlobalKey y no un provider de Riverpod aquí

El estado de "qué hay escrito en el formulario mientras el usuario escribe" es efímero y local a
la pantalla — no necesita compartirse entre widgets ni sobrevivir a la navegación. `GlobalKey` es
la herramienta correcta para esto; Riverpod entra recién cuando el formulario se **envía**
(archivo 5 de esta semana) y ese resultado sí necesita observarse desde la UI.

## ✅ Checklist de Verificación

- [ ] Sé explicar 2 problemas del enfoque `Form` + `TextEditingController` con muchos campos
- [ ] Sé instalar `flutter_form_builder` y `form_builder_validators`
- [ ] Sé envolver campos en un `FormBuilder` con `GlobalKey<FormBuilderState>`
- [ ] Sé leer los valores de todos los campos con `formKey.currentState!.value`

## 📚 Próximo paso

[FormBuilderFields y Tipos de Campo →](02-formbuilderfields-y-tipos-de-campo.md)
