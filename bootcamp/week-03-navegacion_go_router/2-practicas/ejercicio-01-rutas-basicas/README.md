# Ejercicio 01 — Rutas Básicas con GoRouter

> Configurarás tu primer `GoRouter` con dos pantallas, descomentando código paso a paso.

## 🎯 Objetivos

- Configurar `MaterialApp.router` con un `GoRouter`
- Declarar rutas con `GoRoute`
- Navegar con `context.push()` y volver con `context.pop()`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: GoRouter con una sola ruta

```dart
final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  ],
);
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye cambiar
`MaterialApp` por `MaterialApp.router` y usar `_router`).

✅ **Verifica**: la app debe mostrar `HomeScreen` con un botón "Ir al detalle".

---

## Paso 2: Segunda ruta y navegación con push

```dart
GoRoute(path: '/detail', builder: (context, state) => const DetailScreen()),
```

**Descomenta la sección `PASO 2`** (la ruta nueva + el `onPressed` del botón en `HomeScreen`
que llama `context.push('/detail')`).

✅ **Verifica**: al tocar el botón, debe navegar a `DetailScreen`.

---

## Paso 3: Volver atrás con pop

```dart
ElevatedButton(onPressed: () => context.pop(), child: const Text('Volver'))
```

**Descomenta la sección `PASO 3`** dentro de `DetailScreen`.

✅ **Verifica**: al tocar "Volver", debe regresar a `HomeScreen` (y el botón atrás nativo del
dispositivo/emulador también debe funcionar, porque llegaste con `push`).

---

## ✅ Resultado final

Una app con 2 pantallas: `HomeScreen` → (push) → `DetailScreen` → (pop) → `HomeScreen`.
