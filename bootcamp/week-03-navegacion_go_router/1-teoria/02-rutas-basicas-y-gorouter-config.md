# Rutas Básicas y Configuración de GoRouter

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo declarar rutas con `GoRoute`
- La diferencia entre `context.go()` y `context.push()`
- Cómo volver atrás con `context.pop()`

## 📋 Conceptos Clave

### 1. Declarar rutas

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
```

Cada `GoRoute` asocia un `path` (como una URL) con un `builder` que retorna el widget de esa
pantalla. `state` (segundo parámetro del builder) trae información de la navegación actual —
la usarás en el archivo 3 para leer parámetros.

### 2. context.go() vs context.push()

```dart
// go(): REEMPLAZA la ubicación actual — no se puede volver con el botón atrás
context.go('/settings');

// push(): APILA una nueva pantalla sobre la actual — sí se puede volver atrás
context.push('/settings');
```

> 💡 **Cuándo usar cada uno**: usa `go()` para navegación principal entre secciones
> (equivalente a cambiar de tab), y `push()` cuando el usuario debe poder volver a donde estaba
> (por ejemplo, entrar al detalle de un elemento desde una lista — exactamente el caso del
> proyecto de esta semana).

### 3. Volver atrás

```dart
context.pop(); // vuelve a la pantalla anterior en la pila

// Con un resultado, como Navigator.pop(context, resultado):
context.pop('algún-valor');
```

`context.pop()` solo funciona si hay algo en la pila para desapilar (es decir, si llegaste con
`push()`, no con `go()`). Si necesitas manejar el botón atrás físico de Android de forma
personalizada, existe `PopScope` — lo verás si tu proyecto lo requiere en semanas posteriores.

### 4. Botones y enlaces de navegación

```dart
ElevatedButton(
  onPressed: () => context.push('/settings'),
  child: const Text('Ir a configuración'),
)

// go_router también expone un widget declarativo:
GoRouterAlert.of(context); // (ejemplo ilustrativo — usarás context.push/go en la práctica)
```

En la práctica, el 95% de la navegación en este curso se hace llamando `context.go()` o
`context.push()` desde un `onPressed`/`onTap` — no necesitas memorizar mucho más que estos dos
métodos y `context.pop()`.

## ⚠️ Errores Comunes

- Usar `go()` cuando el usuario espera poder "volver" (por ejemplo, al abrir un detalle) — usa
  `push()` en esos casos.
- Llamar `context.pop()` sin verificar que haya algo para desapilar (usa
  `if (context.canPop()) context.pop();` si no estás seguro del origen de la navegación).
- Definir rutas con paths duplicados — `go_router` usa el primero que coincide, lo que puede
  esconder bugs silenciosamente.

## 📚 Recursos Adicionales

- [go_router — Configuration](https://pub.dev/documentation/go_router/latest/topics/Configuration-topic.html)
- [go_router — Navigation](https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html)

## ✅ Checklist de Verificación

- [ ] Puedo declarar rutas básicas con GoRoute
- [ ] Sé cuándo usar go() vs push()
- [ ] Puedo volver atrás con pop() de forma segura
