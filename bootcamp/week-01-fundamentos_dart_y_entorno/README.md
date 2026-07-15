# Semana 01 — Fundamentos de Dart y Entorno

> **Fase 0 — Lenguaje (Dart)** | Semana 1 de 19 | ⏱️ 16 horas

Esta semana no toca Flutter todavía: dominarás Dart, el lenguaje sobre el que se construye todo
el resto del bootcamp, siguiendo el mismo patrón "lenguaje puente → framework" que otros
bootcamps de este catálogo (ej. TypeScript antes de React).

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Declarar variables con `var`/`final`/`const` y justificar cuál usar en cada caso
- [ ] Aplicar null safety (`?`, `?.`, `??`, `??=`, `!`, `late`) sin recurrir a `!` por defecto
- [ ] Escribir funciones con parámetros nombrados/posicionales y usar `switch` como expresión
- [ ] Manipular `List`, `Set` y `Map` con operadores de colección y métodos funcionales
- [ ] Diseñar clases con constructores `const`, herencia y mixins
- [ ] Escribir código asíncrono con `Future`/`async`/`await` y manejar errores con `try/catch`
- [ ] Diferenciar cuándo usar `Future` y cuándo `Stream`
- [ ] Ejecutar y validar código Dart con Docker (`dart analyze`/`dart test`) y con el SDK local

## 📚 Requisitos previos

- Programación básica orientada a objetos (no requiere Dart previo)
- Docker instalado (ver [docs/setup/con-docker.md](../../docs/setup/con-docker.md))
- Flutter SDK local instalado (`flutter --version` funcionando — incluye Dart; ver
  [docs/setup/sdk-local.md](../../docs/setup/sdk-local.md))

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Introducción a Dart y al Entorno de Trabajo](1-teoria/01-introduccion-dart-y-entorno.md)
2. [Variables, Tipos y Null Safety](1-teoria/02-variables-tipos-null-safety.md)
3. [Funciones y Control de Flujo](1-teoria/03-funciones-y-control-de-flujo.md)
4. [Colecciones: List, Set y Map](1-teoria/04-colecciones.md)
5. [POO: Clases, Mixins y Extension Methods](1-teoria/05-poo-clases-mixins-extensiones.md)
6. [Programación Asíncrona: Future, async/await y Stream](1-teoria/06-programacion-asincronica.md)

### Prácticas

1. [Ejercicio 01 — Variables, Tipos y Null Safety](2-practicas/ejercicio-01-variables-null-safety/README.md)
2. [Ejercicio 02 — Colecciones y Funciones](2-practicas/ejercicio-02-colecciones-y-funciones/README.md)
3. [Ejercicio 03 — POO y Programación Asíncrona](2-practicas/ejercicio-03-poo-y-async/README.md)

### Proyecto

[Modelador de Dominio en Consola](3-proyecto/README.md) — integra null safety, colecciones,
mixins y Future/async/await sobre el dominio único asignado.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado
- [ ] `dart analyze` sin errores (verificable con Docker)
- [ ] `dart test` pasando
- [ ] Programa ejecutándose por consola con `dart run` (sin emulador — esta semana es Dart puro)

## 🔗 Navegación

← (primera semana) | [Semana 02 — Widgets y Layout →](../week-02-widgets_y_layout/README.md)
