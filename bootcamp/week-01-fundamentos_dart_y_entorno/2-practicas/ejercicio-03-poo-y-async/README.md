# Ejercicio 03 — POO y Programación Asíncrona

> Practicarás clases, mixins y `Future`/`async`/`await` descomentando código paso a paso.
> Es el ejercicio más largo de la semana — integra casi todo lo visto hasta ahora.

## 🎯 Objetivos

- Declarar una clase con constructor `const` y parámetros nombrados
- Usar un mixin para compartir comportamiento entre clases
- Simular una llamada async con `Future.delayed` y consumirla con `await`

## 📋 Requisitos

- Ejercicios 01 y 02 completados

## 🚀 Cómo ejecutar

```bash
cd starter
dart run main.dart
```

---

## Paso 1: Clase con constructor nombrado

```dart
class Product {
  final String name;
  final double price;

  const Product({required this.name, required this.price});

  double get priceWithTax => price * 1.19;
}
```

**Abre `starter/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: debe imprimir el nombre del producto y su precio con impuesto.

---

## Paso 2: Mixin compartido

```dart
mixin Identifiable {
  String get id;
  String get shortId => id.substring(0, 6);
}
```

**Descomenta la sección `PASO 2`** (incluye la clase `Order with Identifiable`).

✅ **Verifica**: debe imprimir un `shortId` de 6 caracteres.

---

## Paso 3: Future y async/await

```dart
Future<String> fetchGreeting() {
  return Future.delayed(const Duration(seconds: 1), () => 'Hola desde el servidor');
}
```

**Descomenta la sección `PASO 3`.**

✅ **Verifica**: el mensaje aparece **después** de ~1 segundo de espera (no inmediatamente).

---

## Paso 4: Manejo de errores async

```dart
Future<String> fetchUser(String id) async {
  if (id.isEmpty) throw ArgumentError('id no puede estar vacío');
  return 'Usuario $id';
}
```

**Descomenta la sección `PASO 4`.**

✅ **Verifica**: debe imprimir un mensaje de error capturado por `catch`, no una excepción sin
manejar que detenga el programa.

---

## ✅ Resultado final

`dart run main.dart` debe ejecutar los 4 pasos en orden, con una pausa visible de ~1 segundo
antes del paso 3, y terminar sin excepciones sin capturar.
