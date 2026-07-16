# Manejo del Estado del Formulario

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué hace exactamente `saveAndValidate()`
- Cómo leer, resetear y parchear el estado de un `FormBuilder`
- Cuándo usar `autovalidateMode`

## 📋 Conceptos Clave

### 1. saveAndValidate() — la operación central

```dart
ElevatedButton(
  onPressed: () {
    final isValid = _formKey.currentState!.saveAndValidate();
    if (isValid) {
      final values = _formKey.currentState!.value;
      // values es un Map<String, dynamic>: {'name': 'Item', 'price': 12.5, ...}
    }
  },
  child: const Text('Enviar'),
),
```

`saveAndValidate()` hace dos cosas en un solo paso:

1. **Guarda** el valor actual de cada campo en el estado del formulario (equivalente a llamar
   `.save()` en cada campo individualmente).
2. **Valida** cada campo ejecutando su `validator` — si alguno falla, ese campo muestra su
   mensaje de error en pantalla automáticamente.

Retorna `true` solo si **todos** los campos son válidos. Si retorna `false`, no debes continuar
con el envío — el usuario ya está viendo qué corregir.

### 2. Leer el estado sin validar

```dart
final currentValues = _formKey.currentState?.value; // puede tener campos aún no válidos
```

Útil para lógica reactiva mientras el usuario escribe (por ejemplo, habilitar un botón según un
campo específico) — sin disparar validación de todos los campos.

### 3. reset() — limpiar el formulario

```dart
ElevatedButton(
  onPressed: () => _formKey.currentState?.reset(),
  child: const Text('Limpiar'),
),
```

Vuelve cada campo a su `initialValue` — útil después de un envío exitoso, para que el usuario
pueda crear otro elemento sin recargar la pantalla.

### 4. patchValue() — precargar valores (edición)

```dart
_formKey.currentState?.patchValue({
  'name': existingItem.name,
  'description': existingItem.description,
});
```

Para un formulario de **edición** (no cubierto en el proyecto de esta semana, pero un caso real
frecuente), `patchValue()` llena los campos con datos existentes sin necesidad de pasar
`initialValue` a cada `FormBuilderField` individualmente.

### 5. autovalidateMode — cuándo se dispara la validación

```dart
FormBuilder(
  key: _formKey,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  child: /* ... */,
)
```

| Valor | Comportamiento |
|---|---|
| `AutovalidateMode.disabled` (default) | Solo valida cuando llamas `saveAndValidate()` manualmente |
| `AutovalidateMode.always` | Valida en cada cambio de cada campo — abrumador, "grita" errores mientras el usuario aún está escribiendo |
| `AutovalidateMode.onUserInteraction` | Valida un campo **después** de que el usuario interactuó con él — el balance recomendado |

> ⚠️ `AutovalidateMode.always` desde el primer frame muestra errores de campos vacíos que el
> usuario ni siquiera ha tocado — una mala primera impresión. Este curso usa
> `onUserInteraction` como default (archivo 6 profundiza en el porqué).

## ✅ Checklist de Verificación

- [ ] Sé explicar las 2 cosas que hace `saveAndValidate()`
- [ ] Sé usar `reset()` después de un envío exitoso
- [ ] Sé para qué sirve `patchValue()`
- [ ] Sé la diferencia entre las 3 opciones de `autovalidateMode`

## 📚 Próximo paso

[Envío de Formularios con Dio y Riverpod →](05-envio-de-formularios-con-dio-y-riverpod.md)
