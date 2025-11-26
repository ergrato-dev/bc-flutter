# 🎨 Assets - Semana 9: Arquitectura y Testing

## 📁 Contenido

Esta carpeta contiene recursos visuales y diagramas para la Semana 9 del bootcamp.

## 📊 Diagramas Disponibles

| Archivo                       | Descripción                    | Uso                  |
| ----------------------------- | ------------------------------ | -------------------- |
| `01-clean-architecture.svg`   | Diagrama de Clean Architecture | Capas y dependencias |
| `02-flujo-datos.svg`          | Flujo de datos entre capas     | Data flow            |
| `03-testing-pyramid.svg`      | Pirámide de testing            | Tipos de tests       |
| `04-unit-test-flow.svg`       | Flujo de test unitario         | Estructura AAA       |
| `05-widget-test-flow.svg`     | Flujo de widget testing        | Pump y find          |
| `06-dependency-injection.svg` | Inyección de dependencias      | DI patterns          |

## 🎯 Cómo Usar

### En Markdown

```markdown
![Clean Architecture](./0-assets/01-clean-architecture.svg)
```

### En Flutter (para documentación)

```dart
/// Ver diagrama: semana-09/0-assets/01-clean-architecture.svg
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
