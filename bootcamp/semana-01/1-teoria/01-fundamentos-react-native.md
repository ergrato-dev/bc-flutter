# 01. Fundamentos de Dart

**Duración:** 2 horas  
**Modalidad:** Teoría + Ejemplos prácticos  
**Objetivo:** Comprender qué es Dart y dominar sus conceptos fundamentales

---

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Explicar qué es Dart y por qué se usa con Flutter
- ✅ Identificar las características principales del lenguaje
- ✅ Usar DartPad para escribir y probar código
- ✅ Comprender la sintaxis básica de Dart

---

## 🎯 ¿Qué es Dart?

**Dart** es un lenguaje de programación de código abierto creado por Google, optimizado para crear aplicaciones en **múltiples plataformas** (móvil, web, desktop, servidor).

### Concepto Clave: "Optimized for UI"

```
      Código Dart
         ↓
   Dart Compiler
         ↓
    ┌────┴────┐
    ↓         ↓
  Native   JavaScript
   Code      Code
    ↓         ↓
  Mobile    Web
  Desktop   Server
```

**¿Por qué Dart para Flutter?**

- **Alto rendimiento:** Compila a código nativo (ARM, x64)
- **Hot Reload:** Cambios instantáneos durante desarrollo
- **Productivo:** Sintaxis clara y expresiva
- **Type-safe:** Sistema de tipos sólido con null safety
- **Orientado a objetos:** Todo es un objeto en Dart

---

## 🆚 Dart vs Otros Lenguajes

### Comparativa Rápida

| Aspecto               | Dart                 | JavaScript         | Kotlin              | Swift               |
| --------------------- | -------------------- | ------------------ | ------------------- | ------------------- |
| **Tipado**            | Fuerte + Inferencia  | Débil (dinámico)   | Fuerte + Inferencia | Fuerte + Inferencia |
| **Null Safety**       | ✅ Sí (desde 2.12)   | ⚠️ Parcial         | ✅ Sí               | ✅ Sí               |
| **Compilación**       | AOT y JIT            | JIT (interpretado) | JVM / Native        | Native              |
| **Curva aprendizaje** | ⭐⭐⭐ Moderada      | ⭐⭐ Fácil         | ⭐⭐⭐⭐ Alta       | ⭐⭐⭐⭐ Alta       |
| **Hot Reload**        | ✅ Excelente         | ✅ Con frameworks  | ⚠️ Limitado         | ⚠️ Limitado         |
| **Plataformas**       | ⭐⭐⭐⭐⭐ Todas     | ⭐⭐⭐⭐⭐ Todas   | ⭐⭐⭐ Android+JVM  | ⭐⭐ Solo Apple     |
| **Ecosistema**        | Flutter, server, web | Universal          | Android, backend    | iOS, macOS          |

### ¿Por qué aprender Dart?

✅ **Ventajas clave:**

- **Fácil de aprender:** Sintaxis familiar si conoces Java, C#, JavaScript
- **Moderno:** Incluye características actuales (async/await, streams, null safety)
- **Flutter:** El framework móvil multiplataforma más popular
- **Versátil:** Sirve para móvil, web, desktop y backend
- **Comunidad creciente:** Gran soporte y recursos

⚠️ **Consideraciones:**

- Principalmente usado con Flutter (menos adopción fuera de Flutter)
- Ecosistema más pequeño que JavaScript o Python
- Menos librerías de terceros comparado con lenguajes más antiguos

---

## 🏗️ Características Principales de Dart

### 1. **Sintaxis Limpia y Expresiva**

```dart
/**
 * What?
 * Función que saluda a una persona
 *
 * For?
 * Demostrar la sintaxis básica de Dart
 *
 * Impact?
 * Código legible y fácil de mantener
 */
String greet(String name) {
  return 'Hello, $name!';
}

// Versión más concisa con arrow function
String greetShort(String name) => 'Hello, $name!';

void main() {
  print(greet('Flutter Developer'));
  // Output: Hello, Flutter Developer!
}
```

### 2. **Null Safety (Seguridad de Nulos)**

```dart
/**
 * What?
 * Sistema de null safety para prevenir errores de nulos
 *
 * For?
 * Evitar los temidos "Null Pointer Exceptions"
 *
 * Impact?
 * Código más seguro y menos bugs en producción
 */

// Variable nullable (puede ser null)
String? name;  // El '?' indica que puede ser null

// Variable non-nullable (NO puede ser null)
String definiteName = 'Flutter';  // Debe tener un valor

// Operador null-aware
String displayName = name ?? 'Guest';  // Si name es null, usa 'Guest'

// Null-aware access
print(name?.length);  // Solo accede a length si name NO es null
```

### 3. **Tipado Fuerte con Inferencia**

```dart
/**
 * What?
 * Dart infiere el tipo de variable automáticamente
 *
 * For?
 * Escribir menos código manteniendo seguridad de tipos
 *
 * Impact?
 * Código más limpio sin sacrificar type safety
 */

// Declaración explícita
int age = 25;
String name = 'Ana';
bool isStudent = true;

// Inferencia de tipo (Dart deduce el tipo)
var age2 = 25;        // Dart sabe que es int
var name2 = 'Ana';    // Dart sabe que es String
var isStudent2 = true; // Dart sabe que es bool

// Una vez definido, el tipo no cambia
var number = 10;
// number = 'text';  // ❌ ERROR: no puede cambiar de int a String
```

### 4. **Funciones como First-Class Citizens**

```dart
/**
 * What?
 * Las funciones son objetos y pueden asignarse a variables
 *
 * For?
 * Programación funcional y callbacks
 *
 * Impact?
 * Mayor flexibilidad en el diseño del código
 */

// Función normal
int add(int a, int b) {
  return a + b;
}

// Arrow function (expresión lambda)
int multiply(int a, int b) => a * b;

// Función como parámetro (callback)
void executeOperation(int a, int b, int Function(int, int) operation) {
  print('Result: ${operation(a, b)}');
}

void main() {
  executeOperation(5, 3, add);      // Result: 8
  executeOperation(5, 3, multiply); // Result: 15
}
```

### 5. **Asincronía Nativa (async/await)**

```dart
/**
 * What?
 * Manejo de operaciones asíncronas de forma sencilla
 *
 * For?
 * Trabajar con APIs, bases de datos, I/O sin bloquear la UI
 *
 * Impact?
 * Código asíncrono que se lee como código síncrono
 */

// Función asíncrona que simula una petición API
Future<String> fetchUserData() async {
  // Simula un delay de red
  await Future.delayed(Duration(seconds: 2));
  return 'User data loaded';
}

void main() async {
  print('Loading...');
  String data = await fetchUserData();
  print(data);  // Se ejecuta después de 2 segundos
}
```

---

## 🌟 Herramientas para Dart

### 1. **DartPad - Editor Online**

**What?**  
Editor web para escribir y ejecutar código Dart sin instalación.

**For?**  
Practicar rápidamente y compartir código.

**Impact?**  
Aprendizaje inmediato sin setup.

🔗 **Link:** [dartpad.dev](https://dartpad.dev/)

```dart
// Prueba este código en DartPad:
void main() {
  print('Hello, Dart!');

  var numbers = [1, 2, 3, 4, 5];
  var doubled = numbers.map((n) => n * 2).toList();
  print(doubled);  // [2, 4, 6, 8, 10]
}
```

### 2. **Dart SDK**

Incluye:

- **dart** - Ejecutar programas Dart
- **dart pub** - Gestor de paquetes
- **dart format** - Formateador de código
- **dart analyze** - Analizador estático
- **dart compile** - Compilador AOT/JIT

### 3. **IDEs Recomendados**

| IDE                | Ventajas                        | Mejor para             |
| ------------------ | ------------------------------- | ---------------------- |
| **VS Code**        | Ligero, rápido, extensiones     | Desarrollo rápido      |
| **Android Studio** | Completo, emuladores integrados | Proyectos grandes      |
| **IntelliJ IDEA**  | Poderoso, refactoring avanzado  | Desarrollo profesional |

---

## 🎯 Tu Primer Programa en Dart

### Ejemplo Completo

```dart
/**
 * What?
 * Programa que calcula el área de un rectángulo
 *
 * For?
 * Demostrar sintaxis básica de Dart
 *
 * Impact?
 * Base para entender funciones, variables y entrada/salida
 */

// Función que calcula área
double calculateArea(double width, double height) {
  return width * height;
}

// Función main - punto de entrada del programa
void main() {
  // Variables
  var width = 5.0;
  var height = 10.0;

  // Cálculo
  double area = calculateArea(width, height);

  // Output
  print('Rectangle dimensions: ${width}x${height}');
  print('Area: $area square units');
}

// Output:
// Rectangle dimensions: 5.0x10.0
// Area: 50.0 square units
```

### Ejecutar el Programa

**Opción 1: DartPad**

1. Ve a [dartpad.dev](https://dartpad.dev/)
2. Copia el código
3. Click en "Run"

**Opción 2: Terminal (si tienes Dart instalado)**

```bash
# Crear archivo
echo 'void main() { print("Hello Dart!"); }' > hello.dart

# Ejecutar
dart hello.dart
```

---

## 🔥 Características Modernas de Dart

### 1. **Collection Literals**

```dart
// Listas
var numbers = [1, 2, 3, 4, 5];
var fruits = <String>['apple', 'banana', 'orange'];

// Sets (sin duplicados)
var uniqueNumbers = {1, 2, 3, 3, 3};  // {1, 2, 3}

// Maps (diccionarios)
var user = {
  'name': 'Ana',
  'age': 25,
  'isStudent': true,
};
```

### 2. **Spread Operator**

```dart
var list1 = [1, 2, 3];
var list2 = [4, 5, 6];
var combined = [...list1, ...list2];  // [1, 2, 3, 4, 5, 6]
```

### 3. **Collection If**

```dart
var includeZero = true;
var numbers = [
  if (includeZero) 0,
  1,
  2,
  3,
];  // [0, 1, 2, 3] si includeZero es true
```

### 4. **Cascade Notation**

```dart
// Llamar múltiples métodos en el mismo objeto
var paint = Paint()
  ..color = Colors.blue
  ..strokeWidth = 5.0
  ..style = PaintingStyle.stroke;
```

---

## ⚠️ Errores Comunes de Principiantes

### 1. **Olvidar el punto y coma**

```dart
// ❌ Error
var name = 'Dart'

// ✅ Correcto
var name = 'Dart';
```

### 2. **Confundir `var`, `final` y `const`**

```dart
// var - puede cambiar
var age = 25;
age = 26;  // ✅ OK

// final - asignación única, valor en runtime
final currentTime = DateTime.now();
// currentTime = DateTime.now();  // ❌ ERROR

// const - valor conocido en compile-time
const pi = 3.14159;
// const now = DateTime.now();  // ❌ ERROR: no es compile-time constant
```

### 3. **No manejar null safety**

```dart
// ❌ Error
String? name;
print(name.length);  // Error: name puede ser null

// ✅ Correcto
String? name;
print(name?.length ?? 0);  // Maneja el caso null
```

---

## 📊 Dart en el Ecosistema de Desarrollo

### Usos de Dart

```
Dart Language
    ├── Flutter (móvil, web, desktop)
    ├── AngularDart (web frameworks)
    ├── Server-side (Aqueduct, Shelf)
    └── Command-line tools
```

### Popularidad y Adopción

| Métrica              | Dato                             |
| -------------------- | -------------------------------- |
| **GitHub Stars**     | 10k+ proyectos Dart              |
| **Pub.dev Packages** | 40,000+ paquetes                 |
| **StackOverflow**    | 50,000+ preguntas                |
| **Google Trends**    | Crecimiento constante desde 2018 |
| **Empresas usando**  | Google, Alibaba, BMW, eBay       |

---

## ✅ Checklist de Comprensión

Al finalizar este módulo deberías poder:

- [ ] Explicar qué es Dart y para qué se usa
- [ ] Identificar las ventajas de Dart vs otros lenguajes
- [ ] Usar DartPad para escribir código
- [ ] Entender null safety y por qué es importante
- [ ] Escribir funciones básicas en Dart
- [ ] Comprender la diferencia entre `var`, `final` y `const`

---

## 🔗 Recursos para Profundizar

### Documentación Oficial

- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Dart Documentation](https://dart.dev/guides)
- [DartPad](https://dartpad.dev/)

### Videos Recomendados (1 hora total)

- [Dart en 100 segundos](https://www.youtube.com/watch?v=NrO0CJCbYLA) - Fireship (2min)
- [Dart Tutorial for Beginners](https://www.youtube.com/watch?v=Ej_Pcr4uC2Q) - freeCodeCamp (3h - ver primeros 30min)

### Artículos

- [Why Flutter Uses Dart](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf)
- [Dart Null Safety Guide](https://dart.dev/null-safety)

---

## 🎓 Próximo Módulo

**Siguiente:**  
[02. Variables, Tipos de Datos y Operadores](./02-setup-y-componentes-basicos.md)

---

**Tiempo de estudio:** 2 horas ✓  
**Tiempo autónomo recomendado:** ~1 hora (práctica en DartPad)
