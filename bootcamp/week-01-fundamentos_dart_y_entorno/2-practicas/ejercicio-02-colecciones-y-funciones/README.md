# Ejercicio 02 — Colecciones y Funciones

> Practicarás `List`/`Set`/`Map`, operadores de colección y funciones con parámetros
> nombrados descomentando código paso a paso.

## 🎯 Objetivos

- Crear y transformar `List`, `Set` y `Map`
- Usar `map`, `where` y `fold`
- Declarar funciones con parámetros nombrados y `required`

## 📋 Requisitos

- Ejercicio 01 completado

## 🚀 Cómo ejecutar

```bash
cd starter
dart run main.dart
```

---

## Paso 1: List y métodos funcionales

```dart
final prices = [10, 25, 8, 40];
final expensive = prices.where((p) => p > 15).toList();
final total = prices.fold<int>(0, (sum, p) => sum + p);
```

**Abre `starter/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: debe imprimir `[25, 40]` y `83`.

---

## Paso 2: Set — sin duplicados

```dart
final tags = <String>{'dart', 'flutter', 'dart'};
```

**Descomenta la sección `PASO 2`.**

✅ **Verifica**: el `Set` impreso debe tener 2 elementos, no 3 (sin duplicar `'dart'`).

---

## Paso 3: Map y operadores de colección

```dart
final stock = <String, int>{'manzana': 50, 'pera': 30};
final extended = {...stock, 'mango': 10};
```

**Descomenta la sección `PASO 3`.**

✅ **Verifica**: `extended` debe tener 3 entradas, incluyendo `mango: 10`.

---

## Paso 4: Función con parámetros nombrados

```dart
String greet({required String name, String greeting = 'Hola'}) {
  return '$greeting, $name';
}
```

**Descomenta la sección `PASO 4`.**

✅ **Verifica**: debe imprimir `Hola, Ada` y `Bienvenida, Grace`.

---

## ✅ Resultado final

`dart run main.dart` debe imprimir 6 líneas: resultado de `where`+`fold`, el `Set` sin
duplicados, el `Map` extendido y los dos saludos generados por la función.
