# Glosario — Semana 07: Formularios y Validación

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## A

**AsyncValue.guard()**: helper de Riverpod que ejecuta un `Future` y lo envuelve
automáticamente en `AsyncData` (éxito) o `AsyncError` (excepción) — evita escribir
`try`/`catch` manual en el envío de un formulario.

**autovalidateMode**: propiedad de `FormBuilder`/`FormBuilderField` que controla cuándo se
dispara la validación — `disabled`, `always`, `onUserInteraction` (el default de este curso:
valida solo después de que el usuario tocó el campo).

## C

**compose()**: método de `FormBuilderValidators` que combina varios validadores en uno solo,
ejecutándolos en orden y devolviendo el primer mensaje de error que falle.

## F

**FormBuilder**: widget raíz de `flutter_form_builder` que centraliza el estado de todos sus
campos hijos en un único `FormBuilderState`, accesible vía `GlobalKey<FormBuilderState>`.

**FormBuilderCheckbox**: campo de `flutter_form_builder` para un valor booleano (aceptar
términos, marcar una opción).

**FormBuilderDateTimePicker**: campo de `flutter_form_builder` que abre un selector nativo de
fecha/hora y expone el resultado como `DateTime`.

**FormBuilderDropdown**: campo de `flutter_form_builder` para selección única entre una lista
de opciones (`DropdownButtonFormField` con la misma API base que el resto de campos).

**FormBuilderState**: objeto accesible vía `_formKey.currentState` que expone
`saveAndValidate()`, `reset()`, `patchValue()` y el mapa `value` con los datos del formulario.

**FormBuilderTextField**: campo de `flutter_form_builder` para texto y números, envoltorio de
`TextFormField` que se integra con el estado centralizado del `FormBuilder`.

**FormBuilderValidators**: clase con validadores listos para usar (`required()`, `email()`,
`minLength()`, `numeric()`, etc.) del paquete `form_builder_validators`.

## G

**GlobalKey\<FormBuilderState\>**: referencia que permite acceder al estado del formulario
desde fuera del árbol de widgets — necesaria porque `FormBuilder` no expone su estado vía
Riverpod (es estado de UI efímero, no estado de la app).

## K

**keyboardType**: propiedad de un campo de texto que determina qué teclado nativo muestra el
dispositivo (`TextInputType.emailAddress`, `TextInputType.number`, etc.) — mejora la UX al
reducir fricción de tecleo.

## P

**patchValue()**: método de `FormBuilderState` que precarga valores en los campos sin marcar el
formulario como "tocado" — usado en formularios de edición.

## R

**reset()**: método de `FormBuilderState` que limpia todos los campos y su estado de
validación, devolviéndolos a los valores iniciales.

## S

**saveAndValidate()**: método central de `FormBuilderState` — valida todos los campos y, si
todos son válidos, guarda sus valores en `FormBuilderState.value`; retorna `true`/`false`.

## T

**textInputAction**: propiedad de un campo de texto que determina la acción del botón de
"acción" del teclado (`next`, `done`, `send`) — controla el orden de foco entre campos.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
