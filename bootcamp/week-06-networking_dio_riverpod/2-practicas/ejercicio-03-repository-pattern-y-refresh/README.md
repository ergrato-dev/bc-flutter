# Ejercicio 03 — Repository Pattern y Pull-to-Refresh

> Separarás Dio del `AsyncNotifier` detrás de un repository, y agregarás pull-to-refresh con
> `ref.refresh()`, descomentando código paso a paso. Es el ejercicio más largo de la semana.

## 🎯 Objetivos

- Definir una interfaz `PostsRepository` + una implementación con Dio
- Consumir el repository desde un `AsyncNotifier`, sin que este conozca Dio
- Implementar pull-to-refresh con `RefreshIndicator` + `ref.refresh()`

## 📋 Requisitos

- Ejercicios 01 y 02 completados

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

---

## Paso 1: PostsRepository

```dart
abstract class PostsRepository {
  Future<List<String>> fetchTitles();
}

class DioPostsRepository implements PostsRepository {
  DioPostsRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<String>> fetchTitles() async {
    try {
      final response = await _dio.get('/posts');
      return (response.data as List)
          .map((json) => json['title'] as String)
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('Sin conexión a internet');
      }
      throw Exception('No se pudo cargar la información');
    }
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar
`part 'main.g.dart';` junto a los imports). Regenera con build_runner.

---

## Paso 2: postsRepositoryProvider + PostsNotifier

```dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
}

@riverpod
PostsRepository postsRepository(Ref ref) {
  return DioPostsRepository(ref.watch(dioProvider));
}

@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  Future<List<String>> build() async {
    final repository = ref.watch(postsRepositoryProvider);
    return repository.fetchTitles();
  }
}
```

**Descomenta la sección `PASO 2`.** Regenera con build_runner.

✅ **Verifica**: `PostsNotifier` ya no importa nada de Dio en su propio cuerpo — solo conoce
`PostsRepository`.

---

## Paso 3: Pull-to-refresh

```dart
class _PostsList extends ConsumerWidget {
  const _PostsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);
    return postsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$error'),
            ElevatedButton(
              onPressed: () => ref.invalidate(postsProvider),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
      data: (titles) => RefreshIndicator(
        onRefresh: () => ref.refresh(postsProvider.future),
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) => ListTile(title: Text(titles[index])),
        ),
      ),
    );
  }
}
```

**Descomenta la sección `PASO 3`** y reemplaza el `body:` de `HomeScreen` por
`body: const _PostsList()`. Regenera con build_runner.

✅ **Verifica**: desliza la lista hacia abajo — debe verse el spinner de `RefreshIndicator` y
recargar los datos. Fuerza un error (modo avión) y confirma que el botón "Reintentar" recupera
la lista al restablecer la conexión.

---

## ✅ Resultado final

Un `AsyncNotifier` que no conoce Dio (todo pasa por `PostsRepository`), con reintento manual y
pull-to-refresh — la misma arquitectura que implementarás en el proyecto de esta semana sobre tu
dominio asignado.
