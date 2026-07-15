# POO: Clases, Mixins y Extension Methods

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo declarar clases, constructores y herencia en Dart
- Qué es un mixin y cuándo usarlo en vez de herencia
- Qué son los extension methods

## 📋 Conceptos Clave

### 1. Clases y constructores

```dart
class Product {
  final String name;
  final double price;

  // Constructor con parámetros nombrados (patrón estándar en Dart/Flutter)
  const Product({required this.name, required this.price});

  // Constructor con nombre (named constructor)
  const Product.free(String name) : this.name = name, price = 0;

  double get priceWithTax => price * 1.19; // getter
}

final book = Product(name: 'Clean Code', price: 45.0);
final sample = Product.free('Muestra gratis');
```

> 💡 **Por qué `const` en el constructor**: si todos los campos son `final` y sus valores son
> conocidos en compilación, un constructor `const` permite que Flutter reutilice la misma
> instancia entre rebuilds — la optimización de performance más simple que existe (semana 16).

### 2. Herencia

```dart
class Animal {
  final String name;
  const Animal(this.name);

  String makeSound() => '...';
}

class Dog extends Animal {
  const Dog(super.name);

  @override
  String makeSound() => 'Guau';
}
```

Dart tiene **herencia simple** (una sola superclase), igual que la mayoría de lenguajes OOP.
Para compartir comportamiento entre clases sin relación de herencia, se usan **mixins**.

### 3. Mixins

```dart
// Un mixin es comportamiento reutilizable que se "mezcla" en una clase,
// sin que exista una relación "es un" (herencia) entre ellas.
mixin Identifiable {
  String get id;

  String get shortId => id.substring(0, 6);
}

mixin Timestamped {
  DateTime get createdAt;

  bool get isRecent => DateTime.now().difference(createdAt).inDays < 7;
}

// Una clase puede usar varios mixins con `with`
class Order with Identifiable, Timestamped {
  @override
  final String id;
  @override
  final DateTime createdAt;

  Order({required this.id, required this.createdAt});
}
```

> 💡 **Mixin vs herencia**: usa herencia cuando hay una relación real "es un" (`Dog` **es un**
> `Animal`). Usa mixins cuando quieres compartir código entre clases que no tienen relación
> jerárquica (`Order` y `User` pueden compartir `Identifiable` sin ser parientes).

### 4. Extension methods

```dart
// Agrega métodos a una clase que ya existe (incluso del SDK), sin heredar de ella
extension StringCasing on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

print('bogotá'.capitalize()); // 'Bogotá'
```

Los extension methods son útiles para añadir utilidades a tipos como `String`, `DateTime` o
`List` sin crear una subclase ni una función suelta desconectada del tipo.

## ⚠️ Errores Comunes

- Intentar heredar de dos clases a la vez (Dart no lo permite — usa mixins).
- Crear un mixin con estado mutable compartido entre clases no relacionadas, generando
  acoplamiento oculto difícil de rastrear.
- Abusar de extension methods para lógica de negocio compleja que merece ser una clase propia.

## 📚 Recursos Adicionales

- [Dart — Classes](https://dart.dev/language/classes)
- [Dart — Mixins](https://dart.dev/language/mixins)
- [Dart — Extension methods](https://dart.dev/language/extension-methods)

## ✅ Checklist de Verificación

- [ ] Puedo declarar una clase con constructor `const` y parámetros nombrados
- [ ] Entiendo cuándo usar herencia y cuándo usar mixins
- [ ] Puedo escribir un extension method simple
