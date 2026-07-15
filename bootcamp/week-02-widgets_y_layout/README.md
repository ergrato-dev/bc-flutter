# Semana 02 — Widgets y Layout

> **Fase 1 — Fundamentos Flutter** | Semana 2 de 19 | ⏱️ 16 horas

Primera semana con Flutter real (semana 1 fue solo Dart). Construirás tu primera pantalla
completa: widgets, layout con Row/Column, listas y una interacción básica de usuario.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar la diferencia entre `StatelessWidget` y `StatefulWidget` y elegir correctamente
- [ ] Levantar una pantalla con `MaterialApp` + `Scaffold` + `AppBar`
- [ ] Construir layouts combinando `Row`/`Column`/`Expanded`/`Spacer` sin overflow
- [ ] Aplicar estilos de texto y espaciado con `TextStyle`, `Padding`, `SizedBox` y `Container`
- [ ] Renderizar colecciones de datos con `ListView.builder`
- [ ] Capturar texto de usuario con `TextField`/`TextEditingController` y reaccionar con `setState`
- [ ] Ejecutar y depurar una app Flutter real con el SDK local y validarla con Docker

## 📚 Requisitos previos

- Semana 1 (Fundamentos de Dart) completada
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

1. [Introducción a los Widgets](1-teoria/01-introduccion-a-los-widgets.md)
2. [MaterialApp, Scaffold y Cupertino](1-teoria/02-material-app-y-scaffold.md)
3. [Layout: Row, Column y Flex](1-teoria/03-layout-row-column-flex.md)
4. [Widgets Básicos y Estilos](1-teoria/04-widgets-basicos-y-estilos.md)
5. [Listas con ListView](1-teoria/05-listas-con-listview.md)
6. [Inputs Básicos: TextField y Manejo de Eventos](1-teoria/06-inputs-basicos.md)

### Prácticas

1. [Ejercicio 01 — Widget Tree, MaterialApp y Scaffold](2-practicas/ejercicio-01-widget-tree-y-scaffold/README.md)
2. [Ejercicio 02 — Layout con Row, Column y Expanded](2-practicas/ejercicio-02-layout-row-column/README.md)
3. [Ejercicio 03 — ListView, TextField y Filtrado](2-practicas/ejercicio-03-listview-e-inputs/README.md)

### Proyecto

[Pantalla de Lista del Dominio](3-proyecto/README.md) — tu primera app Flutter real: lista con
buscador sobre el dominio único asignado.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 01 — Fundamentos de Dart y Entorno](../week-01-fundamentos_dart_y_entorno/README.md) | [Semana 03 — Navegación con go_router →](../week-03-navegacion_go_router/README.md)
