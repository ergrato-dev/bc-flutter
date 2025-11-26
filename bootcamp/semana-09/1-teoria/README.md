# 📚 Teoría - Semana 9: Arquitectura y Testing

## 📋 Índice de Módulos

Esta carpeta contiene el material teórico de la Semana 9, enfocada en **Clean Architecture y Testing** en Flutter.

## 🗂️ Módulos

| #   | Módulo             | Archivo                                                  | Duración | Descripción                     |
| --- | ------------------ | -------------------------------------------------------- | -------- | ------------------------------- |
| 1   | Clean Architecture | [`01-clean-architecture.md`](./01-clean-architecture.md) | 2h       | Capas, SOLID, estructura        |
| 2   | Testing Unitario   | [`02-testing-unitario.md`](./02-testing-unitario.md)     | 1.5h     | Unit tests, mocking, TDD        |
| 3   | Widget Testing     | [`03-widget-testing.md`](./03-widget-testing.md)         | 1h       | WidgetTester, finders, matchers |

## 🎯 Objetivos por Módulo

### Módulo 1: Clean Architecture

- Comprender las capas de Clean Architecture
- Aplicar principios SOLID en Flutter
- Estructurar proyectos escalables
- Implementar el patrón Repository
- Crear Use Cases reutilizables

### Módulo 2: Testing Unitario

- Escribir tests unitarios efectivos
- Usar el patrón AAA (Arrange, Act, Assert)
- Implementar mocks con Mockito
- Aplicar Test-Driven Development (TDD)
- Medir cobertura de código

### Módulo 3: Widget Testing

- Usar WidgetTester para tests de UI
- Encontrar widgets con finders
- Simular interacciones de usuario
- Verificar estados de widgets
- Testear widgets con Provider/BLoC

## 📦 Packages Utilizados

```yaml
dev_dependencies:
  # Testing
  flutter_test:
    sdk: flutter
  test: ^1.24.9
  mockito: ^5.4.4
  build_runner: ^2.4.8
  bloc_test: ^9.1.5

  # Code generation
  freezed: ^2.4.6
  json_serializable: ^6.7.1

dependencies:
  # Architecture
  dartz: ^0.10.1
  get_it: ^7.6.4
  injectable: ^2.3.2
  equatable: ^2.0.5
```

## 🔗 Prerequisitos

Antes de comenzar esta semana, asegúrate de:

- [ ] Dominar Dart y POO
- [ ] Conocer gestión de estado (Provider/BLoC)
- [ ] Entender async/await y Futures
- [ ] Haber completado semanas 1-8

## 📊 Distribución del Tiempo

```
Módulo 1: Clean Architecture    ████████████████████░░░░  2.0h (44%)
Módulo 2: Testing Unitario      ████████████░░░░░░░░░░░░  1.5h (33%)
Módulo 3: Widget Testing        ████████░░░░░░░░░░░░░░░░  1.0h (23%)
                                ─────────────────────────
Total Teoría:                                             4.5h
```

## 🗺️ Mapa de Conceptos

```
Clean Architecture
├── Presentation Layer
│   ├── Widgets
│   ├── Pages/Screens
│   └── State Management (BLoC/Provider)
├── Domain Layer
│   ├── Entities
│   ├── Use Cases
│   └── Repository Interfaces
└── Data Layer
    ├── Models
    ├── Data Sources (Remote/Local)
    └── Repository Implementations

Testing
├── Unit Tests
│   ├── Functions/Methods
│   ├── Classes
│   └── Use Cases
├── Widget Tests
│   ├── Individual Widgets
│   ├── Widget Trees
│   └── User Interactions
└── Integration Tests
    ├── Feature Flows
    └── End-to-End
```

## 📖 Recursos Adicionales

- 📄 [Prácticas de la semana](../2-practicas/README.md)
- 🔨 [Proyecto TestableApp](../3-proyecto/README.md)
- 📚 [Recursos externos](../4-recursos/README.md)
- 📖 [Glosario técnico](../5-glosario/README.md)

---

## ⚡ Tips de Estudio

1. **Lee primero la teoría** antes de los ejercicios
2. **Practica Clean Architecture** en proyectos pequeños
3. **Escribe tests** para código existente
4. **Usa TDD** para features nuevas
5. **Revisa el coverage** regularmente

---

> **Tiempo total de teoría:** 4.5 horas
