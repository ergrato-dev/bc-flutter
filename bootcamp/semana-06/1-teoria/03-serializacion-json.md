# 📚 Módulo 03: Serialización JSON

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Comprender la serialización y deserialización de JSON
- ✅ Crear modelos de datos con fromJson y toJson
- ✅ Usar json_serializable para generación automática
- ✅ Manejar casos especiales (nulls, fechas, nested objects)
- ✅ Implementar copyWith para inmutabilidad
- ✅ Validar datos al deserializar

---

## 📖 Contenido Teórico

### 1. ¿Qué es la Serialización?

La **serialización** es el proceso de convertir objetos Dart a JSON (para enviar a una API), y la **deserialización** es el proceso inverso (convertir JSON recibido a objetos Dart).

```
┌─────────────────────────────────────────────────────────────────┐
│                    SERIALIZACIÓN JSON                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│    OBJETO DART                        JSON STRING               │
│    ┌──────────────┐                   ┌──────────────┐          │
│    │ User(        │   ─────────────▶  │ {            │          │
│    │   id: 1,     │   toJson()        │   "id": 1,   │          │
│    │   name: "A"  │   Serialización   │   "name":"A" │          │
│    │ )            │                   │ }            │          │
│    └──────────────┘                   └──────────────┘          │
│                                                                  │
│    ┌──────────────┐                   ┌──────────────┐          │
│    │ User(        │   ◀─────────────  │ {            │          │
│    │   id: 1,     │   fromJson()      │   "id": 1,   │          │
│    │   name: "A"  │   Deserialización │   "name":"A" │          │
│    │ )            │                   │ }            │          │
│    └──────────────┘                   └──────────────┘          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 2. Serialización Manual

#### Modelo Básico

```dart
/**
 * User - Modelo de usuario
 *
 * ¿Qué hace?
 * Representa un usuario de la aplicación
 *
 * ¿Para qué?
 * - Tipar los datos recibidos de la API
 * - Facilitar el autocompletado y validación
 * - Convertir entre JSON y objetos Dart
 */
class User {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  // Constructor
  User({
    required this.id,
    required this.name,
    required this.email,
    this.isActive = true,
  });

  /**
   * fromJson - Deserialización
   *
   * ¿Qué hace?
   * Crea una instancia de User desde un Map (JSON decodificado)
   *
   * ¿Cómo funciona?
   * 1. Recibe un Map<String, dynamic>
   * 2. Extrae cada campo por su key
   * 3. Crea y retorna el objeto User
   */
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  /**
   * toJson - Serialización
   *
   * ¿Qué hace?
   * Convierte el objeto User a un Map para enviar a la API
   *
   * ¿Cómo funciona?
   * 1. Crea un Map con las keys esperadas por la API
   * 2. Asigna los valores del objeto
   * 3. Retorna el Map listo para jsonEncode()
   */
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'is_active': isActive,
    };
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
```

#### Uso del Modelo

```dart
import 'dart:convert';

// Deserialización (JSON → Objeto)
final jsonString = '{"id": 1, "name": "John", "email": "john@email.com"}';
final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
final user = User.fromJson(jsonMap);

print(user.name); // John

// Serialización (Objeto → JSON)
final userMap = user.toJson();
final outputJson = jsonEncode(userMap);

print(outputJson); // {"id":1,"name":"John","email":"john@email.com"}
```

### 3. Manejo de Casos Especiales

#### Campos Nullable

```dart
/**
 * Product - Modelo con campos opcionales
 *
 * ¿Cómo manejar nulls?
 * - Usar tipos nullable (String?)
 * - Proporcionar valores por defecto
 * - Validar antes de usar
 */
class Product {
  final int id;
  final String name;
  final double price;
  final String? description;  // Nullable
  final String? imageUrl;     // Nullable
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.imageUrl,
    this.stock = 0,  // Valor por defecto
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),  // num → double
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      stock: json['stock'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      'stock': stock,
    };
  }
}
```

#### Manejo de Fechas

```dart
/**
 * Article - Modelo con fechas
 *
 * ¿Cómo manejar DateTime?
 * La API envía fechas como String ISO 8601
 * Debemos convertir a DateTime para usar en la app
 */
class Article {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      // Parsear String ISO 8601 a DateTime
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      // Convertir DateTime a ISO 8601 String
      'created_at': createdAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}
```

#### Objetos Anidados

```dart
/**
 * Post - Modelo con objetos anidados
 *
 * ¿Cómo manejar nested objects?
 * Llamar al fromJson del objeto hijo
 */
class Author {
  final int id;
  final String name;
  final String avatar;

  Author({required this.id, required this.name, required this.avatar});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
  };
}

class Post {
  final int id;
  final String title;
  final String body;
  final Author author;  // Objeto anidado
  final List<String> tags;  // Lista de strings

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.tags,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      // Deserializar objeto anidado
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      // Deserializar lista
      tags: (json['tags'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'author': author.toJson(),  // Serializar objeto anidado
      'tags': tags,
    };
  }
}
```

#### Lista de Objetos

```dart
/**
 * Order - Modelo con lista de objetos
 */
class OrderItem {
  final int productId;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'product_name': productName,
    'quantity': quantity,
    'price': price,
  };
}

class Order {
  final int id;
  final String status;
  final List<OrderItem> items;  // Lista de objetos
  final double total;

  Order({
    required this.id,
    required this.status,
    required this.items,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      status: json['status'] as String,
      // Deserializar lista de objetos
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      // Serializar lista de objetos
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }
}
```

### 4. Enums y JSON

```dart
/**
 * Manejo de Enums en serialización
 *
 * ¿Cómo manejar enums?
 * - Convertir a/desde String o int
 * - Usar extension methods para conveniencia
 */
enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled;

  // Convertir String a Enum
  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => OrderStatus.pending,
    );
  }

  // Convertir Enum a String
  String toJson() => name;
}

class Order {
  final int id;
  final OrderStatus status;

  Order({required this.id, required this.status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      status: OrderStatus.fromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status.toJson(),
  };
}
```

### 5. CopyWith Pattern

```dart
/**
 * copyWith - Patrón de inmutabilidad
 *
 * ¿Qué hace?
 * Crea una copia del objeto con algunos campos modificados
 *
 * ¿Para qué?
 * - Mantener inmutabilidad
 * - Actualizar objetos sin mutar el original
 * - Muy útil con Provider/BLoC
 */
class User {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.isActive = true,
  });

  // CopyWith - crear copia con cambios
  User copyWith({
    int? id,
    String? name,
    String? email,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    isActive: json['is_active'] as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'is_active': isActive,
  };

  // Equality
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          isActive == other.isActive;

  @override
  int get hashCode => Object.hash(id, name, email, isActive);
}

// Uso de copyWith
final user = User(id: 1, name: 'John', email: 'john@email.com');
final updatedUser = user.copyWith(name: 'John Doe');

print(user.name);        // John
print(updatedUser.name); // John Doe
print(user == updatedUser); // false (son diferentes objetos)
```

---

## 📦 json_serializable

### 1. Configuración

```yaml
# pubspec.yaml
dependencies:
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.8
  json_serializable: ^6.7.1
```

```bash
flutter pub get
```

### 2. Modelo con json_serializable

```dart
/**
 * User con json_serializable
 *
 * ¿Qué hace?
 * Genera automáticamente fromJson y toJson
 *
 * ¿Por qué usarlo?
 * - Menos código manual
 * - Menos errores
 * - Más mantenible
 */
import 'package:json_annotation/json_annotation.dart';

// Archivo generado (lo crea build_runner)
part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;

  // JsonKey para nombres diferentes en JSON
  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;

  // Campo ignorado en serialización
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? localNote;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.isActive = true,
    this.localNote,
  });

  // Generado por json_serializable
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 3. Generar Código

```bash
# Generar una vez
flutter pub run build_runner build

# Generar y observar cambios (recomendado durante desarrollo)
flutter pub run build_runner watch

# Limpiar y regenerar
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Anotaciones Útiles

```dart
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(
  explicitToJson: true,  // Llamar toJson en objetos anidados
  includeIfNull: false,  // No incluir campos null
)
class Product {
  final int id;

  // Nombre diferente en JSON
  @JsonKey(name: 'product_name')
  final String name;

  // Valor por defecto
  @JsonKey(defaultValue: 0.0)
  final double price;

  // Campo nullable con nombre diferente
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  // Campo computado (solo lectura de JSON)
  @JsonKey(includeToJson: false)
  final DateTime? createdAt;

  // Campo solo para enviar (no viene en respuesta)
  @JsonKey(includeFromJson: false)
  final String? password;

  // Converter personalizado para fechas
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime publishedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.createdAt,
    this.password,
    required this.publishedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // Converters personalizados
  static DateTime _dateFromJson(String date) => DateTime.parse(date);
  static String _dateToJson(DateTime date) => date.toIso8601String();
}
```

### 5. Objetos Anidados con json_serializable

```dart
// author.dart
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  final int id;
  final String name;
  final String avatar;

  Author({required this.id, required this.name, required this.avatar});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

// post.dart
import 'package:json_annotation/json_annotation.dart';
import 'author.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)  // IMPORTANTE para nested
class Post {
  final int id;
  final String title;
  final Author author;  // Objeto anidado
  final List<String> tags;

  Post({
    required this.id,
    required this.title,
    required this.author,
    required this.tags,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
```

### 6. Enums con json_serializable

```dart
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

// Enum automáticamente serializado por nombre
enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('shipped')
  shipped,
  @JsonValue('delivered')
  delivered,
  @JsonValue('cancelled')
  cancelled,
}

@JsonSerializable()
class Order {
  final int id;
  final OrderStatus status;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Order({
    required this.id,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
```

---

## 🛡️ Validación y Seguridad

### Validación al Deserializar

```dart
/**
 * UserWithValidation
 *
 * ¿Por qué validar?
 * - La API puede enviar datos inválidos
 * - Prevenir crashes por datos incorrectos
 * - Detectar problemas temprano
 */
class UserWithValidation {
  final int id;
  final String name;
  final String email;

  UserWithValidation._({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserWithValidation.fromJson(Map<String, dynamic> json) {
    // Validar campos requeridos
    if (!json.containsKey('id')) {
      throw FormatException('Campo "id" requerido');
    }
    if (!json.containsKey('name')) {
      throw FormatException('Campo "name" requerido');
    }
    if (!json.containsKey('email')) {
      throw FormatException('Campo "email" requerido');
    }

    final id = json['id'];
    final name = json['name'];
    final email = json['email'];

    // Validar tipos
    if (id is! int) {
      throw FormatException('Campo "id" debe ser int, recibido: ${id.runtimeType}');
    }
    if (name is! String) {
      throw FormatException('Campo "name" debe ser String');
    }
    if (email is! String) {
      throw FormatException('Campo "email" debe ser String');
    }

    // Validar formato de email
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw FormatException('Email inválido: $email');
    }

    return UserWithValidation._(id: id, name: name, email: email);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
  };
}
```

### Safe Parsing

```dart
/**
 * Funciones de parseo seguro
 *
 * ¿Para qué?
 * Evitar crashes cuando los tipos no coinciden
 */
extension SafeParsing on Map<String, dynamic> {
  int? safeInt(String key) {
    final value = this[key];
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }

  double? safeDouble(String key) {
    final value = this[key];
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  String? safeString(String key) {
    final value = this[key];
    if (value is String) return value;
    if (value != null) return value.toString();
    return null;
  }

  bool safeBool(String key, {bool defaultValue = false}) {
    final value = this[key];
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) return value.toLowerCase() == 'true';
    return defaultValue;
  }

  DateTime? safeDateTime(String key) {
    final value = this[key];
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }
}

// Uso
class SafeUser {
  final int id;
  final String name;
  final String email;

  SafeUser({required this.id, required this.name, required this.email});

  factory SafeUser.fromJson(Map<String, dynamic> json) {
    return SafeUser(
      id: json.safeInt('id') ?? 0,
      name: json.safeString('name') ?? 'Unknown',
      email: json.safeString('email') ?? '',
    );
  }
}
```

---

## 📝 Resumen

| Aspecto      | Manual        | json_serializable     |
| ------------ | ------------- | --------------------- |
| Código       | Más verboso   | Generado              |
| Errores      | Posibles      | Menos                 |
| Flexibilidad | Total         | Con anotaciones       |
| Build time   | Ninguno       | Requiere build        |
| Mejor para   | Apps pequeñas | Apps medianas/grandes |

### Checklist de Modelos

- [ ] Todos los campos tipados correctamente
- [ ] Manejo de nullables
- [ ] Conversión de fechas
- [ ] Objetos anidados deserializados
- [ ] Listas manejadas correctamente
- [ ] Enums con conversión
- [ ] copyWith si se necesita inmutabilidad
- [ ] toString para debugging

---

## 🔗 Recursos

- [json_serializable](https://pub.dev/packages/json_serializable)
- [JSON and Serialization - Flutter](https://docs.flutter.dev/data-and-backend/serialization/json)
- [Dart JSON Cheatsheet](https://dart.dev/guides/json)

---

📅 **Anterior:** [← Módulo 02](./02-http-package-dio.md)
