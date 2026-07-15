# Parámetros y Rutas Dinámicas

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo declarar y leer parámetros de ruta (path parameters)
- Cómo usar query parameters
- Cómo pasar objetos completos con `extra`

## 📋 Conceptos Clave

### 1. Path parameters — `:id`

```dart
GoRoute(
  path: '/items/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return DetailScreen(itemId: id);
  },
)
```

Navegas pasando el valor real en la URL:

```dart
context.push('/items/42'); // state.pathParameters['id'] == '42'
```

> 💡 **Analogía con URLs web**: `/items/:id` es exactamente el mismo concepto que rutas
> dinámicas en Next.js (`/items/[id]`) o Express (`/items/:id`) — un segmento de la ruta se
> convierte en variable.

### 2. Query parameters

```dart
// Definición: no requiere sintaxis especial en el path
GoRoute(
  path: '/search',
  builder: (context, state) {
    final query = state.uri.queryParameters['q'] ?? '';
    return SearchScreen(initialQuery: query);
  },
)

// Navegación:
context.push('/search?q=flutter');
// o de forma más segura, construyendo la URI:
context.push(Uri(path: '/search', queryParameters: {'q': 'flutter'}).toString());
```

### 3. `extra`: pasar objetos completos (con cuidado)

```dart
GoRoute(
  path: '/items/:id',
  builder: (context, state) {
    final item = state.extra as Item?; // puede ser null
    final id = state.pathParameters['id']!;
    return DetailScreen(itemId: id, preloadedItem: item);
  },
)

context.push('/items/42', extra: myItemInstance);
```

> ⚠️ **`extra` no sobrevive un deep link ni un refresh de Flutter Web** — solo funciona para
> navegación dentro de la misma sesión de la app. Úsalo como **optimización** (evitar una
> segunda búsqueda si ya tienes el objeto en memoria), nunca como única fuente del dato: el
> `id` del path siempre debe bastar para reconstruir la pantalla por sí solo.

### 4. Patrón recomendado: id como fuente de verdad, extra como caché

```dart
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.itemId, this.preloadedItem});

  final String itemId;
  final Item? preloadedItem;

  @override
  Widget build(BuildContext context) {
    // Si vino por extra, úsalo. Si no (deep link, refresh), búscalo por id.
    final item = preloadedItem ?? findItemById(itemId);
    // ...
  }
}
```

Este patrón es exactamente el que usarás en el proyecto de esta semana, y el mismo que
reaparecerá en semana 6 al cargar datos reales desde una API por id.

## ⚠️ Errores Comunes

- Usar `state.pathParameters['id']!` sin verificar que el parámetro exista — si cambias el path
  y olvidas actualizar una navegación, esto lanza una excepción en runtime.
- Depender de `extra` como única fuente del dato — se pierde en deep links, rompe la pantalla.
- Olvidar decodificar/codificar query parameters con caracteres especiales (usa `Uri(...)` en
  vez de concatenar strings a mano).

## 📚 Recursos Adicionales

- [go_router — Parameters](https://pub.dev/documentation/go_router/latest/topics/Parameters-topic.html)

## ✅ Checklist de Verificación

- [ ] Puedo declarar y leer un path parameter
- [ ] Puedo leer query parameters de forma segura
- [ ] Entiendo por qué `extra` no debe ser la única fuente del dato
