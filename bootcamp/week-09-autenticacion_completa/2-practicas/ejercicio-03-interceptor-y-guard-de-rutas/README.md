# Ejercicio 03 — Interceptor y Guard de Rutas

> Combinarás un interceptor de Dio (agrega un header a cada request) con un guard de rutas de
> go_router reactivo a Riverpod — el mismo mecanismo del proyecto de esta semana, sin backend de
> login real. Es el ejercicio más largo de la semana.

## 🎯 Objetivos

- Agregar un header a cada request con `InterceptorsWrapper.onRequest`
- Convertir `appRouter` de constante a `@riverpod GoRouter appRouter(Ref ref)`
- Redirigir a `/login` cuando no hay sesión, y de vuelta a `/` cuando sí la hay

## 📋 Requisitos

- Ejercicios 01 y 02 completados
- Conexión a internet (usa la API pública `httpbin.org`, que devuelve los headers recibidos)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

---

## Paso 1: AuthNotifier + pantallas + dioProvider base

```dart
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  bool build() => false;

  void login() => state = true;
  void logout() => state = false;
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://httpbin.org'));
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar
`part 'main.g.dart';`). Regenera con build_runner.

> 💡 Esta semana no repite el login real de los ejercicios 01-02 — `AuthNotifier` aquí es un
> `bool` simple (`login()`/`logout()`) para enfocarse en el interceptor y el guard de rutas, que
> son el tema nuevo de este ejercicio.

---

## Paso 2: interceptor que agrega el header

```dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://httpbin.org'));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (ref.read(authProvider)) {
          options.headers['Authorization'] = 'Bearer demo-token';
        }
        handler.next(options);
      },
    ),
  );
  return dio;
}
```

**Reemplaza el `dioProvider` del PASO 1** por esta versión (sección `PASO 2`). Regenera con
build_runner.

`httpbin.org/headers` responde con un JSON que incluye exactamente los headers que recibió — es
la forma de **verificar** que el interceptor funcionó, sin necesitar un backend propio que
valide el token.

---

## Paso 3: appRouterProvider con redirect

```dart
@riverpod
GoRouter appRouter(Ref ref) {
  final isLoggedIn = ref.watch(authProvider);
  return GoRouter(
    initialLocation: isLoggedIn ? '/' : '/login',
    redirect: (context, state) {
      final loggingIn = state.uri.toString() == '/login';
      if (!isLoggedIn && !loggingIn) return '/login';
      if (isLoggedIn && loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    ],
  );
}
```

**Descomenta la sección `PASO 3`**, cambia `MyApp` de `StatelessWidget` a `ConsumerWidget`, y
usa `MaterialApp.router(routerConfig: ref.watch(appRouterProvider))`. Regenera con build_runner.

✅ **Verifica**: la app arranca en `LoginScreen` (sin sesión). Presiona "Iniciar sesión" — debe
navegar solo a `HomeScreen` (sin que tú llames `context.go()` a mano: el `redirect` reactivo lo
hizo). En `HomeScreen`, presiona "Ver headers enviados" — debe mostrar `"Authorization":
"Bearer demo-token"` en la respuesta. Presiona "Cerrar sesión" — debe volver solo a
`LoginScreen`.

---

## ✅ Resultado final

Un interceptor que agrega un header a cada request, y un guard de rutas que reacciona a
Riverpod reconstruyendo el `GoRouter` — exactamente los dos mecanismos que conectarás con login
real y `flutter_secure_storage` en el proyecto de esta semana.
