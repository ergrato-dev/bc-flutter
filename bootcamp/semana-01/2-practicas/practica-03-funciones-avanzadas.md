# 💻 Práctica 3: Funciones Avanzadas en Dart

**⏱️ Duración:** 20 minutos presencial + 30 minutos autónomo  
**👥 Modalidad:** 🎓 **PRESENCIAL (inicio)** + 🏠 **AUTÓNOMO (completar)**  
**📊 Dificultad:** ⭐⭐⭐ Intermedio-Avanzado  
**🎯 Conceptos:** Parámetros nombrados, opcionales, arrow functions, funciones de orden superior

---

## 🎯 Objetivo

**En clase (20 min):** Aprenderás los diferentes tipos de funciones y parámetros en Dart siguiendo esta guía.  
**En casa (30 min):** Completarás ejercicios de funciones de orden superior y callbacks.

---

## 📚 Conceptos que Veremos

### En Clase (Presencial):

- ✅ Funciones con parámetros opcionales posicionales
- ✅ Funciones con parámetros nombrados
- ✅ Valores por defecto
- ✅ Arrow functions (funciones flecha)
- ✅ Funciones anónimas

### En Casa (Autónomo):

- ✅ Funciones de orden superior
- ✅ Callbacks
- ✅ Closures
- ✅ Funciones como parámetros

---

## 🖥️ Resultado Esperado

Al completar esta práctica, dominarás:

```dart
// Función tradicional
String greet(String name) {
  return 'Hola, $name';
}

// Arrow function
String greet(String name) => 'Hola, $name';

// Parámetros opcionales
void printInfo(String name, [int? age, String? city]) { }

// Parámetros nombrados
void printInfo({required String name, int? age, String? city}) { }

// Función de orden superior
void execute(Function callback) {
  callback();
}
```

---

## 📋 Requisitos

### Funcionales:

- [ ] Crear funciones con diferentes tipos de parámetros
- [ ] Implementar arrow functions
- [ ] Usar funciones como callbacks
- [ ] Crear funciones que retornen funciones
- [ ] Implementar closures

### Técnicos:

- [ ] Sintaxis correcta de parámetros opcionales `[]`
- [ ] Sintaxis correcta de parámetros nombrados `{}`
- [ ] Uso de `required` cuando sea necesario
- [ ] Null safety en parámetros opcionales
- [ ] Código limpio y bien documentado

---

## 🚀 Parte 1: Presencial (20 min)

### Ejercicio 1: Parámetros Opcionales Posicionales (5 min)

```dart
/**
 * Función con parámetros opcionales posicionales
 * 
 * ¿Qué hace?
 * Formatea un nombre completo con partes opcionales
 * 
 * ¿Para qué?
 * Manejar datos que pueden o no estar presentes
 * 
 * ¿Cómo funciona?
 * Los parámetros entre [] son opcionales y se pasan por posición
 */

// Sintaxis: parámetros opcionales entre []
String formatName(String firstName, [String? middleName, String? lastName]) {
  String fullName = firstName;
  
  if (middleName != null) {
    fullName += ' $middleName';
  }
  
  if (lastName != null) {
    fullName += ' $lastName';
  }
  
  return fullName;
}

void main() {
  print('=== Parámetros Opcionales Posicionales ===');
  
  // Llamar con 1 parámetro
  print(formatName('Juan'));                    // Juan
  
  // Llamar con 2 parámetros
  print(formatName('Juan', 'Carlos'));          // Juan Carlos
  
  // Llamar con 3 parámetros
  print(formatName('Juan', 'Carlos', 'Pérez')); // Juan Carlos Pérez
  
  // No puedes omitir el parámetro del medio
  // print(formatName('Juan', 'Pérez')); // Esto lo toma como middleName
}
```

**Características clave:**
- Parámetros entre `[]` son opcionales
- Se pasan **por posición**
- No puedes omitir parámetros intermedios
- Deben ser nullable (`String?`) o tener valor por defecto

---

### Ejercicio 2: Parámetros Nombrados (5 min)

```dart
/**
 * Función con parámetros nombrados
 * 
 * ¿Qué hace?
 * Crea un usuario con datos opcionales
 * 
 * ¿Para qué?
 * Mayor claridad al llamar funciones con muchos parámetros
 * 
 * ¿Cómo funciona?
 * Los parámetros entre {} son nombrados y pueden ser opcionales o requeridos
 */

// Sintaxis: parámetros nombrados entre {}
void createUser({
  required String username,  // requerido
  String? email,             // opcional
  int age = 18,              // opcional con valor por defecto
  bool isActive = true,      // opcional con valor por defecto
}) {
  print('Usuario: $username');
  print('Email: ${email ?? 'No proporcionado'}');
  print('Edad: $age');
  print('Activo: $isActive');
  print('---');
}

void main() {
  print('=== Parámetros Nombrados ===');
  
  // Solo parámetro requerido
  createUser(username: 'juanp');
  
  // Con algunos opcionales
  createUser(
    username: 'mariac',
    email: 'maria@example.com',
  );
  
  // Con todos los parámetros
  createUser(
    username: 'carlos',
    email: 'carlos@example.com',
    age: 25,
    isActive: false,
  );
  
  // Orden no importa con parámetros nombrados
  createUser(
    age: 30,
    username: 'ana',
    email: 'ana@example.com',
  );
}
```

**Ventajas de parámetros nombrados:**
- ✅ Llamadas más legibles
- ✅ Orden flexible
- ✅ Fácil omitir parámetros opcionales
- ✅ Mejor para funciones con muchos parámetros

---

### Ejercicio 3: Arrow Functions (5 min)

```dart
/**
 * Arrow Functions (Funciones Flecha)
 * 
 * ¿Qué hace?
 * Sintaxis concisa para funciones de una sola expresión
 * 
 * ¿Para qué?
 * Código más limpio y conciso
 * 
 * ¿Cómo funciona?
 * Usa => para funciones que retornan una expresión
 */

// Función tradicional
int sumaTradicional(int a, int b) {
  return a + b;
}

// Arrow function (equivalente)
int sumaArrow(int a, int b) => a + b;

// Más ejemplos de arrow functions
String greet(String name) => 'Hola, $name!';

bool isAdult(int age) => age >= 18;

int square(int n) => n * n;

double calculateArea(double radius) => 3.14159 * radius * radius;

void printMessage(String msg) => print(msg);

void main() {
  print('=== Arrow Functions ===');
  
  // Usar funciones arrow
  print(sumaArrow(5, 3));              // 8
  print(greet('Juan'));                 // Hola, Juan!
  print(isAdult(20));                   // true
  print(square(5));                     // 25
  print(calculateArea(10));             // 314.159
  printMessage('Mensaje desde arrow');  // Mensaje desde arrow
  
  // Arrow functions en colecciones
  final numbers = [1, 2, 3, 4, 5];
  
  // map con arrow function
  final doubled = numbers.map((n) => n * 2).toList();
  print('Duplicados: $doubled');
  
  // where con arrow function
  final evens = numbers.where((n) => n % 2 == 0).toList();
  print('Pares: $evens');
}
```

**Reglas de arrow functions:**
- ✅ Solo para expresiones únicas
- ✅ Retorno implícito (no uses `return`)
- ✅ Sintaxis: `=> expresion`
- ❌ No uses `{}` con `=>`

---

### Ejercicio 4: Funciones Anónimas (5 min)

```dart
/**
 * Funciones Anónimas (Lambdas)
 * 
 * ¿Qué hace?
 * Funciones sin nombre, usadas como valores
 * 
 * ¿Para qué?
 * Callbacks, operaciones en colecciones
 * 
 * ¿Cómo funciona?
 * Se definen inline y se pasan como argumentos
 */

void main() {
  print('=== Funciones Anónimas ===');
  
  final numbers = [1, 2, 3, 4, 5];
  
  // Función anónima tradicional
  numbers.forEach((number) {
    print('Número: $number');
  });
  
  // Función anónima arrow
  numbers.forEach((n) => print('Valor: $n'));
  
  // Asignar función anónima a variable
  var suma = (int a, int b) {
    return a + b;
  };
  print('Suma: ${suma(10, 5)}');
  
  // Arrow function asignada a variable
  var multiplica = (int a, int b) => a * b;
  print('Multiplicación: ${multiplica(10, 5)}');
  
  // Función anónima con múltiples líneas
  final students = ['Juan', 'María', 'Carlos'];
  students.forEach((student) {
    final upper = student.toUpperCase();
    final length = student.length;
    print('$upper tiene $length letras');
  });
}
```

---

## 🏠 Parte 2: Autónomo (30 min)

### Ejercicio 5: Funciones de Orden Superior (10 min)

**Objetivo:** Crear funciones que reciben otras funciones como parámetros.

```dart
/**
 * Funciones de Orden Superior
 * 
 * ¿Qué hace?
 * Funciones que reciben o retornan otras funciones
 * 
 * ¿Para qué?
 * Código reutilizable y flexible
 * 
 * ¿Cómo funciona?
 * Pasa funciones como argumentos
 */

// Función que recibe otra función como parámetro
void executeOperation(int a, int b, Function(int, int) operation) {
  final result = operation(a, b);
  print('Resultado: $result');
}

// Función que retorna otra función
Function makeMultiplier(int multiplier) {
  return (int value) => value * multiplier;
}

// Procesador genérico de listas
List<T> processList<T>(List<T> items, T Function(T) processor) {
  return items.map(processor).toList();
}

void main() {
  print('=== Funciones de Orden Superior ===');
  
  // 1. Pasar funciones como argumentos
  executeOperation(10, 5, (a, b) => a + b);      // 15
  executeOperation(10, 5, (a, b) => a - b);      // 5
  executeOperation(10, 5, (a, b) => a * b);      // 50
  
  // 2. Funciones que retornan funciones
  final multiplyBy2 = makeMultiplier(2);
  final multiplyBy10 = makeMultiplier(10);
  
  print('5 * 2 = ${multiplyBy2(5)}');     // 10
  print('5 * 10 = ${multiplyBy10(5)}');   // 50
  
  // 3. Procesador genérico
  final numbers = [1, 2, 3, 4, 5];
  final doubled = processList(numbers, (n) => n * 2);
  final squared = processList(numbers, (n) => n * n);
  
  print('Duplicados: $doubled');
  print('Cuadrados: $squared');
}
```

**Tu tarea:**
Crea una función `applyDiscount` que reciba un precio y una función de descuento, y retorne el precio con descuento aplicado.

```dart
// TODO: Implementa esta función
double applyDiscount(double price, double Function(double) discountFn) {
  // Tu código aquí
}

void main() {
  // Descuento del 10%
  final price1 = applyDiscount(100, (p) => p * 0.10);
  
  // Descuento del 20%
  final price2 = applyDiscount(100, (p) => p * 0.20);
  
  print('Precio con 10%: \$${price1}');
  print('Precio con 20%: \$${price2}');
}
```

---

### Ejercicio 6: Callbacks y Asincronía Simulada (10 min)

**Objetivo:** Usar callbacks para manejar operaciones asíncronas.

```dart
/**
 * Callbacks
 * 
 * ¿Qué hace?
 * Funciones que se ejecutan cuando termina una operación
 * 
 * ¿Para qué?
 * Manejar operaciones que toman tiempo (API, archivos, etc)
 * 
 * ¿Cómo funciona?
 * Pasas una función para ejecutar "después"
 */

// Simulación de operación que toma tiempo
void fetchUserData(String userId, Function(Map<String, dynamic>) onSuccess) {
  print('Buscando usuario $userId...');
  
  // Simular delay (en la vida real sería una API call)
  // Por ahora ejecutamos inmediatamente
  final userData = {
    'id': userId,
    'name': 'Juan Pérez',
    'email': 'juan@example.com',
  };
  
  // Llamar al callback con los datos
  onSuccess(userData);
}

// Con callback de error
void fetchData(
  String endpoint,
  {required Function(dynamic) onSuccess,
  required Function(String) onError}
) {
  print('Llamando a $endpoint...');
  
  if (endpoint.isNotEmpty) {
    onSuccess({'data': 'Datos desde $endpoint'});
  } else {
    onError('Endpoint vacío');
  }
}

void main() {
  print('=== Callbacks ===');
  
  // 1. Callback simple
  fetchUserData('user123', (userData) {
    print('Usuario recibido: ${userData['name']}');
    print('Email: ${userData['email']}');
  });
  
  // 2. Callbacks con éxito y error
  fetchData(
    '/api/users',
    onSuccess: (data) {
      print('✅ Éxito: $data');
    },
    onError: (error) {
      print('❌ Error: $error');
    },
  );
  
  fetchData(
    '',
    onSuccess: (data) => print('✅ Éxito: $data'),
    onError: (error) => print('❌ Error: $error'),
  );
}
```

**Tu tarea:**
Crea una función `processPayment` que simule un pago y use callbacks para manejar éxito y error.

```dart
// TODO: Implementa esta función
void processPayment(
  double amount,
  {required Function(String) onSuccess,
  required Function(String) onError}
) {
  // Si amount > 0, llamar onSuccess con mensaje de confirmación
  // Si amount <= 0, llamar onError con mensaje de error
}

void main() {
  processPayment(
    100.0,
    onSuccess: (msg) => print('✅ $msg'),
    onError: (msg) => print('❌ $msg'),
  );
  
  processPayment(
    -10.0,
    onSuccess: (msg) => print('✅ $msg'),
    onError: (msg) => print('❌ $msg'),
  );
}
```

---

### Ejercicio 7: Closures (10 min)

**Objetivo:** Entender y usar closures (funciones que capturan variables del scope externo).

```dart
/**
 * Closures
 * 
 * ¿Qué hace?
 * Función que "recuerda" variables de su scope externo
 * 
 * ¿Para qué?
 * Encapsular estado, crear funciones especializadas
 * 
 * ¿Cómo funciona?
 * La función interna accede a variables de la función externa
 */

// Ejemplo 1: Contador con closure
Function makeCounter() {
  int count = 0; // Variable capturada
  
  return () {
    count++;
    return count;
  };
}

// Ejemplo 2: Generador de saludos
Function makeGreeter(String greeting) {
  return (String name) => '$greeting, $name!';
}

// Ejemplo 3: Calculadora con estado
class Calculator {
  double _result = 0;
  
  Function get add => (double n) {
    _result += n;
    return _result;
  };
  
  Function get multiply => (double n) {
    _result *= n;
    return _result;
  };
  
  void reset() => _result = 0;
  
  double get result => _result;
}

void main() {
  print('=== Closures ===');
  
  // 1. Contador
  final counter1 = makeCounter();
  final counter2 = makeCounter();
  
  print('Counter 1:');
  print(counter1()); // 1
  print(counter1()); // 2
  print(counter1()); // 3
  
  print('Counter 2:');
  print(counter2()); // 1
  print(counter2()); // 2
  
  // 2. Saludos personalizados
  final greetInSpanish = makeGreeter('Hola');
  final greetInEnglish = makeGreeter('Hello');
  
  print(greetInSpanish('Juan'));    // Hola, Juan!
  print(greetInEnglish('John'));    // Hello, John!
  
  // 3. Calculadora con estado
  final calc = Calculator();
  print('\nCalculadora:');
  print('Inicial: ${calc.result}');
  print('Add 10: ${calc.add(10)}');
  print('Add 5: ${calc.add(5)}');
  print('Multiply 2: ${calc.multiply(2)}');
  print('Result: ${calc.result}');
}
```

**Tu tarea:**
Crea una función `createBankAccount` que retorne funciones para depositar, retirar y consultar balance.

```dart
// TODO: Implementa esta función
Map<String, Function> createBankAccount(double initialBalance) {
  // Tu código aquí
  // Debe retornar un Map con:
  // - 'deposit': función que agrega dinero
  // - 'withdraw': función que retira dinero
  // - 'getBalance': función que retorna el balance actual
}

void main() {
  final account = createBankAccount(100);
  
  print('Balance inicial: ${account['getBalance']!()}');
  account['deposit']!(50);
  print('Después de depositar: ${account['getBalance']!()}');
  account['withdraw']!(30);
  print('Después de retirar: ${account['getBalance']!()}');
}
```

---

## ✅ Checklist de Completitud

### Parte Presencial:
- [ ] Ejercicio 1: Parámetros Opcionales Posicionales
- [ ] Ejercicio 2: Parámetros Nombrados
- [ ] Ejercicio 3: Arrow Functions
- [ ] Ejercicio 4: Funciones Anónimas

### Parte Autónoma:
- [ ] Ejercicio 5: Funciones de Orden Superior
- [ ] Ejercicio 6: Callbacks
- [ ] Ejercicio 7: Closures
- [ ] Tarea 1: `applyDiscount`
- [ ] Tarea 2: `processPayment`
- [ ] Tarea 3: `createBankAccount`

---

## 📖 Resumen de Conceptos

### Tipos de Parámetros

```dart
// Posicionales requeridos
void func1(int a, String b) { }

// Posicionales opcionales
void func2(int a, [String? b, int? c]) { }

// Nombrados opcionales
void func3({String? name, int? age}) { }

// Nombrados requeridos
void func4({required String name, int age = 0}) { }

// Mixtos
void func5(int a, {required String name, int? age}) { }
```

### Arrow Functions

```dart
// Tradicional
int suma(int a, int b) {
  return a + b;
}

// Arrow
int suma(int a, int b) => a + b;
```

### Funciones de Orden Superior

```dart
// Función que recibe función
void execute(Function callback) => callback();

// Función que retorna función
Function makeFunc() => () => print('Hi');
```

---

## 🚀 Recursos Adicionales

- [Dart Functions](https://dart.dev/guides/language/language-tour#functions)
- [Effective Dart: Functions](https://dart.dev/guides/language/effective-dart/usage#functions)
- [Dart Closures](https://dart.dev/guides/language/language-tour#lexical-closures)

---

## 💡 Tips para el Éxito

1. **Practica cada tipo de función** en DartPad
2. **Usa parámetros nombrados** para funciones con 3+ parámetros
3. **Arrow functions** solo para expresiones simples
4. **Closures** son poderosos para encapsular estado
5. **Experimenta** cambiando parámetros y viendo resultados

---

## 🆘 Errores Comunes

### Error 1: Mezclar sintaxis

```dart
// ❌ Error: no uses {} con =>
int suma(int a, int b) => { return a + b; }

// ✅ Correcto
int suma(int a, int b) => a + b;
```

### Error 2: Olvidar 'required'

```dart
// ❌ Error: parámetros nombrados sin 'required' son opcionales
void func({String name}) { } // Error de compilación

// ✅ Correcto
void func({required String name}) { }
// o
void func({String? name}) { }
```

### Error 3: Orden incorrecto de parámetros

```dart
// ❌ Error: opcionales después de requeridos
void func([int? a], int b) { } // Error!

// ✅ Correcto
void func(int b, [int? a]) { }
```

---

**🎯 ¡Excelente trabajo!** Has dominado funciones avanzadas en Dart. Estos conceptos son fundamentales para Flutter.

**Próximo paso:** Completa el **Proyecto Integrador** de la Semana 1 en `../3-proyecto/`
