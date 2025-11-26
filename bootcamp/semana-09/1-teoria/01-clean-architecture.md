# 🏗️ Módulo 1: Clean Architecture en Flutter

## 📋 Contenido

1. [Introducción](#-introducción)
2. [Principios SOLID](#-principios-solid)
3. [Capas de Clean Architecture](#-capas-de-clean-architecture)
4. [Domain Layer](#-domain-layer)
5. [Data Layer](#-data-layer)
6. [Presentation Layer](#-presentation-layer)
7. [Inyección de Dependencias](#-inyección-de-dependencias)
8. [Estructura de Proyecto](#-estructura-de-proyecto)

---

## 🎯 Objetivos

- Comprender los principios de Clean Architecture
- Aplicar SOLID en proyectos Flutter
- Separar responsabilidades en capas
- Implementar el patrón Repository
- Crear Use Cases reutilizables

---

## 📖 Introducción

### ¿Qué es Clean Architecture?

**Clean Architecture** es un patrón de arquitectura de software propuesto por Robert C. Martin (Uncle Bob) que organiza el código en capas concéntricas con dependencias que apuntan hacia el centro.

```
┌─────────────────────────────────────────────────────────────┐
│                    External Interfaces                       │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                  Presentation Layer                  │    │
│  │  ┌─────────────────────────────────────────────┐    │    │
│  │  │              Domain Layer                    │    │    │
│  │  │  ┌─────────────────────────────────────┐    │    │    │
│  │  │  │           Entities                   │    │    │    │
│  │  │  └─────────────────────────────────────┘    │    │    │
│  │  └─────────────────────────────────────────────┘    │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                        Data Layer
```

### Beneficios

| Beneficio          | Descripción                                |
| ------------------ | ------------------------------------------ |
| **Testabilidad**   | Cada capa puede testearse de forma aislada |
| **Mantenibilidad** | Cambios en una capa no afectan a otras     |
| **Escalabilidad**  | Fácil agregar nuevas features              |
| **Independencia**  | UI, DB y frameworks son detalles externos  |

### Regla de Dependencia

> **Las dependencias solo pueden apuntar hacia adentro.**
>
> Las capas internas no conocen nada de las capas externas.

```
Presentation → Domain ← Data
         ↘      ↓      ↙
           Entities
```

---

## 🔧 Principios SOLID

### S - Single Responsibility

> Una clase debe tener una sola razón para cambiar.

```dart
// ❌ Incorrecto: Múltiples responsabilidades
class UserManager {
  void createUser(User user) { /* crear en DB */ }
  void sendWelcomeEmail(User user) { /* enviar email */ }
  void logUserActivity(User user) { /* logging */ }
  String formatUserName(User user) { /* formatear */ }
}

// ✅ Correcto: Responsabilidades separadas
class UserRepository {
  Future<void> create(User user) { /* solo persistencia */ }
}

class EmailService {
  Future<void> sendWelcome(User user) { /* solo emails */ }
}

class UserLogger {
  void logActivity(User user) { /* solo logging */ }
}
```

### O - Open/Closed

> Abierto para extensión, cerrado para modificación.

```dart
// ❌ Incorrecto: Modificar para cada nuevo tipo
class NotificationSender {
  void send(String type, String message) {
    if (type == 'email') {
      // enviar email
    } else if (type == 'sms') {
      // enviar sms
    } else if (type == 'push') {
      // enviar push - hay que modificar la clase
    }
  }
}

// ✅ Correcto: Extensible sin modificación
abstract class NotificationChannel {
  Future<void> send(String message);
}

class EmailChannel implements NotificationChannel {
  @override
  Future<void> send(String message) async { /* email */ }
}

class SmsChannel implements NotificationChannel {
  @override
  Future<void> send(String message) async { /* sms */ }
}

// Nuevo canal sin modificar código existente
class PushChannel implements NotificationChannel {
  @override
  Future<void> send(String message) async { /* push */ }
}
```

### L - Liskov Substitution

> Las subclases deben poder sustituir a sus clases base.

```dart
// ❌ Incorrecto: Viola el contrato de la clase base
class Bird {
  void fly() { print('Flying'); }
}

class Penguin extends Bird {
  @override
  void fly() {
    throw Exception('Penguins cannot fly!'); // Viola LSP
  }
}

// ✅ Correcto: Jerarquía apropiada
abstract class Bird {
  void move();
}

class FlyingBird extends Bird {
  @override
  void move() { print('Flying'); }
}

class SwimmingBird extends Bird {
  @override
  void move() { print('Swimming'); }
}
```

### I - Interface Segregation

> Muchas interfaces específicas son mejores que una general.

```dart
// ❌ Incorrecto: Interface demasiado grande
abstract class Worker {
  void work();
  void eat();
  void sleep();
  void attendMeeting();
  void writeReport();
}

// ✅ Correcto: Interfaces segregadas
abstract class Workable {
  void work();
}

abstract class Feedable {
  void eat();
}

abstract class Meetable {
  void attendMeeting();
}

class Developer implements Workable, Feedable, Meetable {
  @override
  void work() { /* coding */ }

  @override
  void eat() { /* lunch */ }

  @override
  void attendMeeting() { /* standup */ }
}
```

### D - Dependency Inversion

> Depender de abstracciones, no de implementaciones.

```dart
// ❌ Incorrecto: Dependencia de implementación concreta
class UserService {
  final MySqlDatabase database = MySqlDatabase(); // Acoplado

  Future<User> getUser(int id) {
    return database.query('SELECT * FROM users WHERE id = $id');
  }
}

// ✅ Correcto: Dependencia de abstracción
abstract class Database {
  Future<Map<String, dynamic>> query(String sql);
}

class UserService {
  final Database database; // Abstracción inyectada

  UserService(this.database);

  Future<User> getUser(int id) {
    return database.query('SELECT * FROM users WHERE id = $id');
  }
}

// Ahora podemos usar cualquier implementación
class MySqlDatabase implements Database { ... }
class PostgresDatabase implements Database { ... }
class InMemoryDatabase implements Database { ... } // Para tests
```

---

## 📦 Capas de Clean Architecture

### Vista General

```
┌──────────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │
│  │   Widgets   │  │   Pages     │  │  State Management   │   │
│  │             │  │   Screens   │  │  (BLoC/Provider)    │   │
│  └─────────────┘  └─────────────┘  └─────────────────────┘   │
├──────────────────────────────────────────────────────────────┤
│                      DOMAIN LAYER                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │
│  │  Entities   │  │  Use Cases  │  │ Repository Interface│   │
│  │             │  │             │  │    (Contracts)      │   │
│  └─────────────┘  └─────────────┘  └─────────────────────┘   │
├──────────────────────────────────────────────────────────────┤
│                       DATA LAYER                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │
│  │   Models    │  │ Data Sources│  │ Repository Impl     │   │
│  │ (fromJson)  │  │ Remote/Local│  │                     │   │
│  └─────────────┘  └─────────────┘  └─────────────────────┘   │
└──────────────────────────────────────────────────────────────┘
```

### Responsabilidades

| Capa             | Responsabilidad        | Ejemplos                |
| ---------------- | ---------------------- | ----------------------- |
| **Presentation** | UI y gestión de estado | Widgets, BLoC, Provider |
| **Domain**       | Lógica de negocio      | Entities, Use Cases     |
| **Data**         | Acceso a datos         | APIs, Database, Cache   |

---

## 🎯 Domain Layer

La capa más interna y estable. No depende de nada externo.

### Entities

Objetos de negocio puros, sin lógica de serialización.

```dart
/// lib/features/user/domain/entities/user.dart
///
/// Entidad de dominio User.
///
/// ¿Qué hace?
/// Representa un usuario en el dominio de la aplicación.
///
/// ¿Para qué?
/// Define la estructura de datos de usuario sin dependencias externas.
///
/// ¿Cómo funciona?
/// Es una clase inmutable con propiedades que definen un usuario.
/// Usa Equatable para comparación por valor.

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  /// Equatable compara por valor, no por referencia
  @override
  List<Object?> get props => [id, name, email, createdAt];

  /// Método para crear una copia con cambios
  User copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
```

### Repository Interface (Contract)

Define el contrato que la capa Data debe implementar.

```dart
/// lib/features/user/domain/repositories/user_repository.dart
///
/// Contrato del repositorio de usuarios.
///
/// ¿Qué hace?
/// Define las operaciones disponibles para usuarios.
///
/// ¿Para qué?
/// Permite que Domain no dependa de implementaciones concretas.
///
/// ¿Cómo funciona?
/// Es una clase abstracta que Data Layer implementa.
/// Usa Either para manejo funcional de errores.

import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';

abstract class UserRepository {
  /// Obtiene todos los usuarios
  Future<Either<Failure, List<User>>> getUsers();

  /// Obtiene un usuario por ID
  Future<Either<Failure, User>> getUser(int id);

  /// Crea un nuevo usuario
  Future<Either<Failure, User>> createUser(User user);

  /// Actualiza un usuario existente
  Future<Either<Failure, User>> updateUser(User user);

  /// Elimina un usuario
  Future<Either<Failure, void>> deleteUser(int id);
}
```

### Use Cases

Encapsulan una operación de negocio específica.

```dart
/// lib/features/user/domain/usecases/get_user.dart
///
/// Caso de uso: Obtener un usuario por ID.
///
/// ¿Qué hace?
/// Encapsula la lógica para obtener un usuario específico.
///
/// ¿Para qué?
/// Mantiene la lógica de negocio separada de UI y datos.
/// Facilita testing y reutilización.
///
/// ¿Cómo funciona?
/// 1. Recibe el ID del usuario
/// 2. Llama al repositorio
/// 3. Retorna Either con el resultado o error

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUser implements UseCase<User, int> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(int userId) async {
    return await repository.getUser(userId);
  }
}
```

### Base UseCase

```dart
/// lib/core/usecases/usecase.dart
///
/// Interfaz base para todos los casos de uso.

import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Para casos de uso sin parámetros
class NoParams {}
```

### Failures

```dart
/// lib/core/error/failures.dart
///
/// Clases de error de dominio.

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Error del servidor']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Error de caché']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Sin conexión a internet']) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}
```

---

## 💾 Data Layer

Implementa los contratos de Domain y maneja datos externos.

### Models

Extienden las entidades añadiendo serialización.

```dart
/// lib/features/user/data/models/user_model.dart
///
/// Modelo de datos para User.
///
/// ¿Qué hace?
/// Extiende User añadiendo serialización JSON.
///
/// ¿Para qué?
/// Convertir datos de/hacia APIs y bases de datos.
///
/// ¿Cómo funciona?
/// Hereda de User y añade fromJson/toJson.

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String name,
    required String email,
    required DateTime createdAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          createdAt: createdAt,
        );

  /// Factory desde JSON (API response)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Convertir a JSON (para enviar a API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Crear desde Entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      createdAt: user.createdAt,
    );
  }
}
```

### Data Sources

Abstraen el acceso a datos específicos.

```dart
/// lib/features/user/data/datasources/user_remote_datasource.dart
///
/// Fuente de datos remota para usuarios.

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUser(int id);
  Future<UserModel> createUser(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  UserRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to load users');
    }
  }

  @override
  Future<UserModel> getUser(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw NotFoundException('User not found');
    } else {
      throw ServerException('Failed to load user');
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await client.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to create user');
    }
  }
}
```

```dart
/// lib/features/user/data/datasources/user_local_datasource.dart
///
/// Fuente de datos local (caché).

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> users);
  Future<UserModel?> getCachedUser(int id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const cachedUsersKey = 'CACHED_USERS';

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UserModel>> getCachedUsers() async {
    final jsonString = sharedPreferences.getString(cachedUsersKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw CacheException('No cached users found');
    }
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    final jsonList = users.map((user) => user.toJson()).toList();
    await sharedPreferences.setString(
      cachedUsersKey,
      json.encode(jsonList),
    );
  }

  @override
  Future<UserModel?> getCachedUser(int id) async {
    try {
      final users = await getCachedUsers();
      return users.firstWhere((user) => user.id == id);
    } catch (_) {
      return null;
    }
  }
}
```

### Repository Implementation

Implementa el contrato de Domain.

```dart
/// lib/features/user/data/repositories/user_repository_impl.dart
///
/// Implementación del repositorio de usuarios.
///
/// ¿Qué hace?
/// Implementa UserRepository coordinando data sources.
///
/// ¿Para qué?
/// Manejar caché, conectividad y transformación de datos.
///
/// ¿Cómo funciona?
/// 1. Verifica conectividad
/// 2. Intenta obtener datos remotos
/// 3. Cachea resultados
/// 4. Usa caché como fallback

import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUsers = await remoteDataSource.getUsers();
        await localDataSource.cacheUsers(remoteUsers);
        return Right(remoteUsers);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final localUsers = await localDataSource.getCachedUsers();
        return Right(localUsers);
      } on CacheException {
        return const Left(CacheFailure('No hay datos en caché'));
      }
    }
  }

  @override
  Future<Either<Failure, User>> getUser(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getUser(id);
        return Right(remoteUser);
      } on NotFoundException {
        return const Left(ServerFailure('Usuario no encontrado'));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      final cachedUser = await localDataSource.getCachedUser(id);
      if (cachedUser != null) {
        return Right(cachedUser);
      }
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> createUser(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = UserModel.fromEntity(user);
        final createdUser = await remoteDataSource.createUser(userModel);
        return Right(createdUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    // Implementar similar a createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteUser(int id) async {
    // Implementar
    throw UnimplementedError();
  }
}
```

---

## 🖥️ Presentation Layer

UI y gestión de estado.

### BLoC con Clean Architecture

```dart
/// lib/features/user/presentation/bloc/user_bloc.dart
///
/// BLoC para gestión de usuarios.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/get_user.dart';

// Events
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class LoadUser extends UserEvent {
  final int userId;
  LoadUser(this.userId);

  @override
  List<Object?> get props => [userId];
}

// States
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;
  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  final GetUser getUser;

  UserBloc({
    required this.getUsers,
    required this.getUser,
  }) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<LoadUser>(_onLoadUser);
  }

  Future<void> _onLoadUsers(
    LoadUsers event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await getUsers(NoParams());

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (users) => emit(UsersLoaded(users)),
    );
  }

  Future<void> _onLoadUser(
    LoadUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await getUser(event.userId);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserLoaded(user)),
    );
  }
}
```

### Página con BLoC

```dart
/// lib/features/user/presentation/pages/users_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../widgets/user_card.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            // Cargar usuarios al inicio
            context.read<UserBloc>().add(LoadUsers());
            return const SizedBox.shrink();
          }

          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(LoadUsers());
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (state is UsersLoaded) {
            if (state.users.isEmpty) {
              return const Center(
                child: Text('No hay usuarios'),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(LoadUsers());
              },
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return UserCard(user: state.users[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
```

---

## 💉 Inyección de Dependencias

### Con Get It

```dart
/// lib/injection_container.dart
///
/// Configuración de inyección de dependencias.

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - User
  // BLoC
  sl.registerFactory(
    () => UserBloc(
      getUsers: sl(),
      getUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: sl(),
      baseUrl: 'https://api.example.com',
    ),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
```

### Uso en main.dart

```dart
/// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Demo',
      home: BlocProvider(
        create: (_) => di.sl<UserBloc>(),
        child: const UsersPage(),
      ),
    );
  }
}
```

---

## 📁 Estructura de Proyecto

### Estructura Completa

```
lib/
├── core/
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   └── network_info.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── utils/
│       └── input_converter.dart
├── features/
│   ├── user/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── user_local_datasource.dart
│   │   │   │   └── user_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── user_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   ├── repositories/
│   │   │   │   └── user_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_user.dart
│   │   │       └── get_users.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── user_bloc.dart
│   │       ├── pages/
│   │       │   └── users_page.dart
│   │       └── widgets/
│   │           └── user_card.dart
│   └── auth/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── injection_container.dart
└── main.dart
```

---

## ✅ Resumen

| Capa             | Contiene                                   | Depende de |
| ---------------- | ------------------------------------------ | ---------- |
| **Presentation** | Widgets, BLoC, Pages                       | Domain     |
| **Domain**       | Entities, Use Cases, Repository Interfaces | Nada       |
| **Data**         | Models, Data Sources, Repository Impl      | Domain     |

### Flujo de Datos

```
UI → BLoC → UseCase → Repository(Interface) → Repository(Impl) → DataSource → API/DB
                              ↑                       ↓
                         Domain Layer             Data Layer
```

---

## 📖 Recursos

- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Reso Coder - Flutter TDD Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Flutter Documentation](https://docs.flutter.dev)

---

> **Duración estimada:** 2 horas
