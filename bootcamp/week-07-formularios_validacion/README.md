# Semana 07 — Formularios y Validación

> **Fase 2 — Estado y Datos** | Semana 7 de 19 | ⏱️ 16 horas

Esta semana agrega formularios con validación al proyecto de semana 6 — un usuario podrá crear
un nuevo elemento de tu dominio, validado en el cliente y enviado a la API vía Dio.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar por qué `flutter_form_builder` reduce el boilerplate frente a `Form` +
      `TextEditingController` manual
- [ ] Construir un formulario con `FormBuilder` y distintos tipos de campo
      (`FormBuilderTextField`, `FormBuilderDropdown`, `FormBuilderCheckbox`)
- [ ] Componer validadores con `FormBuilderValidators.compose()` y escribir un validador propio
- [ ] Leer y validar el estado del formulario con `formKey.currentState`
- [ ] Deshabilitar el formulario durante un envío asíncrono y mostrar el resultado (éxito/error)
- [ ] Aplicar buenas prácticas de UX en formularios móviles (`keyboardType`, `autovalidateMode`,
      orden de foco, accesibilidad)

## 📚 Requisitos previos

- Semana 6 (Networking con Dio y Riverpod) completada — Dio, `DioException`, repository pattern
- Flutter SDK local configurado (`flutter doctor` sin errores) + emulador/simulador corriendo
- Docker (para `flutter analyze`/`flutter test` reproducibles)

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Introducción a Formularios en Flutter](1-teoria/01-introduccion-a-formularios-en-flutter.md)
2. [FormBuilderFields y Tipos de Campo](1-teoria/02-formbuilderfields-y-tipos-de-campo.md)
3. [Validadores con form_builder_validators](1-teoria/03-validadores-con-form-builder-validators.md)
4. [Manejo del Estado del Formulario](1-teoria/04-manejo-de-estado-del-formulario.md)
5. [Envío de Formularios con Dio y Riverpod](1-teoria/05-envio-de-formularios-con-dio-y-riverpod.md)
6. [Buenas Prácticas de Formularios Móviles](1-teoria/06-buenas-practicas-de-formularios-moviles.md)

### Prácticas

1. [Ejercicio 01 — FormBuilder Básico](2-practicas/ejercicio-01-formbuilder-basico/README.md)
2. [Ejercicio 02 — Validadores Compuestos y Tipos de Campo](2-practicas/ejercicio-02-validadores-compuestos-y-tipos-de-campo/README.md)
3. [Ejercicio 03 — Envío con Dio y Riverpod](2-practicas/ejercicio-03-envio-con-dio-y-riverpod/README.md)

### Proyecto

[Formulario de Creación con Validación](3-proyecto/README.md) — agrega una pantalla para crear
un nuevo elemento de tu dominio, validado con `FormBuilder` y enviado vía
`ItemsRepository.createItem()` (POST real con Dio), sobre el proyecto de semana 6.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado, con formulario de creación funcional
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 06 — Networking con Dio y Riverpod](../week-06-networking_dio_riverpod/README.md) | [Semana 08 — Persistencia Local →](../week-08-persistencia_local/README.md)
