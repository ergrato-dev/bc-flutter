# 💻 Práctica 1: Variables y Operadores - Calculadora Personal

**⏱️ Duración:** 45 minutos  
**📊 Dificultad:** ⭐ Fácil  
**🎯 Conceptos:** Variables, tipos de datos, operadores, entrada/salida

---

## 🎯 Objetivo

Crear un programa en Dart que funcione como una **calculadora personal** con múltiples operaciones matemáticas y conversiones.

---

## 📚 Conceptos que Aplicaremos

- ✅ Declaración de variables (`var`, `final`, `const`)
- ✅ Tipos de datos primitivos (`int`, `double`, `String`)
- ✅ Operadores aritméticos
- ✅ Conversión de tipos
- ✅ String interpolation
- ✅ Funciones `print()` para output

---

## 🖼️ Resultado Esperado

Tu programa debe ejecutarse y mostrar:

```
=== CALCULADORA PERSONAL ===

--- Operaciones Básicas ---
10 + 5 = 15
10 - 5 = 5
10 * 5 = 50
10 / 5 = 2.0
10 ~/ 3 = 3 (división entera)
10 % 3 = 1 (módulo)

--- Conversiones ---
Temperatura: 25°C = 77.0°F
Distancia: 100 km = 62.137 mi
Peso: 70 kg = 154.324 lb

--- Cálculo de IMC ---
Peso: 70.0 kg
Altura: 1.75 m
IMC: 22.86
Categoría: Normal
```

---

## 🛠️ Instrucciones Paso a Paso

### Paso 1: Crear el Archivo

1. Ve a [DartPad](https://dartpad.dev/)
2. O crea un archivo `calculadora.dart` en tu computadora

### Paso 2: Variables Básicas

```dart
void main() {
  // Constantes para operaciones
  const int a = 10;
  const int b = 5;

  print('=== CALCULADORA PERSONAL ===\n');
  print('--- Operaciones Básicas ---');

  // TODO: Agregar operaciones aquí
}
```

### Paso 3: Operaciones Aritméticas

Agrega estas operaciones dentro de `main()`:

```dart
// Suma
int suma = a + b;
print('$a + $b = $suma');

// Resta
int resta = a - b;
print('$a - $b = $resta');

// Multiplicación
int multiplicacion = a * b;
print('$a * $b = $multiplicacion');

// División (resultado double)
double division = a / b;
print('$a / $b = $division');

// División entera
int divisionEntera = a ~/ 3;
print('$a ~/ 3 = $divisionEntera (división entera)');

// Módulo
int modulo = a % 3;
print('$a % 3 = $modulo (módulo)');
```

### Paso 4: Conversiones

Agrega una sección de conversiones:

```dart
print('\n--- Conversiones ---');

// Celsius a Fahrenheit
double celsius = 25.0;
double fahrenheit = (celsius * 9 / 5) + 32;
print('Temperatura: ${celsius}°C = $fahrenheit°F');

// Kilómetros a Millas
double km = 100.0;
double miles = km * 0.62137;
print('Distancia: $km km = ${miles.toStringAsFixed(3)} mi');

// Kilogramos a Libras
double kg = 70.0;
double lb = kg * 2.20462;
print('Peso: $kg kg = ${lb.toStringAsFixed(3)} lb');
```

### Paso 5: Cálculo de IMC

Agrega el cálculo del Índice de Masa Corporal:

```dart
print('\n--- Cálculo de IMC ---');

double weight = 70.0;  // kg
double height = 1.75;  // metros

double bmi = weight / (height * height);
String category = bmi < 18.5
    ? 'Bajo peso'
    : bmi < 25
        ? 'Normal'
        : bmi < 30
            ? 'Sobrepeso'
            : 'Obesidad';

print('Peso: $weight kg');
print('Altura: $height m');
print('IMC: ${bmi.toStringAsFixed(2)}');
print('Categoría: $category');
```

---

## ✅ Código Completo

<details>
<summary>👁️ Ver solución completa (intenta hacerlo primero)</summary>

```dart
void main() {
  // Constantes para operaciones
  const int a = 10;
  const int b = 5;

  print('=== CALCULADORA PERSONAL ===\n');

  // ==========================================
  // OPERACIONES BÁSICAS
  // ==========================================
  print('--- Operaciones Básicas ---');

  int suma = a + b;
  print('$a + $b = $suma');

  int resta = a - b;
  print('$a - $b = $resta');

  int multiplicacion = a * b;
  print('$a * $b = $multiplicacion');

  double division = a / b;
  print('$a / $b = $division');

  int divisionEntera = a ~/ 3;
  print('$a ~/ 3 = $divisionEntera (división entera)');

  int modulo = a % 3;
  print('$a % 3 = $modulo (módulo)');

  // ==========================================
  // CONVERSIONES
  // ==========================================
  print('\n--- Conversiones ---');

  // Celsius a Fahrenheit
  double celsius = 25.0;
  double fahrenheit = (celsius * 9 / 5) + 32;
  print('Temperatura: ${celsius}°C = $fahrenheit°F');

  // Kilómetros a Millas
  double km = 100.0;
  double miles = km * 0.62137;
  print('Distancia: $km km = ${miles.toStringAsFixed(3)} mi');

  // Kilogramos a Libras
  double kg = 70.0;
  double lb = kg * 2.20462;
  print('Peso: $kg kg = ${lb.toStringAsFixed(3)} lb');

  // ==========================================
  // CÁLCULO DE IMC
  // ==========================================
  print('\n--- Cálculo de IMC ---');

  double weight = 70.0;
  double height = 1.75;

  double bmi = weight / (height * height);
  String category = bmi < 18.5
      ? 'Bajo peso'
      : bmi < 25
          ? 'Normal'
          : bmi < 30
              ? 'Sobrepeso'
              : 'Obesidad';

  print('Peso: $weight kg');
  print('Altura: $height m');
  print('IMC: ${bmi.toStringAsFixed(2)}');
  print('Categoría: $category');
}
```

</details>

---

## 🎨 Desafíos Adicionales

Una vez que termines el ejercicio básico, intenta estos desafíos:

### ⭐ Nivel 1: Personalizar

- Cambia los valores de `a` y `b` a tus números favoritos
- Agrega más conversiones (pulgadas a cm, galones a litros)
- Cambia los valores de peso y altura por los tuyos

### ⭐⭐ Nivel 2: Más Operaciones

- Agrega potencia: `a elevado a b`
- Agrega raíz cuadrada (usa `import 'dart:math'` y `sqrt()`)
- Calcula el promedio de 5 números

### ⭐⭐⭐ Nivel 3: Avanzado

- Crea una función `calculate()` que reciba operación como parámetro
- Valida que las operaciones sean seguras (ej: división por cero)
- Formatea la salida con colores usando ANSI codes

---

## 🐛 Problemas Comunes

### Error: "Expected to find ';'"

**Problema:** Olvidaste el punto y coma al final de una línea.

```dart
print('Hola')  // ❌ Falta ;
print('Hola'); // ✅ Correcto
```

### Error: "The getter 'length' isn't defined"

**Problema:** Intentaste usar un método de String en un número.

```dart
int number = 42;
// number.length;  // ❌ int no tiene length
number.toString().length;  // ✅ Convierte a String primero
```

### Error: "A value of type 'int' can't be assigned to 'String'"

**Problema:** Tipos incompatibles.

```dart
String text = 42;  // ❌
String text = '42';  // ✅ String
String text = 42.toString();  // ✅ Conversión
```

---

## 📝 Entregables

Al finalizar deberías tener:

- [ ] Programa que ejecuta sin errores
- [ ] Todas las operaciones funcionando correctamente
- [ ] Output formateado y legible
- [ ] Al menos 1 desafío adicional completado (opcional)

---

## 🔗 Recursos

- [Dart Operators](https://dart.dev/guides/language/language-tour#operators)
- [Dart Numbers](https://dart.dev/guides/language/numbers)
- [DartPad para practicar](https://dartpad.dev/)

---

**💡 Tip:** Usa `print()` frecuentemente para verificar valores intermedios mientras desarrollas.

