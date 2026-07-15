# Ejercicio 03 — ShellRoute y Navegación por Tabs

> Construirás una navegación con bottom navigation bar persistente usando `ShellRoute`,
> descomentando código paso a paso. Es el ejercicio más largo de la semana.

## 🎯 Objetivos

- Construir un `ShellRoute` con `Scaffold` + `NavigationBar` compartidos
- Anidar rutas hijas dentro del `ShellRoute`
- Navegar entre tabs con `context.go()` (no `push()`)

## 📋 Requisitos

- Ejercicios 01 y 02 completados

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: ShellRoute con Scaffold + NavigationBar

```dart
ShellRoute(
  builder: (context, state, child) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexForLocation(state.uri.toString()),
        onDestinationSelected: (index) => context.go(index == 0 ? '/' : '/about'),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.info), label: 'Acerca de'),
        ],
      ),
    );
  },
  routes: [],
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye la función
`_indexForLocation` que ya está provista arriba).

✅ **Verifica**: la app debe compilar y mostrar la barra inferior, aunque todavía sin pantallas
(la lista `routes: []` está vacía).

---

## Paso 2: Rutas hijas del ShellRoute

```dart
GoRoute(path: '/', builder: (context, state) => const HomeTab()),
GoRoute(path: '/about', builder: (context, state) => const AboutTab()),
```

**Descomenta la sección `PASO 2`** y agrega estas dos rutas dentro del `routes: []` del Paso 1.

✅ **Verifica**: ambas pestañas deben mostrar contenido distinto al tocarlas, y la barra
inferior **no debe parpadear/reconstruirse** al cambiar de tab.

---

## Paso 3: Resaltar la pestaña activa correctamente

```dart
int _indexForLocation(String location) => location.startsWith('/about') ? 1 : 0;
```

Esta función ya viene en el Paso 1 — en este paso solo debes **verificarla**, no hay código
nuevo que descomentar.

✅ **Verifica**: al tocar "Acerca de", el ícono resaltado en la barra inferior debe ser el
segundo, no el primero.

---

## ✅ Resultado final

Una app con 2 tabs (Inicio / Acerca de) y una barra inferior persistente que nunca se
reconstruye al cambiar entre ellas.
