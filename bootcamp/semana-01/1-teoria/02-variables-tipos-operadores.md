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

| Categoría | Operadores | Descripción |
|-----------|-----------|-------------|
| **Aritméticos** | `+`, `-`, `*`, `/`, `~/`, `%` | Operaciones matemáticas |
| **Asignación** | `=`, `+=`, `-=`, `*=`, `/=` | Asignar valores |
| **Comparación** | `==`, `!=`, `>`, `<`, `>=`, `<=` | Comparar valores |
| **Lógicos** | `&&`, `||`, `!` | Combinar condiciones booleanas |
| **Null-aware** | `??`, `??=`, `?.`, `!` | Trabajar con valores nulos |
| **Tipo** | `is`, `is!`, `as` | Verificar y castear tipos |

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
**🎯 Progreso:** 2/10 módulos completados

```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './App.{js,jsx,ts,tsx}',
    './app/**/*.{js,jsx,ts,tsx}',
    './components/**/*.{js,jsx,ts,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
```

**Editar `babel.config.js`:**

```js
module.exports = function (api) {
  api.cache(true);
  return {
    presets: ['babel-preset-expo'],
    plugins: ['nativewind/babel'],
  };
};
```

**Crear `nativewind-env.d.ts` en la raíz:**

```typescript
/// <reference types="nativewind/types" />
```

#### 3.4 Ejecutar el Proyecto

```bash
# Iniciar servidor de desarrollo
pnpm start

# Opciones disponibles:
# - Presiona 'a' para abrir en Android
# - Presiona 'i' para abrir en iOS
# - Escanea el QR con Expo Go en tu celular
```

**🎯 TODOS en clase:** Escanear QR y ver la app en sus celulares.

---

### Paso 4: Primer Código - "Hola Mundo" (20 min)

**Editar `App.tsx`:**

```tsx
import { View, Text } from 'react-native';

export default function App() {
  return (
    <View className="flex-1 items-center justify-center bg-blue-500">
      <Text className="text-white text-4xl font-bold">¡Hola Mundo!</Text>
      <Text className="text-white text-lg mt-4">
        Mi primera app con React Native
      </Text>
    </View>
  );
}
```

**Guardar el archivo y ver cambios instantáneos en el celular (Fast Refresh).**

---

## PARTE 2: Componentes Básicos (90 minutos)

### 📦 Los 7 Componentes Fundamentales

React Native tiene componentes nativos que se mapean directamente a componentes del sistema operativo:

| Componente React Native | iOS          | Android    |
| ----------------------- | ------------ | ---------- |
| `<View>`                | UIView       | ViewGroup  |
| `<Text>`                | UILabel      | TextView   |
| `<Image>`               | UIImageView  | ImageView  |
| `<ScrollView>`          | UIScrollView | ScrollView |
| `<TextInput>`           | UITextField  | EditText   |

---

### 1. View - El Contenedor Universal

**¿Qué hace?**
`View` es el bloque de construcción más básico. Es como un `<div>` en HTML.

**¿Para qué sirve?**

- Contenedor para otros componentes
- Aplicar estilos y layouts
- Agrupar elementos relacionados

**Ejemplo en vivo:**

```tsx
import { View } from 'react-native'

// View básico
<View className="bg-red-500 p-5">
  {/* Contenido aquí */}
</View>

// View con estilos inline (también funciona)
<View style={{ backgroundColor: 'blue', padding: 20 }}>
  {/* Contenido */}
</View>

// Anidación de Views
<View className="flex-1 bg-gray-100">
  <View className="bg-white p-4 m-3 rounded-lg">
    <View className="h-20 bg-blue-500 rounded"></View>
  </View>
</View>
```

**Props importantes:**

- `className` / `style` - Estilos
- `onLayout` - Detectar cambios de tamaño
- `pointerEvents` - Controlar eventos táctiles

---

### 2. Text - Para Mostrar Texto

**¿Qué hace?**
`Text` muestra texto. TODO el texto debe estar dentro de un componente `<Text>`.

**❌ ESTO NO FUNCIONA:**

```tsx
<View>
  Hola Mundo{' '}
  {/* ERROR: Text strings must be rendered within a <Text> component */}
</View>
```

**✅ ESTO SÍ:**

```tsx
<View>
  <Text>Hola Mundo</Text>
</View>
```

**Ejemplo en vivo:**

```tsx
import { Text } from 'react-native'

// Estilos con Tailwind
<Text className="text-2xl font-bold text-blue-600">
  Título Grande
</Text>

<Text className="text-base text-gray-700">
  Texto normal de contenido
</Text>

<Text className="text-sm text-gray-500 italic">
  Texto pequeño en cursiva
</Text>

// Text anidado (hereda estilos)
<Text className="text-lg font-bold">
  Esto es <Text className="text-red-500">rojo</Text> y esto es normal
</Text>

// Número de líneas limitado
<Text numberOfLines={2} className="text-base">
  Este es un texto muy largo que se cortará después de 2 líneas...
</Text>
```

**Props importantes:**

- `numberOfLines` - Limitar líneas de texto
- `ellipsizeMode` - Cómo mostrar "..." (tail, head, middle)
- `onPress` - Hacer texto clickeable
- `selectable` - Permitir seleccionar/copiar texto

---

### 3. Image - Para Mostrar Imágenes

**¿Qué hace?**
`Image` muestra imágenes de diferentes fuentes.

**Tipos de imágenes:**

1. **Red (URL):** `{ uri: 'https://...' }`
2. **Local:** `require('./imagen.png')`
3. **Base64:** `{ uri: 'data:image/png;base64,...' }`

**Ejemplo en vivo:**

```tsx
import { Image } from 'react-native'

// Imagen desde URL
<Image
  source={{ uri: 'https://picsum.photos/300/200' }}
  className="w-full h-48 rounded-lg"
  resizeMode="cover"
/>

// Imagen local
<Image
  source={require('./assets/logo.png')}
  className="w-32 h-32"
/>

// Avatar circular
<Image
  source={{ uri: 'https://i.pravatar.cc/150' }}
  className="w-20 h-20 rounded-full"
/>
```

**Props importantes:**

- `source` - Fuente de la imagen (requerido)
- `resizeMode` - Cómo ajustar: `cover`, `contain`, `stretch`, `center`
- `className` / `style` - Dimensiones y estilos
- `onLoad` - Callback cuando carga
- `onError` - Callback si falla

---

### 4. ScrollView - Para Contenido Scrollable

**¿Qué hace?**
`ScrollView` permite hacer scroll cuando el contenido es más grande que la pantalla.

**¿Cuándo usar?**

- Formularios largos
- Contenido que puede exceder altura de pantalla
- Listas pequeñas (< 20 items)

**⚠️ Para listas largas (100+ items):** Usar `FlatList` (lo veremos en semana 2).

**Ejemplo en vivo:**

```tsx
import { ScrollView, View, Text } from 'react-native';
<ScrollView className="flex-1 bg-gray-50">
  <View className="p-5">
    {/* Contenido largo */}
    {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((item) => (
      <View
        key={item}
        className="bg-white p-5 mb-3 rounded-lg">
        <Text className="text-lg font-bold">Item {item}</Text>
        <Text className="text-gray-600">Descripción del item</Text>
      </View>
    ))}
  </View>
</ScrollView>;
```

**Props importantes:**

- `horizontal` - Scroll horizontal en lugar de vertical
- `showsVerticalScrollIndicator` - Mostrar/ocultar barra de scroll
- `contentContainerStyle` - Estilos del contenido interno
- `refreshControl` - Pull-to-refresh
- `onScroll` - Detectar scroll

---

### 5. TextInput - Para Inputs de Texto

**¿Qué hace?**
`TextInput` permite al usuario ingresar texto.

**Ejemplo en vivo:**

```tsx
import { TextInput, View, Text } from 'react-native';
import { useState } from 'react';

export default function App() {
  const [text, setText] = useState('');

  return (
    <View className="flex-1 p-5 justify-center bg-white">
      <Text className="text-xl font-bold mb-3">Ingresa tu nombre:</Text>

      <TextInput
        value={text}
        onChangeText={setText}
        placeholder="Escribe aquí..."
        className="border border-gray-300 rounded-lg px-4 py-3 text-base"
      />

      <Text className="text-gray-600 mt-3">
        Escribiste: {text || '(vacío)'}
      </Text>
    </View>
  );
}
```

**Tipos de teclado:**

```tsx
// Teclado de email
<TextInput keyboardType="email-address" />

// Teclado numérico
<TextInput keyboardType="numeric" />

// Teclado de teléfono
<TextInput keyboardType="phone-pad" />

// Teclado de URL
<TextInput keyboardType="url" />

// Input de contraseña
<TextInput secureTextEntry />
```

**Props importantes:**

- `value` - Valor controlado
- `onChangeText` - Callback al cambiar texto
- `placeholder` - Texto de ayuda
- `keyboardType` - Tipo de teclado
- `secureTextEntry` - Ocultar texto (contraseñas)
- `multiline` - Permitir múltiples líneas
- `autoCapitalize` - Capitalización automática
- `autoCorrect` - Autocorrección

---

### 6. Button - Botón Básico

**¿Qué hace?**
`Button` es un botón simple nativo. **Muy limitado en personalización.**

**⚠️ En producción:** Mejor usar `TouchableOpacity` con estilos personalizados.

```tsx
import { Button, Alert } from 'react-native';
<Button
  title="Presionar"
  onPress={() => Alert.alert('¡Botón presionado!')}
  color="#3b82f6"
/>;
```

---

### 7. TouchableOpacity - Botón Personalizable

**¿Qué hace?**
`TouchableOpacity` hace que cualquier componente sea presionable con efecto de opacidad.

**¿Por qué usarlo?**

- Totalmente personalizable
- Efecto visual al presionar (baja opacidad)
- Puedes poner cualquier contenido dentro

**Ejemplo en vivo:**

```tsx
import { TouchableOpacity, Text, View } from 'react-native'

// Botón básico
<TouchableOpacity
  onPress={() => console.log('Presionado')}
  activeOpacity={0.7}
  className="bg-blue-600 px-6 py-3 rounded-lg"
>
  <Text className="text-white text-center font-bold">
    Presionar
  </Text>
</TouchableOpacity>

// Botón con icono y texto
<TouchableOpacity
  className="bg-green-500 px-6 py-4 rounded-full flex-row items-center"
  onPress={() => {}}
>
  <Text className="text-2xl mr-2">✓</Text>
  <Text className="text-white font-bold text-lg">Confirmar</Text>
</TouchableOpacity>

// Card presionable
<TouchableOpacity
  className="bg-white p-5 rounded-xl shadow-md m-3"
  onPress={() => {}}
>
  <Text className="text-xl font-bold mb-2">Título</Text>
  <Text className="text-gray-600">Descripción de la card</Text>
</TouchableOpacity>
```

---

## PARTE 3: Layouts con Flexbox (40 minutos)

### 🧩 Flexbox en React Native

**TODO en React Native usa Flexbox por defecto.**

No existe `display: block` ni `display: inline`. Solo `display: flex`.

#### Ejes en Flexbox

```
Eje Principal (Main Axis) - flex-direction
────────────────────────────>
│  ┌────┐  ┌────┐  ┌────┐
│  │ 1  │  │ 2  │  │ 3  │
↓  └────┘  └────┘  └────┘
Eje Cruzado (Cross Axis)
```

### Propiedades Básicas

#### 1. flex-direction (dirección del layout)

```tsx
// Vertical (por defecto en RN)
<View className="flex-col">
  <View className="h-20 bg-red-500" />
  <View className="h-20 bg-blue-500" />
  <View className="h-20 bg-green-500" />
</View>

// Horizontal
<View className="flex-row">
  <View className="w-20 h-20 bg-red-500" />
  <View className="w-20 h-20 bg-blue-500" />
  <View className="w-20 h-20 bg-green-500" />
</View>
```

#### 2. justify-content (alineación en eje principal)

```tsx
// Al inicio
<View className="flex-row justify-start">
  {/* Elementos al inicio (izquierda en row) */}
</View>

// Al centro
<View className="flex-row justify-center">
  {/* Elementos al centro */}
</View>

// Al final
<View className="flex-row justify-end">
  {/* Elementos al final (derecha en row) */}
</View>

// Espacio entre
<View className="flex-row justify-between">
  {/* Espacio igual entre elementos */}
</View>
```

#### 3. align-items (alineación en eje cruzado)

```tsx
// Arriba
<View className="flex-row items-start h-40">
  {/* Elementos alineados arriba */}
</View>

// Centro
<View className="flex-row items-center h-40">
  {/* Elementos alineados al centro verticalmente */}
</View>

// Abajo
<View className="flex-row items-end h-40">
  {/* Elementos alineados abajo */}
</View>
```

#### 4. flex (distribución proporcional)

```tsx
<View className="flex-row h-20">
  <View className="flex-1 bg-red-500" />    {/* 1/3 del espacio */}
  <View className="flex-1 bg-blue-500" />   {/* 1/3 del espacio */}
  <View className="flex-1 bg-green-500" />  {/* 1/3 del espacio */}
</View>

<View className="flex-row h-20">
  <View className="flex-1 bg-red-500" />    {/* 1/6 del espacio */}
  <View className="flex-2 bg-blue-500" />   {/* 2/6 del espacio */}
  <View className="flex-3 bg-green-500" />  {/* 3/6 del espacio */}
</View>
```

---

## 🎯 Ejercicio Práctico en Clase (30 min)

### Crear una Card de Perfil

**Objetivo:** Aplicar TODO lo aprendido en un componente real.

```tsx
import { View, Text, Image, TouchableOpacity, ScrollView } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

export default function App() {
  return (
    <SafeAreaView className="flex-1 bg-gray-50">
      <ScrollView>
        {/* Header con avatar */}
        <View className="bg-blue-600 h-48 items-center justify-end pb-16">
          <Text className="text-white text-2xl font-bold">Mi Perfil</Text>
        </View>

        {/* Avatar superpuesto */}
        <View className="items-center -mt-16">
          <Image
            source={{ uri: 'https://i.pravatar.cc/150?img=12' }}
            className="w-32 h-32 rounded-full border-4 border-white"
          />
        </View>

        {/* Información */}
        <View className="items-center mt-4 px-5">
          <Text className="text-3xl font-bold text-gray-900">Juan Pérez</Text>
          <Text className="text-lg text-gray-600 mt-1">
            Desarrollador Mobile
          </Text>
        </View>

        {/* Datos de contacto */}
        <View className="mx-5 mt-6 bg-white rounded-xl p-5">
          <View className="flex-row items-center mb-4">
            <Text className="text-2xl mr-3">📧</Text>
            <View className="flex-1">
              <Text className="text-sm text-gray-500">Email</Text>
              <Text className="text-base text-gray-900 font-medium">
                juan@email.com
              </Text>
            </View>
          </View>

          <View className="h-px bg-gray-200 mb-4" />

          <View className="flex-row items-center">
            <Text className="text-2xl mr-3">📱</Text>
            <View className="flex-1">
              <Text className="text-sm text-gray-500">Teléfono</Text>
              <Text className="text-base text-gray-900 font-medium">
                +52 555 1234
              </Text>
            </View>
          </View>
        </View>

        {/* Botones de acción */}
        <View className="flex-row gap-3 px-5 mt-6 mb-8">
          <TouchableOpacity className="flex-1 bg-blue-600 py-4 rounded-lg">
            <Text className="text-white text-center font-bold">
              Editar Perfil
            </Text>
          </TouchableOpacity>

          <TouchableOpacity className="flex-1 bg-gray-200 py-4 rounded-lg">
            <Text className="text-gray-900 text-center font-bold">
              Compartir
            </Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
```

**TODOS en clase:** Implementar este código y personalizarlo.

---

## ✅ Checklist de Verificación

Al finalizar esta sesión presencial deberías:

- [ ] Tener Node.js 22.20+ instalado y verificado
- [ ] Tener VS Code configurado con extensiones
- [ ] Haber creado tu primer proyecto Expo
- [ ] Ver tu app funcionando en Expo Go
- [ ] Entender los 7 componentes básicos
- [ ] Poder usar View, Text, Image
- [ ] Poder usar TextInput y TouchableOpacity
- [ ] Comprender Flexbox básico
- [ ] Haber completado el ejercicio de la Card

---

## 📚 Trabajo Autónomo (30-45 minutos recomendados)

### Para reforzar lo aprendido:

1. **Personaliza la Card de Perfil:**

   - Cambia colores
   - Agrega más información (ubicación, bio)
   - Experimenta con diferentes layouts

2. **Crea una segunda pantalla:**

   - Card de producto con imagen
   - Botón de "Agregar al carrito"
   - Usa todos los componentes aprendidos

3. **Revisa documentación oficial:**
   - [React Native Core Components](https://reactnative.dev/docs/components-and-apis)
   - [Flexbox Guide](https://reactnative.dev/docs/flexbox)
   - [NativeWind Docs](https://www.nativewind.dev/)

---

## 🔗 Próximo Módulo

**Siguiente clase:**  
[03. Estado y Eventos](./03-estado-y-eventos.md) - Aprenderemos a hacer las apps interactivas con estado y manejo de eventos.

---

**Tiempo presencial:** 2.5 horas ✓  
**Tiempo autónomo recomendado:** ~30-45 minutos
