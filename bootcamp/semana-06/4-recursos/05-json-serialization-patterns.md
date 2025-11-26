# 📋 Patrones de Serialización JSON

## 🎯 Manual vs Generado

| Aspecto | Manual | json_serializable |
|---------|--------|-------------------|
| Setup | Ninguno | build_runner |
| Boilerplate | Alto | Bajo |
| Tipo-seguro | Manual | Automático |
| Performance | Igual | Igual |
| Proyectos pequeños | ✅ Recomendado | Opcional |
| Proyectos grandes | ❌ Tedioso | ✅ Recomendado |

---

## 📝 Serialización Manual

### Modelo Básico

```dart
class User {
  final int id;
  final String name;
  final String email;
  final DateTime? createdAt;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }
}
```

### Con Objetos Anidados

```dart
class Post {
  final int id;
  final String title;
  final User author;
  final List<Comment> comments;
  
  const Post({
    required this.id,
    required this.title,
    required this.author,
    required this.comments,
  });
  
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author.toJson(),
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
}
```

### Con Enums

```dart
enum UserStatus { active, inactive, banned }

class User {
  final int id;
  final String name;
  final UserStatus status;
  
  const User({required this.id, required this.name, required this.status});
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      status: UserStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => UserStatus.inactive,
      ),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.name,
    };
  }
}
```

---

## 🔧 json_serializable

### Setup

```yaml
# pubspec.yaml
dependencies:
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.8
  json_serializable: ^6.7.1
```

### Modelo Básico

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Comandos de Generación

```bash
# Una vez
dart run build_runner build

# Watch mode (auto-regenera)
dart run build_runner watch

# Limpiar y regenerar
dart run build_runner build --delete-conflicting-outputs
```

### Configuraciones Avanzadas

```dart
@JsonSerializable(
  fieldRename: FieldRename.snake,    // camelCase -> snake_case
  includeIfNull: false,               // No incluir campos null
  explicitToJson: true,               // Llamar toJson en objetos anidados
  createToJson: true,                 // Generar toJson
  createFactory: true,                // Generar fromJson
)
class User {
  final int id;
  final String userName;  // -> user_name en JSON
  
  @JsonKey(ignore: true)  // No serializar
  final String? localCache;
  
  @JsonKey(defaultValue: 0)  // Valor por defecto
  final int points;
  
  @JsonKey(name: 'avatar_url')  // Nombre personalizado
  final String? avatar;
  
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime createdAt;
  
  const User({...});
  
  static DateTime _dateFromJson(String date) => DateTime.parse(date);
  static String _dateToJson(DateTime date) => date.toIso8601String();
}
```

### Con Objetos Anidados

```dart
@JsonSerializable(explicitToJson: true)
class Post {
  final int id;
  final String title;
  final User author;
  final List<Comment> comments;
  
  const Post({...});
  
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
```

### Con Enums

```dart
@JsonEnum(valueField: 'code')
enum UserStatus {
  @JsonValue('A')
  active('A'),
  @JsonValue('I')
  inactive('I'),
  @JsonValue('B')
  banned('B');
  
  final String code;
  const UserStatus(this.code);
}

@JsonSerializable()
class User {
  final int id;
  final UserStatus status;  // Serializa como 'A', 'I', 'B'
  
  const User({required this.id, required this.status});
}
```

---

## 🔄 Freezed (Avanzado)

### Setup

```yaml
dependencies:
  freezed_annotation: ^2.4.1

dev_dependencies:
  build_runner: ^2.4.8
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

### Modelo Inmutable

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    @Default(UserStatus.active) UserStatus status,
    DateTime? createdAt,
  }) = _User;
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// Uso
final user = User(id: 1, name: 'John', email: 'john@example.com');

// Copiar con cambios
final updated = user.copyWith(name: 'John Updated');

// Igualdad automática
print(user == anotherUser);  // Compara valores, no referencias
```

### Union Types

```dart
@freezed
class ApiState<T> with _$ApiState<T> {
  const factory ApiState.initial() = _Initial;
  const factory ApiState.loading() = _Loading;
  const factory ApiState.data(T data) = _Data;
  const factory ApiState.error(String message) = _Error;
}

// Uso con pattern matching
Widget build(BuildContext context) {
  return state.when(
    initial: () => Text('Presiona para cargar'),
    loading: () => CircularProgressIndicator(),
    data: (users) => UserList(users: users),
    error: (message) => ErrorWidget(message: message),
  );
}
```

---

## 📊 Response Wrappers

### Lista Paginada

```dart
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> data;
  final int page;
  final int totalPages;
  final int totalItems;
  
  const PaginatedResponse({
    required this.data,
    required this.page,
    required this.totalPages,
    required this.totalItems,
  });
  
  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;
  
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);
}

// Uso
final response = PaginatedResponse<User>.fromJson(
  jsonData,
  (json) => User.fromJson(json as Map<String, dynamic>),
);
```

### API Response Genérico

```dart
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  
  @JsonKey(name: 'error_code')
  final String? errorCode;
  
  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errorCode,
  });
  
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
```

---

## ✅ Best Practices

```dart
// ✅ Usar const en constructores
const User({required this.id, required this.name});

// ✅ Validar tipos explícitamente
factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,  // ✅ Cast explícito
    name: json['name'] as String,
  );
}

// ✅ Manejar nulls
email: json['email'] as String? ?? '',

// ✅ Manejar listas
items: (json['items'] as List<dynamic>?)
    ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
    .toList() ?? [],

// ✅ Valores por defecto para enums
status: UserStatus.values.firstWhere(
  (e) => e.name == json['status'],
  orElse: () => UserStatus.unknown,
),

// ❌ EVITAR
id: json['id'],  // Sin cast - puede fallar
items: json['items'].map(...),  // Sin cast a List
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
