# 📅 Semana 9: Arquitectura y Testing

![Clean Architecture](./0-assets/clean-architecture-diagram.svg)

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, serás capaz de:

- [ ] Implementar Clean Architecture en aplicaciones Flutter
- [ ] Aplicar los principios SOLID en el diseño de software
- [ ] Configurar inyección de dependencias con get_it
- [ ] Escribir tests unitarios con el patrón AAA
- [ ] Crear widget tests con WidgetTester
- [ ] Implementar tests de BLoC con bloc_test
- [ ] Documentar código con dartdoc
- [ ] Optimizar rendimiento de aplicaciones Flutter

---

## 📋 Índice de Contenidos

| Sección | Contenido | Tiempo |
|---------|-----------|--------|
| 📚 Teoría | 4 módulos de fundamentos | 3h |
| 💻 Prácticas | 5 ejercicios guiados | 2.5h |
| 🔨 Proyecto | TaskManager Pro | 2.5h |
| **Total** | | **8h** |

---

## 📚 Contenido Teórico

### Módulos de Teoría

| # | Tema | Archivo | Duración |
|---|------|---------|----------|
| 1 | Clean Architecture | [01-clean-architecture.md](./1-teoria/01-clean-architecture.md) | 50 min |
| 2 | Testing Unitario | [02-testing-unitario.md](./1-teoria/02-testing-unitario.md) | 45 min |
| 3 | Widget Testing | [03-widget-testing.md](./1-teoria/03-widget-testing.md) | 45 min |
| 4 | Documentación y Optimización | [04-documentacion-optimizacion.md](./1-teoria/04-documentacion-optimizacion.md) | 40 min |

### Conceptos Clave

#### Clean Architecture

```
┌─────────────────────────────────────────────┐
│           PRESENTATION LAYER                │
│      (Widgets, Screens, BLoC/Provider)      │
├─────────────────────────────────────────────┤
│             DOMAIN LAYER                    │
│    (Entities, Use Cases, Repositories*)     │
├─────────────────────────────────────────────┤
│              DATA LAYER                     │
│   (Models, Repo Impl, Data Sources, API)    │
└─────────────────────────────────────────────┘
        * Repository = Interfaces
```

#### Principios SOLID

| Principio | Nombre | Descripción |
|-----------|--------|-------------|
| **S** | Single Responsibility | Una clase, una responsabilidad |
| **O** | Open/Closed | Abierto a extensión, cerrado a modificación |
| **L** | Liskov Substitution | Subtipos deben ser sustituibles |
| **I** | Interface Segregation | Interfaces pequeñas y específicas |
| **D** | Dependency Inversion | Depender de abstracciones |

#### Pirámide de Testing

```
        /\
       /  \       Integration Tests (pocos)
      /----\
     /      \     Widget Tests (algunos)
    /--------\
   /          \   Unit Tests (muchos)
  /------------\
```

---

## 💻 Prácticas

| # | Práctica | Archivo | Tiempo | Dificultad |
|---|----------|---------|--------|------------|
| 1 | Estructura Clean | [practica-01-clean-structure.md](./2-practicas/practica-01-clean-structure.md) | 45 min | ⭐⭐ |
| 2 | Tests Unitarios | [practica-02-unit-tests.md](./2-practicas/practica-02-unit-tests.md) | 45 min | ⭐⭐ |
| 3 | Widget Tests | [practica-03-widget-tests.md](./2-practicas/practica-03-widget-tests.md) | 45 min | ⭐⭐⭐ |
| 4 | BLoC Tests | [practica-04-bloc-tests.md](./2-practicas/practica-04-bloc-tests.md) | 50 min | ⭐⭐⭐ |
| 5 | Integration Tests | [practica-05-integration-tests.md](./2-practicas/practica-05-integration-tests.md) | 50 min | ⭐⭐⭐⭐ |

### Objetivos por Práctica

1. **Clean Structure**: Crear estructura de carpetas Clean Architecture
2. **Unit Tests**: Implementar tests unitarios con mocks
3. **Widget Tests**: Testear widgets con WidgetTester
4. **BLoC Tests**: Probar estados y eventos de BLoC
5. **Integration Tests**: Tests end-to-end de flujos completos

---

## 🔨 Proyecto de la Semana: TaskManager Pro

### Descripción

Aplicación de gestión de tareas implementada con **Clean Architecture** y **cobertura completa de tests**.

### Documentación del Proyecto

| Documento | Descripción |
|-----------|-------------|
| [README.md](./3-proyecto/README.md) | Especificaciones y requisitos |
| [GUIA-DISENO.md](./3-proyecto/GUIA-DISENO.md) | Sistema de diseño y componentes |
| [EJEMPLOS-DATOS.md](./3-proyecto/EJEMPLOS-DATOS.md) | Modelos, entidades y datos mock |

### Características Principales

- ✅ Crear, editar, eliminar y listar tareas
- ✅ Filtrar por estado (pendiente, en progreso, completada)
- ✅ Búsqueda de tareas
- ✅ Prioridades y categorías
- ✅ Clean Architecture con 3 capas
- ✅ Inyección de dependencias con get_it
- ✅ Mínimo 15 tests (unit + widget + bloc)

### Stack Tecnológico

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  get_it: ^7.6.4
  dartz: ^0.10.1
  equatable: ^2.0.5
  uuid: ^4.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  bloc_test: ^9.1.5
  build_runner: ^2.4.7
```

---

## 📖 Recursos

### Índice de Recursos

| Recurso | Archivo | Tipo |
|---------|---------|------|
| Videos Clean Architecture | [01-videos-clean-architecture.md](./4-recursos/01-videos-clean-architecture.md) | 📹 |
| Videos Testing | [02-videos-testing.md](./4-recursos/02-videos-testing.md) | 📹 |
| Videos SOLID | [03-videos-solid.md](./4-recursos/03-videos-solid.md) | 📹 |
| eBooks y Artículos | [ebooks-articulos.md](./4-recursos/ebooks-articulos.md) | 📖 |
| Webgrafía | [webgrafia.md](./4-recursos/webgrafia.md) | 🌐 |

### Documentación Oficial

- [Flutter Testing](https://docs.flutter.dev/testing)
- [Dart Testing](https://dart.dev/guides/testing)
- [Effective Dart](https://dart.dev/effective-dart)

### Packages Esenciales

| Package | Uso | Docs |
|---------|-----|------|
| `flutter_test` | Widget testing | [pub.dev](https://pub.dev/packages/flutter_test) |
| `mockito` | Mocking | [pub.dev](https://pub.dev/packages/mockito) |
| `bloc_test` | BLoC testing | [pub.dev](https://pub.dev/packages/bloc_test) |
| `get_it` | Service locator | [pub.dev](https://pub.dev/packages/get_it) |
| `dartz` | Functional programming | [pub.dev](https://pub.dev/packages/dartz) |

---

## 📊 Diagramas y Assets

| Diagrama | Archivo | Descripción |
|----------|---------|-------------|
| Clean Architecture | [clean-architecture-diagram.svg](./0-assets/clean-architecture-diagram.svg) | Capas concéntricas |
| Capas | [capas-clean-architecture.svg](./0-assets/capas-clean-architecture.svg) | Layers horizontales |
| Pirámide Testing | [testing-pyramid.svg](./0-assets/testing-pyramid.svg) | Tipos de tests |
| Ciclo TDD | [tdd-cycle.svg](./0-assets/tdd-cycle.svg) | Red-Green-Refactor |
| SOLID | [solid-principles.svg](./0-assets/solid-principles.svg) | 5 principios |
| DI | [dependency-injection.svg](./0-assets/dependency-injection.svg) | Inyección dependencias |

---

## 📖 Glosario

Consulta el [Glosario completo](./5-glosario/README.md) con más de 100 términos sobre:

- Clean Architecture
- Testing (Unit, Widget, Integration)
- Principios SOLID
- Patrones de diseño
- Inyección de dependencias

---

## ✅ Checklist de Completitud

### Teoría
- [ ] Clean Architecture leída y comprendida
- [ ] Testing Unitario estudiado
- [ ] Widget Testing practicado
- [ ] Documentación y optimización revisada

### Prácticas
- [ ] Práctica 1: Estructura Clean completada
- [ ] Práctica 2: Tests unitarios funcionando
- [ ] Práctica 3: Widget tests pasando
- [ ] Práctica 4: BLoC tests implementados
- [ ] Práctica 5: Integration tests ejecutados

### Proyecto
- [ ] Estructura Clean Architecture creada
- [ ] CRUD de tareas implementado
- [ ] DI con get_it configurado
- [ ] Mínimo 5 unit tests
- [ ] Mínimo 3 widget tests
- [ ] Mínimo 3 BLoC tests
- [ ] README del proyecto escrito

---

## 🎓 Evaluación

### Distribución de Puntos

| Componente | Peso | Puntos |
|------------|------|--------|
| Teoría | 15% | 15 |
| Prácticas (5) | 35% | 35 |
| Proyecto | 40% | 40 |
| Calidad del código | 10% | 10 |
| **Total** | 100% | **100** |

### Criterios de Aprobación

- Mínimo **60 puntos** totales
- Al menos **3 prácticas** completadas (≥ 4/7)
- Proyecto con estructura Clean Architecture
- Mínimo **5 tests** pasando

📋 [Ver Rúbrica Completa](./RUBRICA-EVALUACION.md)

---

## 📅 Planificación Sugerida

### Día 1 (3 horas)
- [ ] Teoría: Clean Architecture (50 min)
- [ ] Teoría: Testing Unitario (45 min)
- [ ] Práctica 1: Estructura Clean (45 min)
- [ ] Práctica 2: Unit Tests (45 min)

### Día 2 (3 horas)
- [ ] Teoría: Widget Testing (45 min)
- [ ] Teoría: Documentación (40 min)
- [ ] Práctica 3: Widget Tests (45 min)
- [ ] Práctica 4: BLoC Tests (50 min)

### Día 3 (2 horas)
- [ ] Práctica 5: Integration Tests (50 min)
- [ ] Proyecto: Inicio TaskManager Pro (70 min)

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Índice | Siguiente ➡️ |
|-------------|-----------|--------------|
| [Semana 8: Características Nativas](../semana-08/README.md) | [Bootcamp](../README.md) | [Semana 10: Proyecto Final](../semana-10/README.md) |

---

> **💡 Tip de la semana:** "El código no testado es código roto esperando ser descubierto" - Escribe tests desde el primer día.
