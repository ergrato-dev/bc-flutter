# Ejercicio 02 — Validadores Compuestos y Tipos de Campo

> Agregarás un dropdown, un checkbox y un campo numérico con validación compuesta, más
> `autovalidateMode` y un botón de reset, descomentando código paso a paso.

## 🎯 Objetivos

- Usar `FormBuilderDropdown` y `FormBuilderCheckbox`
- Componer varios validadores en un campo con `FormBuilderValidators.compose()`
- Configurar `autovalidateMode: onUserInteraction` y resetear el formulario

## 📋 Requisitos

- Ejercicio 01 completado

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: FormBuilderDropdown

```dart
FormBuilderDropdown<String>(
  name: 'category',
  decoration: const InputDecoration(labelText: 'Categoría'),
  validator: FormBuilderValidators.required(errorText: 'Selecciona una categoría'),
  items: const [
    DropdownMenuItem(value: 'a', child: Text('Categoría A')),
    DropdownMenuItem(value: 'b', child: Text('Categoría B')),
    DropdownMenuItem(value: 'c', child: Text('Categoría C')),
  ],
),
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

---

## Paso 2: Validación compuesta + FormBuilderCheckbox

```dart
FormBuilderTextField(
  name: 'price',
  decoration: const InputDecoration(labelText: 'Precio'),
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'El precio es obligatorio'),
    FormBuilderValidators.numeric(errorText: 'Debe ser un número'),
    FormBuilderValidators.min(0, errorText: 'No puede ser negativo'),
  ]),
),
const SizedBox(height: 12),
FormBuilderCheckbox(
  name: 'inStock',
  title: const Text('Disponible en inventario'),
  initialValue: true,
),
```

**Descomenta la sección `PASO 2`.**

✅ **Verifica**: escribe `-5` en precio — debe mostrar "No puede ser negativo". Escribe `abc` —
debe mostrar "Debe ser un número" (el primer error de la composición que falle).

---

## Paso 3: autovalidateMode + reset

```dart
FormBuilder(
  key: _formKey,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  child: /* ... */,
)

// Segundo botón, junto al de "Enviar":
OutlinedButton(
  onPressed: () => _formKey.currentState?.reset(),
  child: const Text('Limpiar'),
),
```

**Descomenta la sección `PASO 3`** (agrega `autovalidateMode` al `FormBuilder` del ejercicio 01,
y el botón "Limpiar" junto al de "Enviar").

✅ **Verifica**: toca el campo de precio y bórralo — el error debe aparecer inmediatamente (sin
tocar "Enviar"), pero los demás campos aún sin tocar no deben mostrar error todavía. El botón
"Limpiar" debe vaciar todos los campos.

---

## ✅ Resultado final

Un formulario con 4 campos de distintos tipos, validación compuesta en el campo numérico,
validación reactiva al interactuar, y reset — el mismo nivel de formulario que construirás en
el proyecto de esta semana.
