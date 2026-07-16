# Semana 11 — Animaciones Básicas

> **Fase 3 — Avanzado** | Semana 11 de 19 | ⏱️ 16 horas

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Diferenciar animaciones implícitas de explícitas y elegir la correcta para cada caso
- [ ] Animar propiedades de un widget con `AnimatedContainer` y la familia `Animated*`
- [ ] Elegir `Curves` y `Duration` con criterio, en vez de valores arbitrarios
- [ ] Implementar transiciones `Hero` entre pantallas de lista y detalle
- [ ] Animar reemplazos de widgets con `AnimatedSwitcher` y altas/bajas con `AnimatedList`
- [ ] Aplicar buenas prácticas de rendimiento (`const`, `RepaintBoundary`) en widgets animados

## 📚 Requisitos previos

- Semana anterior completada
- Flutter SDK local configurado (`flutter doctor` sin errores) + Docker

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Introducción a Animaciones Implícitas](1-teoria/01-introduccion-a-animaciones-implicitas.md)
2. [AnimatedContainer y Widgets Animados Implícitos](1-teoria/02-animatedcontainer-y-widgets-animados.md)
3. [Curves y Duration](1-teoria/03-curves-y-duration.md)
4. [Hero Animations](1-teoria/04-hero-animations.md)
5. [AnimatedSwitcher y AnimatedList](1-teoria/05-animatedswitcher-y-animatedlist.md)
6. [Buenas Prácticas y Rendimiento en Animaciones](1-teoria/06-buenas-practicas-y-rendimiento.md)

### Prácticas

1. [Ejercicio 01 — AnimatedContainer](2-practicas/ejercicio-01-animatedcontainer-tarjeta-expandible/README.md)
2. [Ejercicio 02 — Hero entre Pantallas](2-practicas/ejercicio-02-hero-entre-pantallas/README.md)
3. [Ejercicio 03 — AnimatedSwitcher y AnimatedList](2-practicas/ejercicio-03-animatedswitcher-y-animatedlist/README.md)

### Proyecto

[Animaciones Básicas](3-proyecto/README.md) — agrega `Hero`, `AnimatedContainer` y
`AnimatedSwitcher` al proyecto Clean Architecture de semana 10, sin romper su arquitectura ni
cambiar de gestor de estado.

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

[← Semana 10 — Clean Architecture y Bloc](../week-10-clean_architecture_y_bloc/README.md) | [Semana 12 — Animaciones Avanzadas →](../week-12-animaciones_avanzadas/README.md)
