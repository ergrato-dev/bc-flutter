# 🎬 Videos: Principios SOLID

## 📋 Recursos en Video

### Español

#### 1. SOLID Principles en 20 minutos - MiduDev

- **Canal**: MiduDev
- **Duración**: 25min
- **Nivel**: Principiante
- **URL**: https://www.youtube.com/watch?v=2X50sKeBAcQ
- **Descripción**: Explicación clara y concisa de cada principio.

#### 2. SOLID en Dart - Código Correcto

- **Canal**: Código Correcto
- **Duración**: 40min
- **Nivel**: Intermedio
- **URL**: https://www.youtube.com/watch?v=JEmeYZqBZvE
- **Descripción**: SOLID aplicado específicamente en Dart.

### Inglés

#### 3. SOLID Principles - Uncle Bob

- **Canal**: NDC Conferences
- **Duración**: 1h
- **Nivel**: Conceptual
- **URL**: https://www.youtube.com/watch?v=zHiWqnTWsn4
- **Descripción**: Charla original del creador de SOLID.

#### 4. SOLID in Flutter - Code With Andrea

- **Canal**: Code With Andrea
- **Duración**: 30min
- **Nivel**: Intermedio
- **URL**: https://codewithandrea.com/videos/flutter-solid-principles/
- **Descripción**: SOLID con ejemplos prácticos en Flutter.

---

## 📝 Resumen de Principios

### S - Single Responsibility

```dart
// ❌ Múltiples responsabilidades
class User {
  void saveToDatabase() {}
  void sendEmail() {}
  void generateReport() {}
}

// ✅ Una responsabilidad
class User { /* solo datos */ }
class UserRepository { /* solo persistencia */ }
class EmailService { /* solo emails */ }
```

### O - Open/Closed

```dart
// ✅ Abierto a extensión, cerrado a modificación
abstract class Shape {
  double area();
}

class Circle extends Shape {
  @override
  double area() => /* ... */;
}
```

### L - Liskov Substitution

```dart
// ✅ Subtipos intercambiables
void printArea(Shape shape) {
  print(shape.area()); // Funciona con cualquier Shape
}
```

### I - Interface Segregation

```dart
// ✅ Interfaces específicas
abstract class Readable { void read(); }
abstract class Writable { void write(); }
// No: abstract class ReadWriteDelete { ... }
```

### D - Dependency Inversion

```dart
// ✅ Depender de abstracciones
class TaskBloc {
  final TaskRepository repository; // Interface, no implementación
  TaskBloc(this.repository);
}
```

---

> **Tiempo estimado de visualización**: 1.5-2 horas
