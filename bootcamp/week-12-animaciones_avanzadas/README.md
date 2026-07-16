# Semana 12 — Animaciones Avanzadas

> **Fase 3 — Avanzado** | Semana 12 de 19 | ⏱️ 16 horas

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Controlar el tiempo de una animación explícitamente con `AnimationController`
- [ ] Transformar el rango 0.0–1.0 de un controller en valores reales con `Tween`/`ColorTween`
- [ ] Reconstruir solo el subárbol necesario con `AnimatedBuilder` y los `*Transition`
- [ ] Secuenciar animaciones en un mismo controller con `Interval` y `TweenSequence`
- [ ] Dibujar formas custom animadas con `CustomPainter` conectado a un `AnimationController`
- [ ] Evitar fugas de memoria liberando controllers en `dispose()`

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

1. [AnimationController y Ticker](1-teoria/01-animationcontroller-y-ticker.md)
2. [Tween y Animation&lt;T&gt;](1-teoria/02-tween-y-animation.md)
3. [AnimatedBuilder](1-teoria/03-animatedbuilder.md)
4. [Animaciones Encadenadas: Interval y TweenSequence](1-teoria/04-animaciones-encadenadas.md)
5. [CustomPainter Animado](1-teoria/05-custompainter-animado.md)
6. [Buenas Prácticas: Ciclo de Vida y Performance](1-teoria/06-buenas-practicas-ciclo-de-vida.md)

### Prácticas

1. [Ejercicio 01 — AnimationController Básico](2-practicas/ejercicio-01-animationcontroller-basico/README.md)
2. [Ejercicio 02 — Tween y AnimatedBuilder Encadenado](2-practicas/ejercicio-02-tween-animatedbuilder-encadenado/README.md)
3. [Ejercicio 03 — CustomPainter Animado](2-practicas/ejercicio-03-custompainter-animado/README.md)

### Proyecto

[Animaciones Avanzadas](3-proyecto/README.md) — agrega un indicador de carga custom
(`LoadingRing`, `CustomPainter` + `AnimationController.repeat()`) y un "pop" de escala al marcar
favoritos, sobre el proyecto Clean Architecture de semanas 10-11.

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

[← Semana 11 — Animaciones Básicas](../week-11-animaciones_basicas/README.md) | [Semana 13 — APIs Nativas y Platform Channels →](../week-13-apis_nativas_platform_channels/README.md)
