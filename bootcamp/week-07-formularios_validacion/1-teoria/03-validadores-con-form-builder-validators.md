# Validadores con form_builder_validators

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Los validadores más comunes que trae `form_builder_validators`
- Cómo componer varios validadores en un solo campo con `.compose()`
- Cómo escribir un validador propio

## 📋 Conceptos Clave

### 1. Validadores listos para usar

`FormBuilderValidators` trae funciones que retornan un validador (`FormFieldValidator<T>`) —
cada una valida un caso común:

```dart
FormBuilderValidators.required()       // el campo no puede estar vacío
FormBuilderValidators.email()          // formato de correo válido
FormBuilderValidators.numeric()        // solo números
FormBuilderValidators.min(0)           // valor numérico mínimo
FormBuilderValidators.max(9999)        // valor numérico máximo
FormBuilderValidators.minLength(3)     // longitud mínima de texto
FormBuilderValidators.maxLength(120)   // longitud máxima de texto
```

Cada una retorna `null` si el valor es válido, o un `String` con el mensaje de error si no lo
es — la misma convención que un `validator` de `TextFormField` nativo.

### 2. Componer varios validadores — .compose()

Un campo casi siempre necesita más de una regla. `compose()` las encadena — se detiene y
retorna el primer mensaje de error que encuentre:

```dart
FormBuilderTextField(
  name: 'email',
  decoration: const InputDecoration(labelText: 'Correo'),
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'El correo es obligatorio'),
    FormBuilderValidators.email(errorText: 'Formato de correo inválido'),
  ]),
),

FormBuilderTextField(
  name: 'price',
  decoration: const InputDecoration(labelText: 'Precio'),
  keyboardType: TextInputType.number,
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.numeric(errorText: 'Debe ser un número'),
    FormBuilderValidators.min(0, errorText: 'No puede ser negativo'),
  ]),
),
```

> 💡 `errorText` personaliza el mensaje — sin él, el paquete usa un mensaje en inglés por
> defecto. En este curso, **siempre personaliza `errorText`** para que la app quede en español.

### 3. Validador propio

Cuando ninguna regla lista cubre tu caso (por ejemplo, un código que debe empezar con una letra
específica de tu dominio), escribe una función con la firma `String? Function(T? value)`:

```dart
String? _startsWithLetter(String? value) {
  if (value == null || value.isEmpty) return null; // required() ya cubre el caso vacío
  if (!RegExp(r'^[A-Za-z]').hasMatch(value)) {
    return 'Debe empezar con una letra';
  }
  return null;
}

FormBuilderTextField(
  name: 'code',
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    _startsWithLetter,
  ]),
),
```

Un validador propio también puede componerse dentro de `.compose()` — no es especial, solo
cumple la misma firma que los validadores del paquete.

### 4. required() al final vs al principio

```dart
// ❌ Si el campo está vacío, numeric() also corre y puede mostrar 2 errores
// confusos en secuencia (aunque compose() solo muestra el primero, el
// orden importa para cuál mensaje ve el usuario primero)
FormBuilderValidators.compose([
  FormBuilderValidators.numeric(),
  FormBuilderValidators.required(),
]),

// ✅ required() primero — si está vacío, el usuario ve "es obligatorio"
// antes que "debe ser un número"
FormBuilderValidators.compose([
  FormBuilderValidators.required(),
  FormBuilderValidators.numeric(),
]),
```

## ✅ Checklist de Verificación

- [ ] Conozco al menos 4 validadores listos de `form_builder_validators`
- [ ] Sé componer varios validadores con `.compose()`
- [ ] Sé escribir un validador propio con la firma correcta
- [ ] Sé por qué `required()` va primero en la composición

## 📚 Próximo paso

[Manejo del Estado del Formulario →](04-manejo-de-estado-del-formulario.md)
