# FormBuilderFields y Tipos de Campo

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Los tipos de campo más usados de `flutter_form_builder`
- Cómo configurar `initialValue`, `keyboardType` y `decoration`
- Cómo leer valores tipados (no solo `String`) del formulario

## 📋 Conceptos Clave

### 1. FormBuilderTextField — texto y números

```dart
FormBuilderTextField(
  name: 'email',
  decoration: const InputDecoration(labelText: 'Correo', prefixIcon: Icon(Icons.email)),
  keyboardType: TextInputType.emailAddress,
),

FormBuilderTextField(
  name: 'price',
  decoration: const InputDecoration(labelText: 'Precio'),
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  valueTransformer: (text) => num.tryParse(text ?? ''),
),
```

- `keyboardType` cambia el teclado que ve el usuario (numérico, email, teléfono) — un detalle de
  UX móvil que no existe en formularios web.
- `valueTransformer` convierte el `String` crudo del campo a otro tipo (`num`, `DateTime`, etc.)
  **antes** de guardarlo en `formKey.currentState!.value` — sin esto, todo campo de texto
  siempre es `String`, aunque el usuario haya tecleado solo dígitos.

### 2. FormBuilderDropdown — selección única

```dart
FormBuilderDropdown<String>(
  name: 'category',
  decoration: const InputDecoration(labelText: 'Categoría'),
  items: const [
    DropdownMenuItem(value: 'a', child: Text('Categoría A')),
    DropdownMenuItem(value: 'b', child: Text('Categoría B')),
  ],
),
```

El tipo genérico (`<String>` en este caso) determina el tipo del valor que termina en
`formKey.currentState!.value['category']` — no siempre es `String`; puede ser un `enum` o
cualquier tipo que definas.

### 3. FormBuilderCheckbox — booleano

```dart
FormBuilderCheckbox(
  name: 'inStock',
  title: const Text('Disponible en inventario'),
  initialValue: true,
),
```

### 4. FormBuilderDateTimePicker — fechas

```dart
FormBuilderDateTimePicker(
  name: 'birthDate',
  inputType: FormBuilderDateTimePickerInputType.date,
  decoration: const InputDecoration(labelText: 'Fecha de nacimiento'),
),
```

Abre el selector de fecha nativo de la plataforma (`showDatePicker` internamente) — el usuario
nunca escribe una fecha a mano, evitando errores de formato.

### 5. Todos comparten la misma API base

| Parámetro | Rol |
|---|---|
| `name` | Clave del campo — cómo lo lees en `formKey.currentState!.value` |
| `initialValue` | Valor con el que arranca el campo (útil al editar un elemento existente) |
| `decoration` | Igual que `InputDecoration` de `TextFormField` — label, ícono, hint |
| `validator` | Función de validación (archivo 3 profundiza en esto) |
| `enabled` | Deshabilita el campo — clave durante un envío en curso (archivo 4) |

> 💡 Aprender un tipo de `FormBuilderField` es aprender todos — la API es consistente entre
> texto, dropdown, checkbox y fecha.

## ✅ Checklist de Verificación

- [ ] Sé usar `FormBuilderTextField` con `keyboardType` apropiado según el dato
- [ ] Sé usar `valueTransformer` para obtener un tipo distinto de `String`
- [ ] Sé usar `FormBuilderDropdown` y `FormBuilderCheckbox`
- [ ] Entiendo que todos los `FormBuilderField*` comparten `name`, `initialValue`, `decoration`

## 📚 Próximo paso

[Validadores con form_builder_validators →](03-validadores-con-form-builder-validators.md)
