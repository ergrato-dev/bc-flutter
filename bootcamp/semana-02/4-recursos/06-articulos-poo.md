# 🔗 06 - Artículos sobre POO en Dart

> **Categoría**: Webgrafía / Blog Posts  
> **Nivel**: 🟢 Básico - 🟡 Intermedio  
> **Tiempo de Lectura**: 5-20 min por artículo  
> **Idiomas**: 🇪🇸 Español | 🇺🇸 English

---

## 🎯 Objetivo de Aprendizaje

Profundizar en POO mediante artículos especializados que cubren herencia, mixins, interfaces, patrones de diseño y mejores prácticas en Dart.

---

## 📰 Artículos Esenciales

### 🏆 Artículos Oficiales (dart.dev)

#### 1. **"Object-Oriented Programming in Dart"**
**Fuente**: dart.dev (Official)  
**Nivel**: 🟢 Básico  
**Tiempo**: 15 min

**URL**: [https://dart.dev/guides/language/language-tour#classes](https://dart.dev/guides/language/language-tour#classes)

**Contenido**:
- Definición de clases
- Constructores (default, named, factory, redirecting)
- Getters y setters
- Herencia con extends
- Clases abstractas
- Interfaces implícitas

**Por qué leerlo**: Documentación oficial completa. Referencia definitiva para POO en Dart.

---

#### 2. **"Understanding Mixins in Dart"**
**Fuente**: Medium - Dart Team  
**Nivel**: 🟡 Intermedio  
**Tiempo**: 12 min

**URL**: [https://medium.com/dartlang/dart-mixins-beyond-the-basics-8a3c0c0b4e56](https://medium.com/dartlang/dart-mixins-beyond-the-basics-8a3c0c0b4e56)

**Contenido**:
- ¿Qué son los mixins?
- Diferencia entre herencia y mixins
- Orden de aplicación de mixins
- Restricciones con `on`
- Casos de uso reales

**Ejemplo Clave**:
```dart
mixin Musical {
  void playMusic() => print('♪♫');
}

mixin Dancing {
  void dance() => print('💃');
}

class Performer extends Person with Musical, Dancing {
  // Combina múltiples habilidades
}
```

**Por qué leerlo**: Artículo oficial del equipo Dart. Explica mixins en profundidad con casos reales.

---

### 🌟 Artículos de Comunidad (Calidad Alta)

#### 3. **"Dart's Type System: Generics and Beyond"**
**Autor**: Bob Nystrom (Google)  
**Fuente**: Medium  
**Nivel**: 🟡 Intermedio  
**Tiempo**: 18 min

**URL**: [https://medium.com/@munificentbob/darts-type-system-generics-and-beyond-d45e5e3c6f88](https://medium.com/@munificentbob/darts-type-system-generics-and-beyond-d45e5e3c6f88)

**Contenido**:
- Generics en clases
- Type bounds
- Covariance y contravariance
- Prácticas recomendadas

**Por qué leerlo**: Bob Nystrom trabajó en el diseño del lenguaje Dart. Perspectiva de primera mano.

---

#### 4. **"Effective Dart: Design"**
**Fuente**: dart.dev (Official)  
**Nivel**: 🟡 Intermedio  
**Tiempo**: 25 min

**URL**: [https://dart.dev/guides/language/effective-dart/design](https://dart.dev/guides/language/effective-dart/design)

**Secciones Clave**:
- Naming conventions
- Cuándo usar clases vs funciones
- Public vs private members
- Prefer composition over inheritance
- Avoid returning null

**Ejemplos de Mejores Prácticas**:
```dart
// ✅ BUENO: Nombre descriptivo
class UserRepository {}

// ❌ MALO: Nombre genérico
class Manager {}

// ✅ BUENO: Composition
class Car {
  final Engine engine;
  Car(this.engine);
}

// ❌ MALO: Herencia innecesaria
class Car extends Engine {}
```

**Por qué leerlo**: Guía oficial de mejores prácticas. Esencial para código profesional.

---

#### 5. **"Dart Design Patterns: Factory Pattern"**
**Autor**: Mangirdas Kazlauskas  
**Fuente**: Medium  
**Nivel**: 🟡 Intermedio  
**Tiempo**: 10 min

**URL**: [https://medium.com/flutter-community/dart-design-patterns-factory-pattern-c2f6f60c2f88](https://medium.com/flutter-community/dart-design-patterns-factory-pattern-c2f6f60c2f88)

**Contenido**:
- Factory constructors
- Abstract factories
- Casos de uso en Flutter
- Ejemplo: Parseo de JSON

**Implementación Práctica**:
```dart
class Shape {
  factory Shape.fromType(String type) {
    switch (type) {
      case 'circle':
        return Circle();
      case 'square':
        return Square();
      default:
        throw Exception('Unknown shape');
    }
  }
}
```

**Por qué leerlo**: Patrón muy común en Flutter para crear objetos desde JSON.

---

#### 6. **"Understanding Super Constructor Calls in Dart"**
**Autor**: Remi Rousselet  
**Fuente**: Medium  
**Nivel**: 🟢 Básico  
**Tiempo**: 8 min

**URL**: [https://medium.com/flutter-community/understanding-super-constructor-calls-in-dart-5e7f8f7c6a7c](https://medium.com/flutter-community/understanding-super-constructor-calls-in-dart-5e7f8f7c6a7c)

**Contenido**:
- Llamadas al constructor padre
- Constructor initialization lists
- Orden de inicialización
- Errores comunes

**Ejemplo**:
```dart
class Animal {
  final String name;
  Animal(this.name);
}

class Dog extends Animal {
  final String breed;
  
  // Constructor con super call
  Dog(String name, this.breed) : super(name);
}
```

**Por qué leerlo**: Remi es mantenedor de Provider. Explica conceptos complejos de forma simple.

---

### 📚 Series de Artículos

#### 7. **"Dart OOP Series" - FlutterCommunity**
**Fuente**: Medium - Flutter Community  
**Nivel**: 🟢 Básico - 🟡 Intermedio  
**Total**: 5 artículos (~1 hora)

**Artículos de la Serie**:
1. **Classes and Objects** (12 min)
2. **Inheritance and Polymorphism** (15 min)
3. **Abstract Classes and Interfaces** (10 min)
4. **Mixins in Depth** (14 min)
5. **Design Patterns in Dart** (18 min)

**URL**: [https://medium.com/flutter-community/tagged/dart-oop](https://medium.com/flutter-community/tagged/dart-oop)

**Por qué leerla**: Serie completa progresiva. Cada artículo construye sobre el anterior.

---

### 🇪🇸 Artículos en Español

#### 8. **"POO en Dart: Guía Completa"**
**Autor**: DevExperto (Antonio Leiva)  
**Fuente**: devexperto.com  
**Nivel**: 🟢 Básico  
**Tiempo**: 20 min

**URL**: [https://devexperto.com/programacion-orientada-objetos-dart/](https://devexperto.com/programacion-orientada-objetos-dart/)

**Contenido**:
- Clases y objetos en Dart
- Herencia y polimorfismo
- Encapsulamiento
- Ejemplos prácticos en español

**Por qué leerlo**: Uno de los pocos recursos de calidad en español sobre POO en Dart.

---

#### 9. **"Mixins en Dart Explicados con Ejemplos"**
**Autor**: Flutter Español (Blog)  
**Fuente**: flutter-es.io  
**Nivel**: 🟢 Básico  
**Tiempo**: 12 min

**URL**: [https://flutter-es.io/articulos/mixins-dart](https://flutter-es.io/articulos/mixins-dart)

**Contenido**:
- ¿Qué son los mixins?
- Diferencias con herencia
- Ejemplos paso a paso
- Ejercicios prácticos

**Por qué leerlo**: Explicación clara en español con código ejecutable.

---

## 🎯 Artículos por Tema

### Herencia y Polimorfismo

- **"Inheritance in Dart"** - dart.dev ([link](https://dart.dev/guides/language/language-tour#extending-a-class))
- **"Polymorphism in Dart Explained"** - Medium ([búsqueda](https://medium.com/search?q=dart%20polymorphism))

### Mixins

- **"Mixins Beyond Basics"** - dart.dev (ver #2 arriba)
- **"When to Use Mixins vs Inheritance"** - Stack Overflow ([link](https://stackoverflow.com/questions/54517968/when-to-use-mixins-and-when-to-use-interfaces-in-dart))

### Abstract Classes e Interfaces

- **"Abstract Classes in Dart"** - GeeksForGeeks ([link](https://www.geeksforgeeks.org/abstract-classes-in-dart/))
- **"Implementing Interfaces"** - dart.dev Language Tour

### Constructores

- **"Dart Constructors Deep Dive"** - Medium Flutter Community
- **"Factory Constructors Explained"** - (ver #5 arriba)

---

## 📅 Plan de Lectura Semanal

### Semana 02 - Enfoque POO

**Día 1: Fundamentos (45 min)**
- ✅ Artículo #1: OOP in Dart (Official)
- ✅ Artículo #6: Super Constructor Calls
- ✍️ Práctica 01: Sistema Biblioteca

**Día 2: Herencia y Mixins (1 hora)**
- ✅ Artículo #2: Understanding Mixins
- ✅ Artículo #7: OOP Series (Parte 2 y 4)
- ✍️ Práctica 03: Sistema Habilidades

**Día 3: Mejores Prácticas (45 min)**
- ✅ Artículo #4: Effective Dart Design
- ✅ Artículo #5: Factory Pattern
- 🔨 Aplicar en Proyecto Agenda

**Día 4-7: Lectura Opcional Profundización**
- ✅ Artículo #3: Type System and Generics
- ✅ Serie completa #7 (si no la completaste)
- 🔨 Refinar código del proyecto

---

## 💡 Estrategias de Lectura

### Antes de Leer

1. **Define Objetivo**:
   ```
   ❌ "Voy a leer sobre POO"
   ✅ "Voy a leer sobre mixins para entender cuándo usarlos vs herencia"
   ```

2. **Prepara Entorno**:
   - DartPad abierto
   - Notebook para notas
   - Timer (técnica Pomodoro: 25 min lectura, 5 min break)

### Durante la Lectura

1. **Lectura Activa SQ3R**:
   - **S**urvey: Escanea títulos y subtítulos
   - **Q**uestion: Genera preguntas antes de leer
   - **R**ead: Lee activamente
   - **R**ecite: Resume sin mirar
   - **R**eview: Repasa puntos clave

2. **Ejecuta Todos los Ejemplos**:
   ```dart
   // Copia el código del artículo
   // Ejecútalo en DartPad
   // Modifícalo para experimentar
   // Rompe el código intencionalmente para ver errores
   ```

3. **Toma Notas Cornell**:
   ```markdown
   ## Mixins (Artículo #2)
   
   ### Notas
   - Mixin = clase sin constructor
   - Se aplica con `with`
   - Múltiples mixins: orden importa
   
   ### Preguntas
   - ¿Puedo usar super en un mixin?
   - ¿Qué pasa si dos mixins tienen mismo método?
   
   ### Resumen
   Mixins permiten composición de comportamiento sin herencia.
   ```

### Después de Leer

1. **Práctica Inmediata**:
   - Implementa concepto en código propio
   - NO copies/pegues, escribe desde cero
   - Crea variaciones

2. **Enseña lo Aprendido**:
   - Explica a un compañero
   - Escribe un post de blog
   - Crea un gist de GitHub con ejemplo

3. **Conecta con Proyecto**:
   - Identifica dónde aplicar en Agenda Personal
   - Refactoriza código existente
   - Documenta decisiones

---

## 📊 Matriz de Artículos

| # | Artículo | Tema | Nivel | Tiempo | Prioridad |
|---|----------|------|-------|--------|-----------|
| 1 | OOP in Dart (Official) | Fundamentos | 🟢 | 15 min | 🔴 Alta |
| 2 | Understanding Mixins | Mixins | 🟡 | 12 min | 🔴 Alta |
| 3 | Type System | Generics | 🟡 | 18 min | 🟡 Media |
| 4 | Effective Dart Design | Best Practices | 🟡 | 25 min | 🔴 Alta |
| 5 | Factory Pattern | Patterns | 🟡 | 10 min | 🟡 Media |
| 6 | Super Constructor | Constructors | 🟢 | 8 min | 🔴 Alta |
| 7 | OOP Series | Todos | 🟢-🟡 | 60 min | 🟡 Media |
| 8 | POO Guía (ES) | Fundamentos | 🟢 | 20 min | 🟢 Opcional |
| 9 | Mixins (ES) | Mixins | 🟢 | 12 min | 🟢 Opcional |

---

## 🔗 Recursos Complementarios

### Videos Relacionados
- Ver: [`01-videos-poo.md`](01-videos-poo.md) - Videos POO
- Ver: [`02-videos-colecciones.md`](02-videos-colecciones.md)

### Libros
- Ver: [`04-ebooks-dart-avanzado.md`](04-ebooks-dart-avanzado.md)

### Documentación
- Ver: [`08-documentacion-oficial.md`](08-documentacion-oficial.md#dart-language)

### Cross-References
- **Teoría**: [`1-teoria/01-poo-dart.md`](../1-teoria/01-poo-dart.md)
- **Prácticas**: [`2-practicas/practica-01-poo-biblioteca.md`](../2-practicas/practica-01-poo-biblioteca.md)
- **Glosario**: [class](../5-glosario/README.md#class), [mixin](../5-glosario/README.md#mixin), [extends](../5-glosario/README.md#extends)

---

## 📚 Cómo Buscar Más Artículos

### Búsquedas Efectivas en Google

```
"dart mixins" site:medium.com
"dart oop" site:dev.to
"dart inheritance" site:stackoverflow.com
"effective dart" site:dart.dev
"dart design patterns" filetype:pdf
```

### Comunidades con Buenos Artículos

- **Medium**: Tag #dartlang, #flutter
- **Dev.to**: Tag #dart
- **Hashnode**: Tag #dart
- **Reddit**: r/dartlang, r/FlutterDev

---

## 📊 Checklist de Aprendizaje

**Después de leer estos artículos, deberías poder**:

- [ ] Explicar POO en Dart con ejemplos
- [ ] Crear clases con diferentes tipos de constructores
- [ ] Implementar herencia y polimorfismo
- [ ] Usar mixins efectivamente
- [ ] Decidir cuándo usar mixins vs herencia
- [ ] Crear interfaces implícitas
- [ ] Aplicar factory pattern
- [ ] Seguir Effective Dart guidelines
- [ ] Usar genéricos en tus clases
- [ ] Escribir código orientado a objetos limpio

---

## 🎯 Siguiente Paso

Después de leer los artículos:
- 🔗 [07 - Artículos Flutter](07-articulos-flutter.md)
- 📖 [04 - eBooks Dart](04-ebooks-dart-avanzado.md) para profundizar
- ✍️ Aplicar conceptos en prácticas 01-03

---

**Actualizado**: Noviembre 2025 | **Nivel**: Semana 02 | **Tipo**: Recurso Webgráfico
