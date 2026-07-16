# GoRouterRefreshStream y Buenas Prácticas de Arquitectura

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué el guard de rutas de esta semana usa `refreshListenable` y no reconstruir el router
- Cómo `GoRouterRefreshStream` conecta un `Stream` de Bloc con `GoRouter`
- Buenas prácticas para mantener la separación de capas mientras el proyecto crece

## 📋 Conceptos Clave

### 1. Por qué ya no se reconstruye el GoRouter completo

Semana 9 resolvía el guard de rutas con `appRouter` como **provider de Riverpod**: cada cambio en
`authProvider` hacía que Riverpod reconstruyera el `GoRouter` entero, porque `ref.watch()` dentro
de un provider dispara su reejecución automáticamente.

Bloc no tiene un mecanismo equivalente a `ref.watch()` fuera de un widget — un `Cubit` es una
clase Dart normal, nadie "observa" sus cambios a menos que te suscribas explícitamente a su
`Stream`. Reconstruir el `GoRouter` completo en cada cambio de auth ya no es tan simple como
antes, así que este proyecto usa la alternativa que la teoría 05 de semana 9 dejó mencionada:
`refreshListenable`.

### 2. GoRouterRefreshStream

```dart
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
```

Es un `ChangeNotifier` que se suscribe a cualquier `Stream` y llama `notifyListeners()` cada vez
que el stream emite — GoRouter acepta cualquier `Listenable` en `refreshListenable`, así que este
adaptador conecta ambos mundos:

```dart
GoRouter buildAppRouter(AuthCubit authCubit) {
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final isLoggedIn = authCubit.state is AuthAuthenticated;
      // ...
    },
    routes: [ /* ... */ ],
  );
}
```

Cada `Cubit`/`Bloc` expone `.stream` (heredado de `BlocBase`) — un `Stream` que emite cada nuevo
estado. `GoRouterRefreshStream(authCubit.stream)` hace que GoRouter reevalúe `redirect` en cada
login/logout, sin reconstruir el router — el mismo `GoRouter` vive toda la sesión de la app,
construido **una sola vez** en `main()`.

### 3. `authCubit.state` dentro de `redirect` — por qué no hace falta más

`redirect` es una función normal que se ejecuta en cada intento de navegación — dentro de ella,
`authCubit.state` siempre lee el valor **actual** (no uno capturado en el pasado), porque
`authCubit` es la misma instancia todo el tiempo. `refreshListenable` solo se encarga de avisarle
a `GoRouter` "algo cambió, vuelve a evaluar redirect" — la lectura del estado sigue siendo
directa.

### 4. Buenas prácticas para no romper la separación de capas

- **Un Cubit nunca importa nada de `data/`** — solo use cases (`domain/usecases/`). Si sientes la
  tentación de inyectar un `Dio` o un `Box` directo en un Cubit, es señal de que falta un use
  case o un datasource.
- **Un widget nunca importa un repository ni un datasource** — solo el Cubit correspondiente
  (`context.read<ItemsCubit>()`), nunca `getIt<ItemsRepository>()` directo desde una pantalla.
- **Una entidad de domain nunca tiene `fromJson`/`toJson`** — esa responsabilidad es siempre del
  modelo (`data/models/`). Si una entidad empieza a necesitar serialización, es porque algo se
  está colando desde la capa exterior.
- **`get_it` se configura en un solo lugar** (`core/di/injection_container.dart`) — nunca
  registres una dependencia dentro de un widget o un Cubit.

## ✅ Checklist de Verificación

- [ ] Sé por qué este proyecto usa `refreshListenable` en vez de reconstruir el router
- [ ] Sé cómo `GoRouterRefreshStream` conecta un `Stream` de Bloc con `GoRouter`
- [ ] Sé por qué `authCubit.state` dentro de `redirect` siempre lee el valor actual
- [ ] Repasé las buenas prácticas para no romper la separación de capas

## 📚 Siguiente paso

Continúa con los [ejercicios prácticos](../2-practicas/) de esta semana.
