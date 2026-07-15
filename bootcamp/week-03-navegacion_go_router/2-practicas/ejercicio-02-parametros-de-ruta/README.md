# Ejercicio 02 — Parámetros de Ruta y extra

> Construirás una lista → detalle usando un path parameter `:id`, descomentando código paso a
> paso.

## 🎯 Objetivos

- Declarar y leer un path parameter con `state.pathParameters`
- Pasar un objeto completo con `extra` como optimización
- Aplicar el patrón "id como fuente de verdad, extra como caché" con null safety

## 📋 Requisitos

- Ejercicio 01 completado

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: Ruta con path parameter

```dart
GoRoute(
  path: '/items/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return DetailScreen(itemId: id);
  },
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: la app debe mostrar `HomeScreen` con una lista de 3 elementos de ejemplo.

---

## Paso 2: Navegar pasando el id y el objeto completo con extra

```dart
context.push('/items/${item.id}', extra: item);
```

**Descomenta la sección `PASO 2`** (el `onTap` de cada elemento de la lista).

✅ **Verifica**: al tocar un elemento, `DetailScreen` debe mostrar su nombre correctamente.

---

## Paso 3: Fallback cuando extra es null (deep link simulado)

```dart
final resolvedItem = preloadedItem ?? findById(itemId);
```

**Descomenta la sección `PASO 3`** dentro de `DetailScreen` (y borra la línea temporal que
queda justo debajo, marcada con `// TODO temporal, ver PASO 3`). `findById` ya está
implementado arriba del archivo — el mismo patrón que reutilizarás en el proyecto de esta
semana.

✅ **Verifica**: comenta temporalmente el `extra:` del Paso 2 (o navega manualmente sin él) y
confirma que `DetailScreen` **igual** encuentra el elemento correcto usando solo el `id` — así
se comportaría si llegaras por un deep link real. Vuelve a descomentar `extra:` al terminar.

---

## ✅ Resultado final

Una lista que navega al detalle de cada elemento vía `/items/:id`, con `extra` como
optimización y `id` como fuente de verdad que siempre funciona.
