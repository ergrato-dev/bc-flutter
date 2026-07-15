# Ejercicio 01 — Variables, Tipos y Null Safety

> Practicarás `var`/`final`/`const`, tipos básicos y los operadores de null safety
> descomentando código paso a paso.

## 🎯 Objetivos

- Declarar variables con el modificador correcto según su uso
- Usar `?`, `?.`, `??`, `??=` y `!` con criterio
- Ejecutar y verificar cada paso con `dart run`

## 📋 Requisitos

- Docker corriendo (`docker compose run --rm flutter dart --version`) o SDK local con
  `dart --version` funcionando

## 🚀 Cómo ejecutar

```bash
cd starter
dart run main.dart

# o con Docker desde la raíz del repo:
docker compose run --rm flutter dart run bootcamp/week-01-fundamentos_dart_y_entorno/2-practicas/ejercicio-01-variables-null-safety/starter/main.dart
```

---

## Paso 1: `var`, `final` y `const`

`var` infiere el tipo y permite reasignar; `final` se asigna una vez en runtime; `const` se
asigna una vez en tiempo de compilación.

```dart
var counter = 0;
counter = 1; // válido

final city = 'Bogotá';
// city = 'Medellín'; // ❌ Error: final no se puede reasignar

const pi = 3.1416; // conocido en compilación
```

**Abre `starter/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: la consola debe imprimir `Bogotá` y `3.1416` sin errores.

---

## Paso 2: Tipos nulables y el operador `?.`

```dart
String? nickname;
print(nickname?.length); // null, sin lanzar excepción
```

**Descomenta la sección `PASO 2`.**

✅ **Verifica**: debe imprimir `null` (no un error) en la primera línea.

---

## Paso 3: `??` y `??=`

```dart
final displayName = nickname ?? 'Sin apodo';
nickname ??= 'Anónimo';
```

**Descomenta la sección `PASO 3`.**

✅ **Verifica**: debe imprimir `Sin apodo` y luego `Anónimo`.

---

## Paso 4: El operador `!` (y su riesgo)

```dart
String? maybeNull = 'seguro';
String definitelyNotNull = maybeNull!;
```

**Descomenta la sección `PASO 4`.**

✅ **Verifica**: debe imprimir `seguro` sin lanzar excepción — porque en este caso sabemos que
no es null. Si lo intentaras sobre una variable realmente `null`, Dart lanzaría una excepción
en tiempo de ejecución.

---

## ✅ Resultado final

Al descomentar los 4 pasos, `dart run main.dart` debe imprimir 6 líneas sin ningún error de
compilación ni excepción en runtime.
