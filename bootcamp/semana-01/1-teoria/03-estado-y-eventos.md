# 03. Estructuras de Control y Funciones en Dart

**Duración:** 2 horas  
**Modalidad:** Teoría + Ejercicios prácticos  
**Objetivo:** Dominar el flujo de control y creación de funciones en Dart

---

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Usar condicionales (if-else, switch-case) efectivamente
- ✅ Implementar bucles (for, while, do-while, for-in)
- ✅ Crear funciones con diferentes tipos de parámetros
- ✅ Usar funciones flecha (arrow functions)
- ✅ Comprender el scope de variables
- ✅ Aplicar control de flujo (break, continue, return)

---

## PARTE 1: Estructuras Condicionales (40 minutos)

### 1️⃣ **if-else - Condicional Básico**

```dart
/**
 * What?
 * Estructura condicional básica para tomar decisiones
 * 
 * For?
 * Ejecutar código basado en condiciones
 * 
 * Impact?
 * Base del control de flujo en cualquier programa
 */

void main() {
  int age = 20;
  
  // if simple
  if (age >= 18) {
    print('Es mayor de edad');
  }
  
  // if-else
  if (age >= 18) {
    print('Puede votar');
  } else {
    print('No puede votar');
  }
  
  // if-else if-else (múltiples condiciones)
  if (age < 13) {
    print('Niño');
  } else if (age < 18) {
    print('Adolescente');
  } else if (age < 65) {
    print('Adulto');
  } else {
    print('Adulto mayor');
  }
  
  // Condiciones compuestas
  bool hasLicense = true;
  
  if (age >= 18 && hasLicense) {
    print('Puede conducir');
  }
  
  if (age < 16 || !hasLicense) {
    print('No puede conducir');
  }
}
```

### 2️⃣ **Operador Ternario - Condicional Compacto**

```dart
/**
 * What?
 * Expresión condicional en una sola línea
 * 
 * For?
 * Asignar valores basados en condiciones de forma concisa
 * 
 * Impact?
 * Código más limpio para condiciones simples
 */

void main() {
  int age = 20;
  
  // Sintaxis: condición ? valorSiTrue : valorSiFalse
  String status = age >= 18 ? 'Adulto' : 'Menor';
  print(status);  // 'Adulto'
  
  // Útil para asignaciones condicionales
  int score = 85;
  String grade = score >= 90 ? 'A' :
                 score >= 80 ? 'B' :
                 score >= 70 ? 'C' :
                 score >= 60 ? 'D' : 'F';
  print(grade);  // 'B'
  
  // En argumentos de funciones
  print('Resultado: ${age >= 18 ? "Aprobado" : "Rechazado"}');
}
```

### 3️⃣ **switch-case - Múltiples Opciones**

```dart
/**
 * What?
 * Estructura para comparar un valor contra múltiples opciones
 * 
 * For?
 * Código más limpio que múltiples if-else cuando hay muchas opciones
 * 
 * Impact?
 * Mejor legibilidad en comparaciones de igualdad
 */

void main() {
  String day = 'Monday';
  
  switch (day) {
    case 'Monday':
      print('Inicio de semana');
      break;
    
    case 'Tuesday':
    case 'Wednesday':
    case 'Thursday':
      print('Mitad de semana');
      break;
    
    case 'Friday':
      print('Fin de semana laboral');
      break;
    
    case 'Saturday':
    case 'Sunday':
      print('Fin de semana');
      break;
    
    default:
      print('Día no válido');
  }
  
  // Ejemplo con números
  int month = 3;
  
  switch (month) {
    case 12:
    case 1:
    case 2:
      print('Verano');
      break;
    case 3:
    case 4:
    case 5:
      print('Otoño');
      break;
    case 6:
    case 7:
    case 8:
      print('Invierno');
      break;
    case 9:
    case 10:
    case 11:
      print('Primavera');
      break;
    default:
      print('Mes inválido');
  }
}
```

### ⚠️ **Importante sobre switch:**

```dart
// ❌ ERROR: Olvidar break causa error en Dart
switch (value) {
  case 1:
    print('Uno');
    // Falta break - Dart requiere break o continue
  case 2:  // Error de compilación
    print('Dos');
}

// ✅ CORRECTO: Siempre usar break, return, throw o continue
switch (value) {
  case 1:
    print('Uno');
    break;  // ✓
  case 2:
    print('Dos');
    break;  // ✓
}
```

---

## PARTE 2: Estructuras Repetitivas (40 minutos)

### 1️⃣ **for - Bucle con Contador**

```dart
/**
 * What?
 * Bucle que se repite un número específico de veces
 * 
 * For?
 * Iterar cuando sabes cuántas veces necesitas repetir
 * 
 * Impact?
 * El bucle más común para iteraciones controladas
 */

void main() {
  // Sintaxis básica: for (inicialización; condición; incremento)
  
  // Contar del 0 al 4
  for (int i = 0; i < 5; i++) {
    print('i = $i');
  }
  // Output: i = 0, i = 1, i = 2, i = 3, i = 4
  
  // Contar hacia atrás
  for (int i = 10; i >= 0; i--) {
    print(i);
  }
  
  // Incremento personalizado
  for (int i = 0; i <= 20; i += 5) {
    print(i);  // 0, 5, 10, 15, 20
  }
  
  // Múltiples variables
  for (int i = 0, j = 10; i < j; i++, j--) {
    print('i=$i, j=$j');
  }
}
```

### 2️⃣ **for-in - Iterar Colecciones**

```dart
/**
 * What?
 * Bucle para iterar elementos de una colección
 * 
 * For?
 * Recorrer listas, sets, o cualquier iterable
 * 
 * Impact?
 * Sintaxis más limpia para iterar colecciones
 */

void main() {
  // Iterar lista
  var fruits = ['Apple', 'Banana', 'Orange'];
  
  for (var fruit in fruits) {
    print(fruit);
  }
  // Output: Apple, Banana, Orange
  
  // Iterar string (cada carácter)
  var word = 'Dart';
  for (var char in word.split('')) {
    print(char);
  }
  // Output: D, a, r, t
  
  // Iterar con índice (usando asMap())
  for (var entry in fruits.asMap().entries) {
    print('${entry.key}: ${entry.value}');
  }
  // Output: 0: Apple, 1: Banana, 2: Orange
}
```

### 3️⃣ **while - Bucle con Condición**

```dart
/**
 * What?
 * Bucle que se repite mientras una condición sea verdadera
 * 
 * For?
 * Cuando no sabes cuántas iteraciones necesitas
 * 
 * Impact?
 * Útil para procesos hasta que se cumpla una condición
 */

void main() {
  // Ejemplo 1: Contador simple
  int count = 0;
  
  while (count < 5) {
    print('Count: $count');
    count++;
  }
  
  // Ejemplo 2: Input validation (simulado)
  String? input;
  int attempts = 0;
  
  while (input == null && attempts < 3) {
    print('Intento ${attempts + 1}');
    // input = getUserInput();  // Simulado
    attempts++;
  }
  
  // Ejemplo 3: Búsqueda en lista
  var numbers = [10, 20, 30, 40, 50];
  int target = 30;
  int index = 0;
  bool found = false;
  
  while (index < numbers.length && !found) {
    if (numbers[index] == target) {
      found = true;
      print('Found at index $index');
    }
    index++;
  }
}
```

### 4️⃣ **do-while - Ejecutar al Menos Una Vez**

```dart
/**
 * What?
 * Bucle que ejecuta el código al menos una vez antes de verificar condición
 * 
 * For?
 * Cuando necesitas que el código se ejecute mínimo una vez
 * 
 * Impact?
 * Útil para validaciones y menús
 */

void main() {
  // Diferencia con while: se ejecuta PRIMERO, verifica DESPUÉS
  
  int number = 0;
  
  do {
    print('Number: $number');
    number++;
  } while (number < 5);
  
  // Caso donde se ejecuta solo una vez
  int x = 10;
  
  do {
    print('Esto se imprime aunque x >= 5');
  } while (x < 5);  // Condición false, pero ya se ejecutó
  
  // Ejemplo práctico: Menú
  String option = '';
  
  do {
    print('1. Opción A');
    print('2. Opción B');
    print('3. Salir');
    // option = readInput();  // Simulado
    option = '3';  // Para el ejemplo
  } while (option != '3');
}
```

### 5️⃣ **Control de Flujo: break y continue**

```dart
/**
 * What?
 * Palabras clave para controlar el flujo dentro de bucles
 * 
 * For?
 * break: Salir del bucle inmediatamente
 * continue: Saltar a la siguiente iteración
 * 
 * Impact?
 * Mayor control sobre la ejecución de bucles
 */

void main() {
  // BREAK - Salir del bucle
  print('=== BREAK ===');
  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      break;  // Sale del bucle cuando i es 5
    }
    print(i);
  }
  // Output: 0, 1, 2, 3, 4
  
  // CONTINUE - Saltar iteración actual
  print('\n=== CONTINUE ===');
  for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) {
      continue;  // Salta números pares
    }
    print(i);
  }
  // Output: 1, 3, 5, 7, 9
  
  // Ejemplo práctico: Buscar y detener
  print('\n=== BÚSQUEDA ===');
  var names = ['Ana', 'Carlos', 'Diana', 'Eduardo'];
  String searchName = 'Diana';
  
  for (var name in names) {
    if (name == searchName) {
      print('¡Encontrado: $name!');
      break;
    }
    print('Buscando... $name');
  }
  
  // Continue con condiciones
  print('\n=== FILTRADO ===');
  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  
  for (var num in numbers) {
    if (num < 3) continue;     // Saltar menores a 3
    if (num > 7) break;        // Detener en mayores a 7
    print(num);
  }
  // Output: 3, 4, 5, 6, 7
}
```

---

## PARTE 3: Funciones en Dart (40 minutos)

### 1️⃣ **Funciones Básicas**
  const [showGreeting, setShowGreeting] = useState(false)

  const handleSubmit = () => {
    if (name.trim().length > 0) {
      setShowGreeting(true)
    }
  }

  const handleReset = () => {
    setName('')
    setShowGreeting(false)
  }

  return (
    <View className="flex-1 bg-gradient-to-br from-purple-500 to-pink-500 justify-center px-8">
      <View className="bg-white rounded-3xl p-8 shadow-2xl">
        <Text className="text-3xl font-bold text-gray-900 mb-2">¡Hola! 👋</Text>
        <Text className="text-gray-600 mb-6">¿Cómo te llamas?</Text>

        {/* Input */}
        <TextInput
          value={name}
          onChangeText={setName}
          placeholder="Escribe tu nombre..."
          className="border-2 border-gray-300 rounded-xl px-4 py-3 text-lg mb-4"
        />

        {/* Vista previa del texto */}
        <Text className="text-sm text-gray-500 mb-4">
          Escribiste: <Text className="font-bold">{name || '(vacío)'}</Text>
        </Text>

        {/* Botones */}
        <View className="flex-row gap-3">
          <TouchableOpacity
            onPress={handleSubmit}
            disabled={name.trim().length === 0}
            className={`flex-1 py-4 rounded-xl ${
              name.trim().length > 0 ? 'bg-purple-600' : 'bg-gray-300'
            }`}
          >
            <Text className="text-white text-center font-bold text-lg">
              Saludar
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            onPress={handleReset}
            className="flex-1 py-4 rounded-xl bg-gray-200"
          >
            <Text className="text-gray-900 text-center font-bold text-lg">
              Limpiar
            </Text>
          </TouchableOpacity>
        </View>

        {/* Saludo (solo si showGreeting es true) */}
        {showGreeting && (
          <View className="mt-6 bg-purple-100 p-4 rounded-xl">
            <Text className="text-xl text-purple-900 text-center font-bold">
              ¡Hola, {name}! 🎉
            </Text>
          </View>
        )}
      </View>
    </View>
  )
}
```

### 🎯 Conceptos Nuevos:

1. **Input Controlado:**

   ```tsx
   value = { name } // ← Estado controla el valor
   onChangeText = { setName } // ← Actualiza el estado al escribir
   ```

2. **Renderizado Condicional:**

   ```tsx
   {
     showGreeting && <Text>Saludo</Text>
   } // Solo si es true
   ```

3. **Estilos Condicionales:**

   ```tsx
   className={`${name.length > 0 ? 'bg-blue-500' : 'bg-gray-300'}`}
   ```

4. **Disabled:**
   ```tsx
   disabled={name.trim().length === 0}  // Deshabilitar si está vacío
   ```

---

## 📝 EJERCICIO 3: TODO List (45 min)

### Objetivo: Aplicación completa de tareas

**¡TODOS JUNTOS!** Esta es la app más completa que haremos hoy:

```tsx
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  Alert,
} from 'react-native'
import { useState } from 'react'

// Definir tipo de tarea
interface Todo {
  id: number
  text: string
  completed: boolean
}

export default function App() {
  // Estados
  const [todos, setTodos] = useState<Todo[]>([])
  const [inputText, setInputText] = useState('')
  const [nextId, setNextId] = useState(1)

  // Agregar tarea
  const addTodo = () => {
    if (inputText.trim().length === 0) {
      Alert.alert('Error', 'Ingresa una tarea')
      return
    }

    const newTodo: Todo = {
      id: nextId,
      text: inputText.trim(),
      completed: false,
    }

    setTodos([...todos, newTodo]) // Agregar al array
    setNextId(nextId + 1) // Incrementar ID
    setInputText('') // Limpiar input
  }

  // Marcar como completada
  const toggleTodo = (id: number) => {
    setTodos(
      todos.map((todo) =>
        todo.id === id ? { ...todo, completed: !todo.completed } : todo
      )
    )
  }

  // Eliminar tarea
  const deleteTodo = (id: number) => {
    Alert.alert('Confirmar', '¿Eliminar esta tarea?', [
      { text: 'Cancelar', style: 'cancel' },
      {
        text: 'Eliminar',
        style: 'destructive',
        onPress: () => {
          setTodos(todos.filter((todo) => todo.id !== id))
        },
      },
    ])
  }

  // Calcular estadísticas
  const totalTodos = todos.length
  const completedTodos = todos.filter((t) => t.completed).length
  const pendingTodos = totalTodos - completedTodos

  return (
    <View className="flex-1 bg-gray-50">
      {/* Header */}
      <View className="bg-blue-600 pt-14 pb-6 px-5">
        <Text className="text-white text-3xl font-bold mb-3">
          Mis Tareas 📝
        </Text>
        <View className="flex-row gap-4">
          <Text className="text-blue-100">Total: {totalTodos}</Text>
          <Text className="text-blue-100">Pendientes: {pendingTodos}</Text>
          <Text className="text-blue-100">Completadas: {completedTodos}</Text>
        </View>
      </View>

      {/* Input para nueva tarea */}
      <View className="flex-row p-4 bg-white border-b border-gray-200">
        <TextInput
          value={inputText}
          onChangeText={setInputText}
          onSubmitEditing={addTodo}
          placeholder="Nueva tarea..."
          className="flex-1 border border-gray-300 rounded-lg px-4 py-3 mr-2"
        />
        <TouchableOpacity
          onPress={addTodo}
          className="bg-blue-600 w-14 h-14 rounded-lg items-center justify-center"
        >
          <Text className="text-white font-bold text-2xl">+</Text>
        </TouchableOpacity>
      </View>

      {/* Lista de tareas */}
      <ScrollView className="flex-1">
        {todos.length === 0 ? (
          <View className="items-center justify-center py-20">
            <Text className="text-6xl mb-4">📋</Text>
            <Text className="text-xl text-gray-500">No hay tareas</Text>
            <Text className="text-sm text-gray-400 mt-2">
              Agrega una tarea para comenzar
            </Text>
          </View>
        ) : (
          <View className="p-4">
            {todos.map((todo) => (
              <View
                key={todo.id}
                className="flex-row items-center bg-white p-4 mb-3 rounded-xl shadow-sm"
              >
                {/* Checkbox */}
                <TouchableOpacity
                  onPress={() => toggleTodo(todo.id)}
                  className={`w-6 h-6 rounded border-2 mr-3 items-center justify-center ${
                    todo.completed
                      ? 'bg-green-500 border-green-500'
                      : 'border-gray-400'
                  }`}
                >
                  {todo.completed && (
                    <Text className="text-white font-bold text-sm">✓</Text>
                  )}
                </TouchableOpacity>

                {/* Texto de la tarea */}
                <Text
                  className={`flex-1 text-lg ${
                    todo.completed
                      ? 'text-gray-400 line-through'
                      : 'text-gray-900'
                  }`}
                >
                  {todo.text}
                </Text>

                {/* Botón eliminar */}
                <TouchableOpacity
                  onPress={() => deleteTodo(todo.id)}
                  className="bg-red-500 w-10 h-10 rounded-lg items-center justify-center ml-2"
                >
                  <Text className="text-white font-bold text-lg">×</Text>
                </TouchableOpacity>
              </View>
            ))}
          </View>
        )}
      </ScrollView>
    </View>
  )
}
```

### 🎯 Conceptos Avanzados Aplicados:

1. **Arrays en el estado:**

   ```tsx
   const [todos, setTodos] = useState<Todo[]>([])
   ```

2. **Agregar al array:**

   ```tsx
   setTodos([...todos, newItem]) // Spread operator
   ```

3. **Actualizar elemento específico:**

   ```tsx
   setTodos(
     todos.map(
       (todo) =>
         todo.id === targetId
           ? { ...todo, completed: !todo.completed } // Actualizar este
           : todo // Dejar los demás
     )
   )
   ```

4. **Eliminar del array:**

   ```tsx
   setTodos(todos.filter((todo) => todo.id !== targetId))
   ```

5. **Interface TypeScript:**
   ```tsx
   interface Todo {
     id: number
     text: string
     completed: boolean
   }
   ```

---

## 🔄 Introducción a useEffect (10 min)

### ¿Qué es useEffect?

`useEffect` se usa para **efectos secundarios** (side effects):

- Llamar APIs
- Timers/Intervals
- Suscripciones
- Logging

**Ejemplo simple:**

```tsx
import { useEffect } from 'react'

export default function App() {
  const [count, setCount] = useState(0)

  // Se ejecuta cada vez que count cambia
  useEffect(() => {
    console.log('El count cambió a:', count)
  }, [count]) // ← Dependencia

  // Se ejecuta solo una vez al montar
  useEffect(() => {
    console.log('Componente montado')
  }, []) // ← Array vacío

  return (
    <View>
      <Text>{count}</Text>
      <TouchableOpacity onPress={() => setCount(count + 1)}>
        <Text>Incrementar</Text>
      </TouchableOpacity>
    </View>
  )
}
```

**Veremos más de useEffect en la Semana 2.**

---

## ⚡ Mejores Prácticas

### 1. Nomenclatura

```tsx
// ✅ BIEN: Nombres descriptivos
const [isLoading, setIsLoading] = useState(false)
const [userData, setUserData] = useState(null)
const [errorMessage, setErrorMessage] = useState('')

// ❌ MAL: Nombres genéricos
const [data, setData] = useState(null)
const [flag, setFlag] = useState(false)
```

### 2. Actualizar Estado

```tsx
// ✅ BIEN: Usar función updater cuando dependes del valor anterior
setCount((prevCount) => prevCount + 1)

// ⚠️ FUNCIONA pero menos confiable en actualizaciones rápidas
setCount(count + 1)

// ❌ MAL: Mutar directamente
count = count + 1 // NO HACE NADA
```

### 3. Estados Múltiples

```tsx
// Para formularios complejos, usar objeto:
const [formData, setFormData] = useState({
  name: '',
  email: '',
  age: '',
})

// Actualizar un campo:
setFormData({ ...formData, name: 'Juan' })
```

---

## ✅ Checklist de Verificación

Al finalizar esta sesión presencial deberías poder:

- [ ] Usar `useState` para crear estado local
- [ ] Actualizar estado con la función `set...`
- [ ] Manejar eventos `onPress` en TouchableOpacity
- [ ] Crear inputs controlados con `TextInput`
- [ ] Renderizar contenido condicionalmente
- [ ] Aplicar estilos condicionales
- [ ] Trabajar con arrays en el estado
- [ ] Entender conceptos básicos de `useEffect`

---

## 📚 Trabajo Autónomo (45 minutos recomendados)

### Para practicar:

1. **Mejora el TODO List:**

   - Agrega categorías (Personal, Trabajo, Urgente)
   - Implementa filtros (Todas, Pendientes, Completadas)
   - Agrega fechas de vencimiento

2. **Crea un Conversor de Monedas:**

   - Input para monto
   - Selector de monedas (USD, EUR, MXN)
   - Botón para convertir
   - Mostrar resultado

3. **Revisa documentación:**
   - [useState Hook](https://react.dev/reference/react/useState)
   - [useEffect Hook](https://react.dev/reference/react/useEffect)
   - [Handling Events](https://reactnative.dev/docs/handling-touches)

---

## 🎉 ¡Felicitaciones!

Has completado toda la teoría de la Semana 1. Ahora sabes:

- ✅ Qué es React Native y cuándo usarlo
- ✅ Configurar un entorno de desarrollo
- ✅ Usar los componentes básicos
- ✅ Aplicar estilos con TailwindCSS
- ✅ Crear layouts con Flexbox
- ✅ Manejar estado con useState
- ✅ Responder a eventos del usuario
- ✅ Crear formularios funcionales

**Siguiente paso:** Aplicar todo esto en las prácticas guiadas y el proyecto integrador.

---

## 🔗 Navegación

- ⬅️ [Anterior: Setup y Componentes](./02-setup-y-componentes-basicos.md)
- ➡️ [Siguiente: Prácticas Guiadas](../2-practicas/README.md)
- 🏠 [Inicio Semana 1](../README.md)

---

**Tiempo presencial:** 1.5 horas ✓  
**Tiempo autónomo recomendado:** ~45 minutos  
**Total teoría presencial Semana 1:** ~4.5 horas
