# Buenas Prácticas de Formularios Móviles

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué el teclado correcto importa más en mobile que en web
- Cómo ordenar el foco entre campos
- Consideraciones de accesibilidad en formularios

## 📋 Conceptos Clave

### 1. keyboardType — el teclado correcto para cada dato

En web, el usuario siempre tiene un teclado físico completo. En mobile, el teclado en pantalla
**cambia según el dato esperado** — elegir mal agrega fricción innecesaria:

| Dato | keyboardType |
|---|---|
| Texto libre | `TextInputType.text` (default) |
| Correo | `TextInputType.emailAddress` (agrega `@` visible) |
| Teléfono | `TextInputType.phone` (teclado numérico + `+`/`*`/`#`) |
| Número entero | `TextInputType.number` |
| Número decimal | `TextInputType.numberWithOptions(decimal: true)` |
| Texto largo (descripción) | `TextInputType.multiline` + `maxLines: null` |

### 2. textInputAction — qué hace el botón "siguiente" del teclado

```dart
FormBuilderTextField(
  name: 'name',
  textInputAction: TextInputAction.next, // el teclado muestra "Siguiente →"
),
FormBuilderTextField(
  name: 'description',
  textInputAction: TextInputAction.done, // el teclado muestra "Listo" (último campo)
),
```

Sin esto, cada campo muestra "Listo" por defecto, y el usuario debe cerrar el teclado y tocar el
siguiente campo manualmente — un paso extra multiplicado por cada campo del formulario.

### 3. autovalidateMode — por qué onUserInteraction es el default de este curso

Retomando el archivo 4: `AutovalidateMode.always` muestra errores de campos vacíos **antes** de
que el usuario haya tenido oportunidad de llenarlos — se siente como si la app "regañara" sin
motivo. `onUserInteraction` espera a que el usuario haya tocado el campo al menos una vez, lo
que coincide con la expectativa de la mayoría de apps que el estudiante ya usa a diario
(Instagram, formularios de registro típicos).

### 4. Mensajes de error accesibles

- Cada `errorText` debe ser una frase completa y accionable ("El correo es obligatorio", no solo
  "Requerido") — un lector de pantalla (`TalkBack`/`VoiceOver`) lo lee tal cual al usuario.
- Nunca uses solo color para indicar error (un borde rojo sin texto) — usuarios con daltonismo o
  con lector de pantalla no lo perciben. `FormBuilderField` ya maneja esto por ti (el mensaje de
  `errorText` siempre se muestra como texto, no solo como color).

### 5. Checklist de buenas prácticas de la semana

- ✅ `keyboardType` apropiado según el dato de cada campo
- ✅ `textInputAction: next` en todos los campos salvo el último (`done`)
- ✅ `autovalidateMode: onUserInteraction` (no `always`, no dejar en `disabled` sin validar nunca)
- ✅ `errorText` siempre personalizado, en español, como frase completa y accionable
- ✅ Campos deshabilitados (`enabled: false`) durante un envío en curso
- ✅ Feedback visual claro de éxito y de error (`SnackBar`, no solo un cambio silencioso)
- ✅ El formulario se resetea o navega hacia atrás tras un envío exitoso

## ✅ Checklist de Verificación

- [ ] Sé elegir el `keyboardType` correcto para al menos 4 tipos de dato distintos
- [ ] Sé configurar `textInputAction` para encadenar campos con el botón del teclado
- [ ] Sé explicar por qué `AutovalidateMode.always` es una mala experiencia por defecto
- [ ] Repasé el checklist completo de buenas prácticas de la semana

## 📚 Siguiente paso

Con la teoría completa, continúa con las [prácticas guiadas](../2-practicas/) — el primer
ejercicio construye un `FormBuilder` desde cero con un solo campo de texto.
