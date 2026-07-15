# El Problema del Estado Compartido

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Los límites de `setState` cuando el estado debe compartirse entre widgets
- Qué es el "prop drilling" y por qué es un problema
- Por qué este bootcamp introduce Provider antes de Riverpod (semana 5)

## 📋 Conceptos Clave

### 1. Repaso: setState es local

Desde semana 2 usas `setState` para estado que vive **dentro de un solo widget**:

```dart
class _CounterState extends State<Counter> {
  int _count = 0;
  void _increment() => setState(() => _count++);
  // ...
}
```

Esto funciona perfecto mientras solo `Counter` necesita conocer `_count`. El problema aparece
cuando **otro widget, en otra parte del árbol**, también necesita ese mismo dato.

### 2. El problema: prop drilling

Imagina que el contador de favoritos debe mostrarse en el `AppBar` (arriba del todo) pero se
modifica desde una `ItemCard` (muy abajo en el árbol). Sin una solución de estado compartido,
tendrías que pasar el valor y su función de actualización como parámetros a través de **cada
widget intermedio**, aunque no lo usen:

```dart
// ❌ "Prop drilling": HomeScreen no usa favoriteCount, pero debe recibirlo
// y pasarlo, solo para que llegue a AppBar y a ItemList.
HomeScreen(favoriteCount: count, onToggleFavorite: toggle)
  -> AppBar(favoriteCount: count)
  -> ItemList(onToggleFavorite: toggle)
    -> ItemCard(onToggleFavorite: toggle)
```

> 💡 **Mismo problema en cualquier framework**: esto es idéntico al "prop drilling" de React —
> la razón por la que existen Context API en React, Provider/Riverpod en Flutter, y Redux/
> Zustand como alternativas más estructuradas en ambos ecosistemas.

### 3. La solución: estado accesible desde cualquier punto del árbol

Lo que necesitas es una forma de decir "cualquier widget descendiente puede leer (y a veces
modificar) este estado, sin que los widgets intermedios necesiten saber que existe". Flutter
resuelve esto internamente con `InheritedWidget` (lo verás en el archivo 2) — pero usarlo
directamente es verboso, así que este curso usa el paquete **Provider**, que lo envuelve con
una API mucho más simple.

### 4. Por qué Provider antes de Riverpod

Este bootcamp enseña una progresión deliberada: **Provider (esta semana) → Riverpod (estándar
del curso desde semana 5) → Bloc/Cubit (semana 10)**. Empezar por Provider tiene una razón
concreta: Provider está construido directamente sobre `InheritedWidget` (lo que ves es
prácticamente lo que hay), mientras que Riverpod resuelve los mismos problemas de forma
independiente del árbol de widgets — es más potente, pero más abstracto. Entender Provider
primero te da el modelo mental correcto para apreciar **qué problemas adicionales** resuelve
Riverpod cuando lo veas la próxima semana.

## ⚠️ Errores Comunes

- Intentar resolver todo con `setState` y parámetros, incluso cuando el estado se necesita en
  3+ niveles de distancia — es la señal de que necesitas estado compartido.
- Pensar que "estado compartido" significa "estado global para toda la app" — Provider (y
  Riverpod después) permiten compartir estado en el **subárbol** que lo necesita, no
  obligatoriamente en toda la app.

## 📚 Recursos Adicionales

- [Flutter — State management](https://docs.flutter.dev/data-and-backend/state-mgmt/intro)
- [Flutter — Simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)

## ✅ Checklist de Verificación

- [ ] Puedo explicar por qué `setState` no basta cuando el estado se comparte entre widgets lejanos
- [ ] Entiendo qué es "prop drilling" y por qué es un problema
- [ ] Sé por qué este curso enseña Provider antes que Riverpod
