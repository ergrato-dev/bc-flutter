# Semana 15 — Testing

> **Fase 3 — Avanzado** | Semana 15 de 19 | ⏱️ 16 horas

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Escribir unit tests con `flutter_test` para lógica pura (use cases, entidades)
- [ ] Simular repositorios con `mocktail` (`when`, `verify`, `registerFallbackValue`)
- [ ] Escribir widget tests: `pumpWidget`, `find`, `tester.tap`, `pumpAndSettle`
- [ ] Probar Cubits con `bloc_test` (`blocTest`, `seed`, `act`, `expect`)
- [ ] Detectar regresiones visuales con golden tests (`matchesGoldenFile`)
- [ ] Escribir un flujo E2E con `integration_test` y entender la pirámide de testing

## 📚 Requisitos previos

- Semana 14 completada (Clean Architecture + Bloc/Cubit + Push Notifications)
- Flutter SDK local configurado (`flutter doctor` sin errores) + Docker

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Unit Testing con flutter_test](1-teoria/01-unit-testing-con-flutter-test.md)
2. [Mocking con mocktail](1-teoria/02-mocking-con-mocktail.md)
3. [Widget Testing](1-teoria/03-widget-testing.md)
4. [Testing de Cubits con bloc_test](1-teoria/04-testing-de-cubits-con-bloc-test.md)
5. [Golden Tests](1-teoria/05-golden-tests.md)
6. [Integration Tests y Buenas Prácticas](1-teoria/06-integration-tests-y-buenas-practicas.md)

### Prácticas

1. [Ejercicio 01 — Unit Test con mocktail](2-practicas/ejercicio-01-unit-test-con-mocktail/README.md)
2. [Ejercicio 02 — Widget Test de un Formulario](2-practicas/ejercicio-02-widget-test-formulario/README.md)
3. [Ejercicio 03 — bloc_test de un Cubit](2-practicas/ejercicio-03-bloc-test-cubit/README.md)

### Proyecto

[Testing](3-proyecto/README.md) — agrega una suite de tests (unit, widget y de Cubit) al proyecto
Clean Architecture de semanas 10-14.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado, con su suite de tests pasando
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 14 — Push Notifications](../week-14-push_notifications/README.md) | [Semana 16 — Performance y DevTools →](../week-16-performance_devtools/README.md)
