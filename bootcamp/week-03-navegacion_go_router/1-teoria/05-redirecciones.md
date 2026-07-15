# Redirecciones con GoRouter

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo usar `redirect` para proteger rutas
- La diferencia entre redirección a nivel de `GoRouter` y a nivel de `GoRoute`
- Por qué esto es la base de la autenticación que verás en semana 9

## 📋 Conceptos Clave

### 1. El problema: proteger rutas

Ciertas pantallas (perfil, checkout, configuración de cuenta) solo deberían ser accesibles si
el usuario inició sesión. Sin un mecanismo centralizado, tendrías que repetir esa verificación
en cada pantalla.

### 2. `redirect` a nivel de GoRouter

```dart
final router = GoRouter(
  redirect: (context, state) {
    final loggedIn = AuthState.isLoggedIn; // placeholder — en semana 9 será real
    final loggingIn = state.matchedLocation == '/login';

    if (!loggedIn && !loggingIn) return '/login';   // no autenticado → forzar login
    if (loggedIn && loggingIn) return '/';           // ya autenticado → fuera de /login

    return null; // null = no redirigir, continuar a la ruta solicitada
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  ],
);
```

`redirect` se evalúa **antes** de construir cualquier pantalla — retornar un path fuerza la
navegación hacia allá; retornar `null` deja que la navegación original continúe.

> 💡 **Esto no es autenticación real todavía**: esta semana `AuthState.isLoggedIn` es un
> placeholder (una variable booleana simple). En semana 9 lo conectarás con `flutter_secure_storage`
> y un token JWT real — el mecanismo de `redirect` no cambia, solo la fuente de verdad.

### 3. `redirect` a nivel de GoRoute individual

```dart
GoRoute(
  path: '/admin',
  redirect: (context, state) => isAdmin ? null : '/',
  builder: (context, state) => const AdminScreen(),
),
```

Útil cuando solo una ruta específica necesita una regla, en vez de la lógica global del router.

### 4. Evitar loops de redirección

```dart
// ❌ PELIGRO: si '/login' también requiere estar deslogueado y algo falla,
// esto puede generar un loop infinito de redirecciones.
redirect: (context, state) {
  if (!loggedIn) return '/login';
  // olvidaste el caso "ya en /login" → loop si '/login' también redirige
}
```

Siempre cubre explícitamente el caso "ya estoy en la ruta de destino" para evitar loops, como
en el ejemplo de la sección 2.

## ⚠️ Errores Comunes

- Olvidar el caso `loggingIn` (ya estar en la ruta de destino) — causa loops infinitos.
- Poner lógica de UI (mostrar un diálogo, un `SnackBar`) dentro de `redirect` — debe ser una
  función pura que solo retorna un path o `null`.
- Verificar autenticación de forma asíncrona con una llamada de red directamente en `redirect`
  sin manejar el estado de carga — normalmente se resuelve con un `Listenable` que notifica al
  router cuando el estado de auth cambia (`refreshListenable`), tema que retomarás en semana 9.

## 📚 Recursos Adicionales

- [go_router — Redirection](https://pub.dev/documentation/go_router/latest/topics/Redirection-topic.html)

## ✅ Checklist de Verificación

- [ ] Puedo proteger una ruta con `redirect` a nivel de GoRouter
- [ ] Sé cómo evitar un loop de redirección
- [ ] Entiendo por qué esto es la base de la autenticación de semana 9
