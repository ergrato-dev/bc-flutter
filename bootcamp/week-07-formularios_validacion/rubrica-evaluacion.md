# Rúbrica de Evaluación — Semana 07

## Distribución de Puntaje

| Tipo de Evidencia    | Peso | Instrumento             |
| -------------------- | ---- | ------------------------ |
| Conocimiento 🧠      | 30%  | Cuestionario teórico     |
| Desempeño 💪         | 40%  | Ejercicios en clase      |
| Producto 📦          | 30%  | Proyecto entregable      |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

| Criterio | Puntos |
|---|---|
| Por qué `FormBuilder` sobre `Form` + `TextEditingController` manual | 15 |
| Tipos de campo (`FormBuilderTextField`, `FormBuilderDropdown`, `FormBuilderCheckbox`) y su rol | 20 |
| `FormBuilderValidators.compose()` y escritura de un validador propio | 25 |
| `formKey.currentState.saveAndValidate()` — qué retorna y cuándo usarlo | 20 |
| `autovalidateMode` — diferencia entre validar en cada tecla y al interactuar | 20 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (FormBuilder básico) | 30 | Los 3 pasos descomentados, `saveAndValidate()` muestra los valores correctos |
| Ejercicio 02 (validadores compuestos y tipos de campo) | 35 | Los 3 pasos descomentados, dropdown/checkbox funcionando, validación compuesta rechaza valores inválidos |
| Ejercicio 03 (envío con Dio y Riverpod) | 35 | Los 3 pasos descomentados, formulario deshabilitado durante el envío, feedback de éxito/error correcto |

## 📦 Producto (30%)

Proyecto **Formulario de Creación con Validación**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `ItemsRepository.createItem()` implementado (POST real con Dio, error traducido) | 25 |
| Formulario con `FormBuilder` — al menos 3 campos de tu dominio con validadores coherentes | 25 |
| Formulario deshabilitado durante el envío, con feedback visual de éxito/error | 20 |
| Al crear un elemento, la lista se actualiza (`ref.invalidate(itemsProvider)`) | 10 |
| `flutter analyze` sin errores y `flutter test` pasando | 20 |

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ App funcional en emulador/simulador iOS y/o Android
- ✅ `flutter analyze` sin errores
- ✅ `flutter test` pasando (verificable con Docker:
  `docker compose run --rm flutter flutter test`)

## Escala de Calificación

| Rango | Nivel |
|---|---|
| 90-100% | Sobresaliente |
| 80-89% | Notable |
| 70-79% | Aprobado |
| < 70% | No aprobado (requiere recuperación) |

## Formato de Entrega

- Repositorio del estudiante, carpeta `week-07/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-07): complete form validation project`
- Fecha límite: fin de la semana 7, antes de iniciar semana 8
