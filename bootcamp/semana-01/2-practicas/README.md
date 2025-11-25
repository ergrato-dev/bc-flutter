# 💻 Prácticas Guiadas - Semana 1

**⏱️ Tiempo Total:** 2 horas presenciales + 1 hora autónoma  
**👥 Modalidad:** Prácticas con instrucciones paso a paso en clase

---

## 🎯 Objetivo General

Estas prácticas se realizan **EN CLASE** junto con el instructor. No son para trabajo autónomo. El objetivo es aplicar inmediatamente los conceptos teóricos de Dart vistos en la primera parte de la sesión.

---

## 📋 Estructura de las Prácticas

### 🎓 Presenciales (2 horas en clase)

| #   | Práctica                                                                     | Duración | Enfoque                                |
| --- | ---------------------------------------------------------------------------- | -------- | -------------------------------------- |
| 1   | [Mi Primera App en Dart - Calculadora](./practica-01-primera-app.md)         | 45 min   | Variables, operadores, conversiones    |
| 2   | [Colecciones y Listas en Dart](./practica-02-colecciones-listas.md)          | 45 min   | List, Set, Map, métodos de colecciones |
| 3   | [Funciones Avanzadas en Dart (inicio)](./practica-03-funciones-avanzadas.md) | 20 min   | Parámetros, arrow functions            |

**Total presencial:** 1h 50min

### 🏠 Autónomo (1 hora en casa)

- **Completar Práctica 3** (30 min): Funciones de orden superior, callbacks, closures
- **Desafíos adicionales** (30 min): Ejercicios extra de las 3 prácticas

---

## 🎓 Dinámica de Clase

### Reglas Importantes:

1. ✅ **Seguir al instructor paso a paso** - No adelantarse
2. ✅ **Preguntar inmediatamente** si algo no funciona
3. ✅ **Todos al mismo ritmo** - Esperamos a que todos completen cada paso
4. ✅ **Checkpoints frecuentes** - Verificamos que todos vayan bien
5. ❌ **NO trabajar en autónomo durante clase** - Enfocarse en lo guiado

### Estructura de Cada Práctica:

```
1. Explicación (5 min) → Instructor muestra resultado final
2. Setup (5-10 min) → Todos configuran juntos
3. Desarrollo (20-30 min) → Codear paso a paso
4. Review (5 min) → Verificar y resolver dudas
---

## 📝 Prácticas Detalladas

### 1️⃣ Mi Primera App en Dart - Calculadora (45 min)

**📂 Archivo:** [practica-01-primera-app.md](./practica-01-primera-app.md)

**🎯 Objetivo:** Crear programas en Dart usando variables, operadores y conversiones de tipos.

**💡 Conceptos:**

- Variables (`var`, `final`, `const`)
- Tipos de datos primitivos
- Operadores aritméticos y lógicos
- Conversión de tipos (`int.parse`, `double.parse`)
- Interpolación de strings

**✅ Completarás:**

- Calculadora básica de operaciones
- Conversor de temperaturas
- Calculadora de IMC (Índice de Masa Corporal)
- Ejercicios con operadores lógicos

---

### 2️⃣ Colecciones y Listas en Dart (45 min)

**📂 Archivo:** [practica-02-colecciones-listas.md](./practica-02-colecciones-listas.md)

**🎯 Objetivo:** Dominar el manejo de colecciones (List, Set, Map) y sus métodos.

**💡 Conceptos:**

- List: agregar, eliminar, ordenar elementos
- Métodos: `map()`, `where()`, `reduce()`, `fold()`
- Set: elementos únicos, operaciones de conjuntos
- Map: pares clave-valor, iteración
- Tipos genéricos (`List<T>`, `Map<K,V>`)

**✅ Completarás:**

- Lista de estudiantes con operaciones CRUD
- Filtrado y transformación con `map()` y `where()`
- Cálculos estadísticos con `reduce()` y `fold()`
- Gestión de tags únicos con Set
- Sistema de inventario con Map

---

### 3️⃣ Funciones Avanzadas en Dart (20 min presencial + 30 min autónomo)

**📂 Archivo:** [practica-03-funciones-avanzadas.md](./practica-03-funciones-avanzadas.md)

**🎯 Objetivo:**

- **En clase:** Tipos de parámetros y arrow functions
- **En casa:** Funciones de orden superior, callbacks, closures

**💡 Conceptos:**

- Parámetros opcionales posicionales `[]`
- Parámetros nombrados `{}`
- Arrow functions `=>`
- Funciones anónimas
- **En casa:** Funciones de orden superior
- **En casa:** Callbacks
- **En casa:** Closures

**✅ En Clase (20 min):**

- Funciones con parámetros opcionales
- Funciones con parámetros nombrados
- Arrow functions
- Funciones anónimas

**✅ En Casa (30 min):**

- Funciones que reciben funciones
- Callbacks para manejo asíncrono
- Closures y encapsulamiento
- Tareas: `applyDiscount`, `processPayment`, `createBankAccount`

---

## 🏆 Criterios de Evaluación

### Presencial (Participación en clase):

- ✅ Seguir instrucciones del instructor
- ✅ Completar cada ejercicio en DartPad
- ✅ Hacer preguntas cuando sea necesario
- ✅ Ayudar a compañeros si terminan antes
- ✅ Código funcionando al final de cada práctica

### Autónomo (Tarea Práctica 3):

- ✅ Práctica 3 completada con búsqueda funcionando
- ✅ Mínimo 12 contactos en la lista
- ✅ Completar ejercicios de funciones de orden superior
- ✅ Implementar las 3 tareas: `applyDiscount`, `processPayment`, `createBankAccount`
- ✅ Código limpio y comentado
- ✅ Código ejecutándose sin errores en DartPad

---

## 🐛 Problemas Comunes

### Durante las Prácticas:

**❌ Error: "Undefined name..."**

- ✅ Verifica que definiste la clase/variable antes de usarla
- ✅ Revisa mayúsculas/minúsculas (Dart es case-sensitive)

**❌ Error: "The argument type 'X' can't be assigned to 'Y'"**

- ✅ Revisa los tipos de datos en tus variables y funciones
- ✅ Usa conversiones explícitas cuando sea necesario

**❌ Error con null safety**

- ✅ Usa `?` para tipos nullable: `String?`
- ✅ Usa `??` para valores por defecto: `name ?? 'Sin nombre'`

**❌ Lista vacía al usar where() o map()**

- ✅ Recuerda usar `.toList()` al final para convertir Iterable a List
- ✅ Ejemplo: `list.where((x) => x > 5).toList()`

---

## 📱 Requisitos Técnicos

Antes de las prácticas, asegúrate de tener:

- ✅ Dart SDK 3.10+ instalado (verifica con `dart --version`)
- ✅ VS Code con extensión Dart instalada
- ✅ Acceso a [DartPad](https://dartpad.dev) (editor online)
- ✅ Conexión a internet para acceder a documentación

---

## 🎯 Resultados de Aprendizaje

Al completar estas prácticas, serás capaz de:

1. ✅ Trabajar con variables y tipos de datos en Dart
2. ✅ Usar operadores aritméticos, lógicos y de comparación
3. ✅ Convertir entre tipos de datos
4. ✅ Manipular colecciones (List, Set, Map)
5. ✅ Aplicar métodos de transformación (map, where, reduce, fold)
6. ✅ Crear funciones con diferentes tipos de parámetros
7. ✅ Usar arrow functions y funciones anónimas
8. ✅ Implementar funciones de orden superior y closures

---

## 📚 Recursos Adicionales

### Documentación Oficial:

- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Dart Collections](https://dart.dev/guides/libraries/library-tour#collections)
- [Dart Functions](https://dart.dev/guides/language/language-tour#functions)
- [DartPad](https://dartpad.dev)

### Guías Rápidas:

- [Dart Cheat Sheet](https://dart.dev/codelabs/dart-cheatsheet)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Dart API Reference](https://api.dart.dev/stable/)

---

## 🔜 Siguiente Paso

Después de completar estas prácticas y la tarea autónoma, estarás listo para:

**📂 [Proyecto Integrador Semana 1](../3-proyecto/README.md)**

El proyecto integrador combina todos los conceptos de Dart vistos en teoría y prácticas.

---

## ✅ Checklist de Completación

### Al Final de la Sesión Presencial:

- [ ] Práctica 1 completada (Calculadora, conversor, IMC)
- [ ] Práctica 2 completada (5 ejercicios de colecciones)
- [ ] Práctica 3 iniciada (parámetros y arrow functions)
- [ ] Todo el código probado en DartPad
- [ ] Sin errores de compilación

### Para Entregar (Autónomo):

- [ ] Práctica 3 completada (funciones de orden superior)
- [ ] Las 3 tareas implementadas y funcionando
- [ ] Desafío final de biblioteca (opcional)
- [ ] Código limpio y bien documentado
- [ ] Capturas de pantalla de DartPad con resultados

---

**⏭️ Próxima sesión:** Introducción a Flutter - Primera App Móvil

---

_Documentación actualizada: Enero 2025_
_Versión: 1.0.0 (Bootcamp Flutter - Semana 1: Dart)_
```
