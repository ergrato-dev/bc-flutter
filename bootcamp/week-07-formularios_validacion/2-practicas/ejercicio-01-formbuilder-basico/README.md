# Ejercicio 01 — FormBuilder Básico

> Construirás tu primer `FormBuilder` con dos campos de texto y validación básica, leyendo los
> valores al enviar, descomentando código paso a paso.

## 🎯 Objetivos

- Envolver campos en un `FormBuilder` con `GlobalKey<FormBuilderState>`
- Agregar un validador simple a cada campo
- Leer los valores del formulario con `saveAndValidate()`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: FormBuilder con GlobalKey

```dart
final _formKey = GlobalKey<FormBuilderState>();

FormBuilder(
  key: _formKey,
  child: Column(
    children: [
      FormBuilderTextField(
        name: 'name',
        decoration: const InputDecoration(labelText: 'Nombre'),
      ),
    ],
  ),
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

---

## Paso 2: Validadores simples

```dart
FormBuilderTextField(
  name: 'name',
  decoration: const InputDecoration(labelText: 'Nombre'),
  validator: FormBuilderValidators.required(errorText: 'El nombre es obligatorio'),
),
FormBuilderTextField(
  name: 'email',
  decoration: const InputDecoration(labelText: 'Correo'),
  keyboardType: TextInputType.emailAddress,
  validator: FormBuilderValidators.email(errorText: 'Formato de correo inválido'),
),
```

**Descomenta la sección `PASO 2`** (agrega el campo `email` y el validador de `name`).

✅ **Verifica**: al enviar con el nombre vacío, debe verse el mensaje "El nombre es
obligatorio" bajo ese campo.

---

## Paso 3: Leer los valores con saveAndValidate()

```dart
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${values['name']} — ${values['email']}')),
      );
    }
  },
  child: const Text('Enviar'),
),
```

**Descomenta la sección `PASO 3`** y agrega el botón al `Column` del `FormBuilder`.

✅ **Verifica**: con ambos campos válidos, debe aparecer un `SnackBar` con los valores
ingresados. Con algún campo inválido, el `SnackBar` no debe aparecer — solo los mensajes de
error bajo cada campo.

---

## ✅ Resultado final

Un formulario con `FormBuilder`, dos campos con validación básica, y lectura de valores al
enviar — la base que extenderás en el ejercicio 02 con validadores compuestos y más tipos de
campo.
