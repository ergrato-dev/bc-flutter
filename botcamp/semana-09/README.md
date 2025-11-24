# Semana 9: Arquitectura y Testing

## 🎯 Objetivos de Aprendizaje

- Implementar Clean Architecture en Flutter
- Separar responsabilidades en capas
- Escribir tests unitarios
- Crear tests de widgets
- Aplicar principios SOLID
- Documentar código efectivamente
- Optimizar rendimiento

## 📚 Contenido Teórico

### 1. Clean Architecture (2.5 horas)

#### Capas de la Arquitectura

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│    (UI, Widgets, State Management)  │
├─────────────────────────────────────┤
│          Domain Layer               │
│    (Entities, Use Cases, Repos)     │
├─────────────────────────────────────┤
│           Data Layer                │
│  (Models, Data Sources, Repo Impl)  │
└─────────────────────────────────────┘
```

#### Estructura de Carpetas

```
lib/
├── core/
│   ├── error/
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── utils/
├── features/
│   └── posts/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── post_remote_datasource.dart
│       │   │   └── post_local_datasource.dart
│       │   ├── models/
│       │   │   └── post_model.dart
│       │   └── repositories/
│       │       └── post_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── post.dart
│       │   ├── repositories/
│       │   │   └── post_repository.dart
│       │   └── usecases/
│       │       ├── get_posts.dart
│       │       └── create_post.dart
│       └── presentation/
│           ├── bloc/
│           │   └── post_bloc.dart
│           ├── pages/
│           │   └── posts_page.dart
│           └── widgets/
│               └── post_card.dart
└── main.dart
```

#### Domain Layer

**Entity:**

```dart
// domain/entities/post.dart
class Post {
  final int id;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.title,
    required this.body,
  });
}
```

**Repository Interface:**

```dart
// domain/repositories/post_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/post.dart';
import '../../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Post>> getPost(int id);
  Future<Either<Failure, void>> createPost(Post post);
}
```

**Use Case:**

```dart
// core/usecases/usecase.dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// domain/usecases/get_posts.dart
class GetPosts implements UseCase<List<Post>, NoParams> {
  final PostRepository repository;

  GetPosts(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await repository.getPosts();
  }
}

class NoParams {}
```

#### Data Layer

**Model:**

```dart
// data/models/post_model.dart
import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required int id,
    required String title,
    required String body,
  }) : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
```

**Data Source:**

```dart
// data/datasources/post_remote_datasource.dart
abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPost(int id);
  Future<void> createPost(PostModel post);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  // Implementar otros métodos...
}
```

**Repository Implementation:**

```dart
// data/repositories/post_repository_impl.dart
import 'package:dartz/dartz.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getLastPosts();
        return Right(localPosts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
```

#### Presentation Layer

**BLoC:**

```dart
// presentation/bloc/post_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class PostEvent {}

class GetPostsEvent extends PostEvent {}

class CreatePostEvent extends PostEvent {
  final Post post;
  CreatePostEvent(this.post);
}

// States
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}

// BLoC
class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;
  final CreatePost createPost;

  PostBloc({
    required this.getPosts,
    required this.createPost,
  }) : super(PostInitial()) {
    on<GetPostsEvent>(_onGetPosts);
    on<CreatePostEvent>(_onCreatePost);
  }

  Future<void> _onGetPosts(
    GetPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());

    final result = await getPosts(NoParams());

    result.fold(
      (failure) => emit(PostError(_mapFailureToMessage(failure))),
      (posts) => emit(PostLoaded(posts)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor';
    } else if (failure is CacheFailure) {
      return 'Error de caché';
    }
    return 'Error inesperado';
  }

  // Implementar _onCreatePost...
}
```

### 2. Dependency Injection (1 hora)

#### Get_it

```yaml
dependencies:
  get_it: ^7.6.4
```

```dart
// injection_container.dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => PostBloc(
      getPosts: sl(),
      createPost: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => CreatePost(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
```

### 3. Testing (3 horas)

#### Tipos de Tests

- **Unit Tests:** Funciones, métodos, clases
- **Widget Tests:** Widgets individuales
- **Integration Tests:** Flujos completos

#### Unit Tests

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.3
  build_runner: ^2.4.6
```

```dart
// test/domain/usecases/get_posts_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

@GenerateMocks([PostRepository])
import 'get_posts_test.mocks.dart';

void main() {
  late GetPosts usecase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    usecase = GetPosts(mockRepository);
  });

  final tPosts = [
    Post(id: 1, title: 'Test', body: 'Body'),
  ];

  test('debe obtener posts del repositorio', () async {
    // Arrange
    when(mockRepository.getPosts())
        .thenAnswer((_) async => Right(tPosts));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(tPosts));
    verify(mockRepository.getPosts());
    verifyNoMoreInteractions(mockRepository);
  });

  test('debe retornar ServerFailure cuando falla', () async {
    // Arrange
    when(mockRepository.getPosts())
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Left(ServerFailure()));
  });
}
```

#### Widget Tests

```dart
// test/presentation/widgets/post_card_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  final testPost = Post(
    id: 1,
    title: 'Test Post',
    body: 'Test Body',
  );

  testWidgets('PostCard debe mostrar título y cuerpo', (tester) async {
    // Build widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostCard(post: testPost),
        ),
      ),
    );

    // Verificar que el título aparece
    expect(find.text('Test Post'), findsOneWidget);

    // Verificar que el cuerpo aparece
    expect(find.text('Test Body'), findsOneWidget);
  });

  testWidgets('PostCard debe responder a tap', (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostCard(
            post: testPost,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    // Hacer tap
    await tester.tap(find.byType(PostCard));
    await tester.pump();

    // Verificar callback
    expect(tapped, true);
  });
}
```

#### BLoC Tests

```dart
// test/presentation/bloc/post_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late PostBloc bloc;
  late MockGetPosts mockGetPosts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    bloc = PostBloc(getPosts: mockGetPosts);
  });

  tearDown(() {
    bloc.close();
  });

  test('estado inicial debe ser PostInitial', () {
    expect(bloc.state, PostInitial());
  });

  final tPosts = [Post(id: 1, title: 'Test', body: 'Body')];

  blocTest<PostBloc, PostState>(
    'debe emitir [PostLoading, PostLoaded] cuando es exitoso',
    build: () {
      when(mockGetPosts(any))
          .thenAnswer((_) async => Right(tPosts));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPostsEvent()),
    expect: () => [
      PostLoading(),
      PostLoaded(tPosts),
    ],
  );

  blocTest<PostBloc, PostState>(
    'debe emitir [PostLoading, PostError] cuando falla',
    build: () {
      when(mockGetPosts(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPostsEvent()),
    expect: () => [
      PostLoading(),
      PostError('Error del servidor'),
    ],
  );
}
```

### 4. Principios SOLID (0.5 hora)

#### S - Single Responsibility

Cada clase debe tener una sola responsabilidad

#### O - Open/Closed

Abierto para extensión, cerrado para modificación

#### L - Liskov Substitution

Subclases deben ser sustituibles por sus clases base

#### I - Interface Segregation

Interfaces específicas mejor que una general

#### D - Dependency Inversion

Depender de abstracciones, no de implementaciones

### 5. Optimización (1 hora)

#### Performance Best Practices

```dart
// Usar const constructors
const Text('Hello');

// ListView.builder para listas grandes
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
);

// RepaintBoundary para widgets costosos
RepaintBoundary(
  child: ComplexWidget(),
);

// Cached images
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => CircularProgressIndicator(),
);

// Evitar setState en widgets grandes
// Usar Provider, BLoC, etc.
```

## 💻 Ejercicios Prácticos

### Ejercicio 1: Estructura Clean Architecture

Refactoriza una app existente a Clean Architecture:

- Separar en capas
- Crear interfaces
- Implementar repositorios
- Use cases independientes

### Ejercicio 2: Unit Tests

Escribe tests para:

- Models (toJson/fromJson)
- Use cases
- Repositories
- Utilities

### Ejercicio 3: Widget Tests

Crear tests para:

- Widget personalizado
- Formulario
- Lista de items
- Navegación entre pantallas

### Ejercicio 4: BLoC Tests

Implementar tests completos de BLoC:

- Estados iniciales
- Eventos y transiciones
- Manejo de errores
- Múltiples eventos

### Ejercicio 5: Dependency Injection

Configurar GetIt para:

- Singletons
- Factories
- Lazy singletons
- Named dependencies

## 🔨 Proyecto de la Semana

**Refactorización Completa: App de Tareas con Clean Architecture**

Refactoriza o crea desde cero una app de gestión de tareas siguiendo todas las mejores prácticas:

**Características:**

1. **Clean Architecture Completa**

   - Domain layer (entities, repositories, use cases)
   - Data layer (models, data sources, repository impl)
   - Presentation layer (BLoC, pages, widgets)

2. **Use Cases Implementados**

   - GetTasks
   - CreateTask
   - UpdateTask
   - DeleteTask
   - CompleteTask
   - SearchTasks
   - GetTasksByCategory

3. **Testing Completo**

   - Unit tests para todos los use cases
   - Tests de modelos
   - Tests de repositorios
   - Widget tests para componentes
   - BLoC tests
   - Cobertura mínima: 80%

4. **Dependency Injection**

   - GetIt configurado
   - Todas las dependencias inyectadas
   - Fácil de mockear para tests

5. **Optimizaciones**
   - Const constructors
   - RepaintBoundary
   - Cached images
   - Debounce en búsqueda
   - Lazy loading

**Estructura de Proyecto:**

```
lib/
├── core/
│   ├── error/
│   ├── usecases/
│   ├── network/
│   └── utils/
├── features/
│   └── tasks/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
├── injection_container.dart
└── main.dart

test/
├── core/
├── features/
│   └── tasks/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── fixtures/
```

**Requisitos:**

- Todas las capas separadas
- Mínimo 20 tests escritos
- Documentación completa
- Coverage report
- CI/CD opcional (GitHub Actions)

## 📖 Recursos

### Documentación

- [Flutter Testing](https://flutter.dev/docs/testing)
- [BLoC Library](https://bloclibrary.dev/)
- [Get_it](https://pub.dev/packages/get_it)
- [Mockito](https://pub.dev/packages/mockito)

### Videos

- [Flutter Clean Architecture](https://www.youtube.com/watch?v=KjE2IDphA_U)
- [Flutter Testing Tutorial](https://www.youtube.com/watch?v=RDY6UYh-nyg)

### Paquetes

- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [get_it](https://pub.dev/packages/get_it)
- [dartz](https://pub.dev/packages/dartz)
- [mockito](https://pub.dev/packages/mockito)
- [bloc_test](https://pub.dev/packages/bloc_test)

## ✅ Checklist de Completitud

- [ ] Ejercicio 1: Clean Architecture completado
- [ ] Ejercicio 2: Unit tests completados
- [ ] Ejercicio 3: Widget tests completados
- [ ] Ejercicio 4: BLoC tests completados
- [ ] Ejercicio 5: DI configurado
- [ ] Proyecto: App refactorizada completado
- [ ] Tests ejecutándose correctamente
- [ ] Coverage > 80%
- [ ] Documentación completa
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios prácticos (1-5):** 25%
- **Proyecto de la semana:** 60%
- **Tests y cobertura:** 15%

## 📝 Notas Importantes

- Tests son inversión, no pérdida de tiempo
- Clean Architecture facilita mantenimiento
- Separar responsabilidades desde el inicio
- Mockear dependencias para aislar tests
- Documentar decisiones arquitectónicas

## 🔧 Comandos Útiles

```bash
# Ejecutar tests
flutter test

# Ejecutar tests con coverage
flutter test --coverage

# Ver coverage en HTML
genhtml coverage/lcov.info -o coverage/html

# Generar mocks
flutter pub run build_runner build

# Watch mode para tests
flutter test --watch
```

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 8](../semana-08/README.md) | **Siguiente:** [Semana 10 →](../semana-10/README.md)
