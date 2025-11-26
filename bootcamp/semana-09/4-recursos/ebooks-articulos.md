# 📚 eBooks y Artículos: Arquitectura y Testing

## 📖 Libros Recomendados

### Clean Architecture

#### 1. Clean Architecture: A Craftsman's Guide - Robert C. Martin

- **Autor**: Robert C. Martin (Uncle Bob)
- **Año**: 2017
- **ISBN**: 978-0134494166
- **Descripción**: El libro definitivo sobre Clean Architecture.
- **Capítulos clave**:
  - Part V: Architecture (capítulos 15-21)
  - Part VI: Details (capítulos 30-34)

#### 2. Domain-Driven Design - Eric Evans

- **Autor**: Eric Evans
- **Año**: 2003
- **ISBN**: 978-0321125217
- **Descripción**: Fundamentos de DDD que complementan Clean Architecture.

#### 3. Implementing Domain-Driven Design - Vaughn Vernon

- **Autor**: Vaughn Vernon
- **Año**: 2013
- **ISBN**: 978-0321834577
- **Descripción**: Implementación práctica de DDD.

### Testing

#### 4. Test-Driven Development By Example - Kent Beck

- **Autor**: Kent Beck
- **Año**: 2002
- **ISBN**: 978-0321146533
- **Descripción**: El libro que popularizó TDD.

#### 5. Working Effectively with Legacy Code - Michael Feathers

- **Autor**: Michael Feathers
- **Año**: 2004
- **ISBN**: 978-0131177055
- **Descripción**: Cómo agregar tests a código existente.

### SOLID y Patrones

#### 6. Clean Code: A Handbook - Robert C. Martin

- **Autor**: Robert C. Martin
- **Año**: 2008
- **ISBN**: 978-0132350884
- **Descripción**: Principios de código limpio incluyendo SOLID.

---

## 📄 Artículos Online

### Clean Architecture

1. **The Clean Architecture** - Uncle Bob Blog

   - URL: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
   - ⭐ Lectura obligatoria

2. **Flutter App Architecture with Riverpod** - Code With Andrea

   - URL: https://codewithandrea.com/articles/flutter-app-architecture-riverpod/
   - Arquitectura práctica para Flutter

3. **Very Good Ventures - Architecture Layers**
   - URL: https://verygood.ventures/blog/flutter-app-architecture
   - Enfoque empresarial

### Testing

4. **An Introduction to Unit Testing** - Flutter.dev

   - URL: https://docs.flutter.dev/cookbook/testing/unit/introduction
   - Documentación oficial

5. **Widget Testing** - Flutter.dev

   - URL: https://docs.flutter.dev/cookbook/testing/widget/introduction
   - Guía oficial de widget tests

6. **Integration Testing** - Flutter.dev

   - URL: https://docs.flutter.dev/testing/integration-tests
   - Tests de integración oficiales

7. **Effective Dart: Testing**
   - URL: https://dart.dev/guides/testing
   - Buenas prácticas de testing en Dart

### SOLID

8. **SOLID Principles in Dart**

   - URL: https://medium.com/flutter-community/solid-principles-in-dart-e6c0c8d1f9aa
   - SOLID específico para Dart

9. **Dependency Injection in Flutter**
   - URL: https://blog.codemagic.io/dependency-injection-in-flutter/
   - Inyección de dependencias

---

## 📑 Cheat Sheets

### Clean Architecture Quick Reference

```
┌─────────────────────────────────────────┐
│            PRESENTATION                 │
│  Widgets, BLoC/Provider, Pages         │
├─────────────────────────────────────────┤
│              DOMAIN                     │
│  Entities, UseCases, Repositories(I)   │
├─────────────────────────────────────────┤
│               DATA                      │
│  Models, DataSources, Repositories(C)  │
└─────────────────────────────────────────┘

I = Interface (Abstracción)
C = Concrete (Implementación)
```

### Testing Quick Reference

```
Unit Tests:
- flutter test test/unit/
- Testea: funciones, clases, lógica
- Mock: dependencias externas

Widget Tests:
- flutter test test/widget/
- Testea: UI, interacciones
- Herramientas: WidgetTester, find, pump

Integration Tests:
- flutter test integration_test/
- Testea: flujos completos
- Herramientas: integration_test package
```

---

> **Tiempo de lectura estimado**: 4-6 horas para artículos esenciales
