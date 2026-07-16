# Ejercicio 03 — AnimatedSwitcher y AnimatedList

> Animarás dos cosas independientes: el cambio entre estados de carga/error/listo con
> `AnimatedSwitcher`, y las altas/bajas de una lista de favoritos con `AnimatedList`,
> descomentando código paso a paso.

## 🎯 Objetivos

- Animar el reemplazo de un widget por otro completamente distinto con `AnimatedSwitcher`
- Usar una `ValueKey` única por rama para que Flutter detecte el cambio
- Animar la inserción y eliminación de elementos de una lista con `AnimatedList`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: AnimatedSwitcher con key por estado

```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  child: switch (_state) {
    ViewState.loading => const CircularProgressIndicator(key: ValueKey('loading')),
    ViewState.error => const Text('Error al cargar', key: ValueKey('error')),
    ViewState.loaded => const Icon(Icons.check_circle, size: 48, key: ValueKey('loaded')),
  },
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — reemplaza el `switch` plano
por este `AnimatedSwitcher`.

✅ **Verifica**: al presionar los botones "Cargando"/"Error"/"Listo", el widget anterior se
desvanece y el nuevo aparece con un fundido — no hay salto instantáneo.

---

## Paso 2: lista de favoritos con AnimatedList

```dart
final _listKey = GlobalKey<AnimatedListState>();

// ...

AnimatedList(
  key: _listKey,
  shrinkWrap: true,
  initialItemCount: _favorites.length,
  itemBuilder: (context, index, animation) => SizeTransition(
    sizeFactor: animation,
    child: ListTile(title: Text(_favorites[index])),
  ),
)
```

**Descomenta la sección `PASO 2`** — reemplaza el `ListView` estático de favoritos por este
`AnimatedList`, y agrega el `GlobalKey<AnimatedListState> _listKey` como campo del `State`.

---

## Paso 3: insertar y eliminar con animación

```dart
void _addFavorite(String name) {
  _favorites.add(name);
  _listKey.currentState?.insertItem(_favorites.length - 1);
}

void _removeFavorite(int index) {
  final removed = _favorites.removeAt(index);
  _listKey.currentState?.removeItem(
    index,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: ListTile(title: Text(removed)),
    ),
  );
}
```

**Descomenta la sección `PASO 3`** y conecta `_addFavorite`/`_removeFavorite` a los botones de
agregar/quitar de cada `ListTile`.

✅ **Verifica**: agregar un favorito lo desliza hacia adentro creciendo desde altura cero;
quitarlo lo colapsa antes de desaparecer. Si modificaras `_favorites` directamente con
`setState(() => _favorites.add(...))` sin llamar `insertItem`, la lista visual quedaría
desincronizada con los datos — por eso `_listKey.currentState` siempre acompaña al cambio de la
lista real.

---

## ✅ Resultado final

Una pantalla con dos animaciones independientes: transición de estado con `AnimatedSwitcher` y
altas/bajas animadas con `AnimatedList` — la base para el estado de carga y la lista de
favoritos del proyecto de esta semana.
