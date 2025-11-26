# 🎨 Assets - Semana 9: Arquitectura y Testing

## 📁 Contenido

Esta carpeta contiene recursos visuales y diagramas para la Semana 9 del bootcamp.

## 📊 Diagramas Disponibles

| #   | Archivo                             | Descripción                    | Uso                 |
| --- | ----------------------------------- | ------------------------------ | ------------------- |
| 01  | `01-solid-principles.svg`           | Principios SOLID               | 5 principios clave  |
| 02  | `02-clean-architecture-diagram.svg` | Diagrama de Clean Architecture | Capas concéntricas  |
| 03  | `03-capas-clean-architecture.svg`   | Capas de Clean Architecture    | Layers horizontales |
| 04  | `04-dependency-injection.svg`       | Inyección de dependencias      | DI Container        |
| 05  | `05-testing-pyramid.svg`            | Pirámide de testing            | Tipos de tests      |
| 06  | `06-tdd-cycle.svg`                  | Ciclo TDD                      | Red-Green-Refactor  |

### 📖 Orden de Estudio Recomendado

1. **SOLID Principles** → Fundamentos de diseño orientado a objetos
2. **Clean Architecture Diagram** → Visión general de la arquitectura
3. **Capas Clean Architecture** → Detalle de cada capa y responsabilidades
4. **Dependency Injection** → Cómo implementar la inversión de dependencias
5. **Testing Pyramid** → Tipos de tests y su proporción
6. **TDD Cycle** → Ciclo de desarrollo guiado por tests

## 🎯 Cómo Usar

### En Markdown

```markdown
![SOLID Principles](./0-assets/01-solid-principles.svg)
![Clean Architecture](./0-assets/02-clean-architecture-diagram.svg)
```

### En Flutter (para documentación)

```dart
/// Ver diagrama: semana-09/0-assets/01-solid-principles.svg
/// Ver diagrama: semana-09/0-assets/02-clean-architecture-diagram.svg
```

## 🎨 Especificaciones de Diseño

- **Fondo:** `#1E1E1E` (tema oscuro)
- **Colores principales:**
  - Azul: `#64B5F6` (Presentation Layer)
  - Verde: `#81C784` (Domain Layer)
  - Naranja: `#FFB74D` (Data Layer)
  - Rosa: `#F06292` (Tests)
  - Púrpura: `#BA68C8` (Dependencies)
- **Texto:** `#E0E0E0` (claro), `#9E9E9E` (secundario)
- **Fuente:** sans-serif
- **Sin gradientes:** Solo colores sólidos

## 📱 Temas Visualizados

### Clean Architecture

- Capas y responsabilidades
- Flujo de dependencias (hacia adentro)
- Separación de concerns

### Testing

- Pirámide de testing
- Estructura AAA (Arrange, Act, Assert)
- Mocking y stubbing
- Widget testing con WidgetTester

### Patrones

- Repository pattern
- Use cases
- Dependency injection

---

> **Nota:** Todos los SVGs usan colores sólidos sin gradientes para máxima compatibilidad.
