# 02. Variables, Tipos de Datos y Operadores

**Duración:** 2 horas  
**Modalidad:** Teoría + Ejercicios prácticos  
**Objetivo:** Dominar variables, tipos de datos y operadores en Dart

---

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Declarar variables con `var`, `final` y `const`
- ✅ Trabajar con todos los tipos de datos primitivos
- ✅ Aplicar operadores aritméticos, lógicos y de comparación
- ✅ Usar operadores null-aware para código seguro
- ✅ Convertir entre diferentes tipos de datos

---

## PARTE 1: Variables en Dart (30 minutos)

### 📋 Declaración de Variables

Dart ofrece tres formas de declarar variables:

**1. `var` - Variable mutable con inferencia de tipo**

```dart
/**
 * What?
 * Declaración de variable con tipo inferido
 *
 * For?
 * Cuando el tipo es obvio por el valor asignado
 *
 * Impact?
 * Código más conciso sin perder type safety
 */

var name = 'Flutter';  // Dart infiere que es String
var age = 25;          // Dart infiere que es int
var isStudent = true;  // Dart infiere que es bool

// El tipo se fija en la primera asignación
name = 'Dart';        // ✅ OK - sigue siendo String
// age = 'twenty';    // ❌ ERROR - no puede cambiar a String
```

**2. `final` - Variable inmutable (asignación única)**

```dart
/**
 * What?
 * Variable que solo puede asignarse una vez
 *
 * For?
 * Cuando el valor se conoce en runtime pero no debe cambiar
 *
 * Impact?
 * Previene modificaciones accidentales
 */

final currentTime = DateTime.now();  // Se evalúa en runtime
final userName = 'Ana';

// userName = 'Carlos';  // ❌ ERROR - no puede reasignarse

// Útil para valores que vienen de APIs, inputs, etc.
final userInput = getUserInput();  // Se ejecuta al inicializar
```

**3. `const` - Constante en tiempo de compilación**

```dart
/**
 * What?
 * Constante conocida en tiempo de compilación
 *
 * For?
 * Valores que nunca cambian y son conocidos antes de ejecutar
 *
 * Impact?
 * Mejor performance - se optimiza en compilación
 */

const pi = 3.14159;
const appName = 'My Flutter App';
const maxUsers = 100;

// const now = DateTime.now();  // ❌ ERROR - no es compile-time constant

// Listas y Maps constantes
const colors = ['red', 'green', 'blue'];
const config = {'version': '1.0', 'debug': false};
```

### 📊 Comparativa: var, final, const

| Característica    | `var`                | `final`        | `const`    |
| ----------------- | -------------------- | -------------- | ---------- |
| **Reasignable**   | ✅ Sí                | ❌ No          | ❌ No      |
| **Tipo inferido** | ✅ Sí                | ✅ Sí          | ✅ Sí      |
| **Runtime value** | ✅ Sí                | ✅ Sí          | ❌ No      |
| **Compile-time**  | ❌ No                | ❌ No          | ✅ Sí      |
| **Uso típico**    | Variables cambiantes | Valores únicos | Constantes |

### 💡 Mejores Prácticas

```dart
// ✅ BUENAS PRÁCTICAS

// Usa const para valores conocidos
const String apiUrl = 'https://api.example.com';
const int maxRetries = 3;

// Usa final para valores que se asignan una vez
final String userId = fetchUserId();
final DateTime sessionStart = DateTime.now();

// Usa var solo cuando el valor cambia
var counter = 0;
counter++;  // Necesita cambiar

// ❌ MALAS PRÁCTICAS

var pi = 3.14;  // Debería ser const
final x = 1; final y = x + 1;  // Ambas podrían ser const
```

---

## PARTE 2: Tipos de Datos Primitivos (40 minutos)

### 1️⃣ **Números (int, double, num)**

```dart
/**
 * What?
 * Tipos numéricos en Dart
 *
 * For?
 * Representar valores enteros y decimales
 *
 * Impact?
 * Base para cálculos matemáticos
 */

// int - Números enteros
int age = 25;
int quantity = -10;
int hex = 0xFF;  // Hexadecimal

// double - Números con decimales
double height = 1.75;
double price = 99.99;
double scientific = 1.42e5;  // 142000.0

// num - Puede ser int o double
num temperature = 36.5;  // double
temperature = 37;        // ahora int

// Operaciones
int sum = 10 + 5;         // 15
double division = 10 / 3;  // 3.3333...
int intDivision = 10 ~/ 3; // 3 (división entera)
int remainder = 10 % 3;    // 1 (módulo)

// Métodos útiles
print(age.toString());           // '25'
print(height.toStringAsFixed(1)); // '1.8'
print(price.round());            // 100
print(price.floor());            // 99
print(price.ceil());             // 100
```

### 2️⃣ **Strings (Cadenas de texto)**

```dart
/**
 * What?
 * Cadenas de texto en Dart
 *
 * For?
 * Manipular y mostrar texto
 *
 * Impact?
 * Fundamental para UI y procesamiento de datos
 */

// Declaración básica
String name = 'Flutter';
String greeting = "Hello";

// Strings multilínea
String multiline = '''
  Esta es una
  cadena de
  múltiples líneas
''';

// String interpolation (interpolación)
var firstName = 'Ana';
var lastName = 'García';
var fullName = '$firstName $lastName';  // 'Ana García'
var message = 'Hola, ${fullName.toUpperCase()}!';  // 'Hola, ANA GARCÍA!'

// Concatenación
var hello = 'Hello' + ' ' + 'World';  // 'Hello World'
var repeated = 'Ha' * 3;              // 'HaHaHa'

// Métodos útiles
print(name.length);              // 7
print(name.toUpperCase());       // 'FLUTTER'
print(name.toLowerCase());       // 'flutter'
print(name.contains('Flu'));     // true
print(name.startsWith('F'));     // true
print(name.substring(0, 3));     // 'Flu'
print(name.split('t'));          // ['Flu', '', 'er']
print('  text  '.trim());        // 'text'

// Raw strings (ignora escape sequences)
var path = r'C:\Users\Documents\file.txt';  // No interpreta \

// Escape sequences
var quote = 'She said, "Hello"';
var newLine = 'Line 1\nLine 2';
var tab = 'Name:\tJohn';
```

### 3️⃣ **Booleanos (bool)**

```dart
/**
 * What?
 * Tipo de dato lógico (verdadero/falso)
 *
 * For?
 * Tomar decisiones y controlar flujo
 *
 * Impact?
 * Base de toda lógica condicional
 */

bool isActive = true;
bool isCompleted = false;

// En expresiones
bool isAdult = age >= 18;
bool hasAccess = isActive && !isCompleted;

// Dart NO hace coerción implícita
var value = 0;
// if (value) { }  // ❌ ERROR - value no es bool

// Correcto:
if (value != 0) {  // ✅ OK
  print('Value is not zero');
}
```

### 4️⃣ **Tipos Especiales: dynamic y Object**

```dart
/**
 * What?
 * Tipos que aceptan cualquier valor
 *
 * For?
 * Cuando el tipo no se conoce en tiempo de compilación
 *
 * Impact?
 * Flexibilidad pero pérdida de type safety
 */

// dynamic - tipo completamente dinámico
dynamic variable = 'text';
variable = 123;        // ✅ OK
variable = true;       // ✅ OK
variable.anyMethod();  // ✅ Compila (falla en runtime si no existe)

// Object - tipo base de todo
Object obj = 'text';
obj = 123;            // ✅ OK
// obj.length;        // ❌ ERROR - Object no tiene length

// ⚠️ USA CON PRECAUCIÓN
// Pierde los beneficios del sistema de tipos
// Prefiere usar tipos específicos cuando sea posible
```

---

## PARTE 3: Operadores (30 minutos)

### ➕ **Operadores Aritméticos**

```dart
/**
 * What?
 * Operadores para cálculos matemáticos
 *
 * For?
 * Realizar operaciones numéricas
 *
 * Impact?
 * Base de la lógica computacional
 */

int a = 10;
int b = 3;

print(a + b);   // 13 - Suma
print(a - b);   // 7  - Resta
print(a * b);   // 30 - Multiplicación
print(a / b);   // 3.333... - División (double)
print(a ~/ b);  // 3  - División entera
print(a % b);   // 1  - Módulo (resto)

// Incremento/Decremento
var count = 0;
count++;        // count = count + 1
count--;        // count = count - 1

// Pre/Post incremento
var x = 5;
print(++x);     // 6 (incrementa primero, luego retorna)
x = 5;
print(x++);     // 5 (retorna primero, luego incrementa)

// Operadores de asignación compuestos
var num = 10;
num += 5;       // num = num + 5
num -= 3;       // num = num - 3
num *= 2;       // num = num * 2
num ~/= 4;      // num = num ~/ 4
```

### ⚖️ **Operadores de Comparación**

```dart
/**
 * What?
 * Operadores para comparar valores
 *
 * For?
 * Tomar decisiones basadas en comparaciones
 *
 * Impact?
 * Fundamental para control de flujo
 */

int x = 10;
int y = 20;

print(x == y);  // false - Igual a
print(x != y);  // true  - Diferente de
print(x > y);   // false - Mayor que
print(x < y);   // true  - Menor que
print(x >= 10); // true  - Mayor o igual
print(x <= 5);  // false - Menor o igual

// Comparación de objetos
String a = 'hello';
String b = 'hello';
print(a == b);  // true - compara contenido

// identical() - compara identidad (misma instancia)
var list1 = [1, 2, 3];
var list2 = [1, 2, 3];
print(list1 == list2);          // true - mismo contenido
print(identical(list1, list2));  // false - diferentes instancias
```

### 🔀 **Operadores Lógicos**

```dart
/**
 * What?
 * Operadores para combinar expresiones booleanas
 *
 * For?
 * Control de flujo complejo y validaciones
 *
 * Impact?
 * Decisiones basadas en múltiples condiciones
 */

bool isAdult = true;
bool hasLicense = false;

// && (AND) - ambas condiciones deben ser true
print(isAdult && hasLicense);  // false

// || (OR) - al menos una condición debe ser true
print(isAdult || hasLicense);  // true

// ! (NOT) - invierte el valor booleano
print(!isAdult);  // false

// Cortocircuito: && evalúa de izquierda a derecha y se detiene al primer false
bool result = isAdult && checkDatabase();  // Si isAdult es false, no llama checkDatabase()
```

---

## 📝 Resumen de Operadores

### Tabla de Referencia Rápida

| Categoría       | Operadores                       | Descripción                |
| --------------- | -------------------------------- | -------------------------- | ------ | ------------------------------ |
| **Aritméticos** | `+`, `-`, `*`, `/`, `~/`, `%`    | Operaciones matemáticas    |
| **Asignación**  | `=`, `+=`, `-=`, `*=`, `/=`      | Asignar valores            |
| **Comparación** | `==`, `!=`, `>`, `<`, `>=`, `<=` | Comparar valores           |
| **Lógicos**     | `&&`, `                          |                            | `, `!` | Combinar condiciones booleanas |
| **Null-aware**  | `??`, `??=`, `?.`, `!`           | Trabajar con valores nulos |
| **Tipo**        | `is`, `is!`, `as`                | Verificar y castear tipos  |

### Ejemplo Integrador

```dart
/**
 * Ejemplo que integra variables, tipos y operadores
 * Simulación de validación de usuario
 */

void main() {
  // Variables con diferentes tipos
  final String username = 'Juan';
  int age = 17;
  double balance = 1500.50;
  bool isPremium = false;
  String? email;  // Puede ser null

  // Operadores aritméticos
  double discount = isPremium ? balance * 0.1 : balance * 0.05;
  double finalBalance = balance - discount;

  // Operadores de comparación
  bool isAdult = age >= 18;
  bool hasEnoughBalance = balance > 1000;

  // Operadores lógicos
  bool canPurchase = isAdult && hasEnoughBalance;

  // Operadores null-aware
  String contactEmail = email ?? 'no-email@example.com';

  // Operadores de tipo
  if (age is int && age > 0) {
    print('✓ Edad válida: $age años');
  }

  // Resultado
  print('Usuario: $username');
  print('Es adulto: ${isAdult ? "Sí" : "No"}');
  print('Puede comprar: ${canPurchase ? "Sí" : "No"}');
  print('Balance final: \$${finalBalance.toStringAsFixed(2)}');
  print('Email de contacto: $contactEmail');
}
```

**Salida esperada:**

```
✓ Edad válida: 17 años
Usuario: Juan
Es adulto: No
Puede comprar: No
Balance final: $1425.48
Email de contacto: no-email@example.com
```

---

## 🎯 Puntos Clave para Recordar

### Variables

✅ **`var`** → Tipo inferido, mutable
✅ **`final`** → Valor asignado una vez, inmutable en tiempo de ejecución
✅ **`const`** → Constante en tiempo de compilación

### Tipos de Datos

✅ **`int`** → Números enteros
✅ **`double`** → Números decimales
✅ **`String`** → Cadenas de texto
✅ **`bool`** → Valores booleanos (true/false)
✅ **Null safety** → Sistema que previene errores de null

### Operadores Esenciales

✅ **Aritméticos** → `+`, `-`, `*`, `/`, `~/`, `%`
✅ **Null-aware** → `??`, `??=`, `?.`, `!`
✅ **Comparación** → `==`, `!=`, `>`, `<`, `>=`, `<=`
✅ **Lógicos** → `&&`, `||`, `!`

---

## 🔗 Próximo Módulo

**Siguiente tema:**  
[03. Control de Flujo y Funciones](./03-control-flujo-funciones.md) - Aprenderemos estructuras de control (if, for, while) y cómo crear funciones reutilizables en Dart.

---

## 📚 Recursos Adicionales

### Documentación Oficial

- [Dart Language Tour - Variables](https://dart.dev/language/variables)
- [Dart Language Tour - Built-in Types](https://dart.dev/language/built-in-types)
- [Dart Language Tour - Operators](https://dart.dev/language/operators)
- [Understanding Null Safety](https://dart.dev/null-safety/understanding-null-safety)

### Ejercicios Interactivos

- [DartPad - Practica en línea](https://dartpad.dev/)
- [Dart Tutorial - Variables](https://dart-tutorial.com/introduction-and-basics/variables-in-dart/)

### Videos Recomendados

- [Dart in 100 Seconds - Fireship](https://www.youtube.com/watch?v=5rtujDjt50I)
- [Null Safety in Dart - Flutter](https://www.youtube.com/watch?v=iYhOU9AuaFs)

---

**⏱️ Tiempo de estudio:** 2 horas  
**📖 Nivel:** Fundamentos  
