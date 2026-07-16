# AnimatedSwitcher y AnimatedList

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo `AnimatedSwitcher` anima el reemplazo de un widget por otro completamente distinto
- Cómo `AnimatedList` anima la inserción y eliminación de elementos de una lista
- Por qué ninguno de los dos funciona sin una `key` correcta

## 📋 Conceptos Clave

### 1. El caso que `AnimatedContainer` no cubre

Los widgets del archivo 02 animan **cambios de propiedades** de un mismo widget. Pero ¿qué pasa
cuando necesitas reemplazar un widget por **otro completamente distinto** — un `CircularProgressIndicator`
por una lista de resultados, o un ícono de "like" vacío por uno lleno? Ahí no hay una propiedad
que interpolar: son dos árboles de widgets distintos. `AnimatedSwitcher` resuelve esto con una
transición de fundido (fade out del viejo, fade in del nuevo) automática.

```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  child: switch (state) {
    ItemsLoading() => const CircularProgressIndicator(key: ValueKey('loading')),
    ItemsError() => const ErrorRetryView(key: ValueKey('error')),
    ItemsLoaded(:final items) => ItemsGrid(key: const ValueKey('loaded'), items: items),
  },
)
```

### 2. Por qué el `key` es obligatorio aquí

`AnimatedSwitcher` decide "esto es un widget nuevo, hay que animar la transición" comparando el
`key` (y el tipo) del child entre un `build()` y el siguiente. Sin una `key` distinta por estado,
dos `CircularProgressIndicator()` seguidos parecen "el mismo widget" para Flutter y no dispara
ninguna transición — igual, si vuelves de `ItemsError` a `ItemsLoading` sin keys distintas,
Flutter puede confundir ambos widgets si comparten tipo. La regla práctica: **cada rama del
`switch`/`if` necesita su propia `ValueKey` única**.

### 3. AnimatedList — animar altas y bajas en una lista

Una `ListView.builder` normal, si el usuario elimina un ítem, hace que la lista "salte" — el
elemento desaparece sin transición. `AnimatedList` anima la inserción/eliminación individual de
elementos con una `GlobalKey` que controla explícitamente cuándo insertar o remover.

```dart
class FavoritesListState extends State<FavoritesList> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<Item> _items = [];

  void _removeAt(int index) {
    final removed = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ItemCard(item: removed),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) => SizeTransition(
        sizeFactor: animation,
        child: ItemCard(item: _items[index]),
      ),
    );
  }
}
```

La diferencia clave frente a `ListView.builder`: **tú controlas el momento exacto** de la
inserción/eliminación llamando `_listKey.currentState.insertItem(index)` /
`.removeItem(index, builder)` — la lista de datos (`_items`) y la lista visual (`AnimatedList`)
deben mantenerse sincronizadas manualmente. Si modificas `_items` directamente sin llamar a
`insertItem`/`removeItem`, la `AnimatedList` queda desincronizada con los datos reales y puede
lanzar un error de rango.

### 4. AnimatedList vs. simplemente animar cada ItemCard

Para muchos casos (una lista de favoritos que crece/decrece), envolver cada `ItemCard` en
`AnimatedOpacity`/`AnimatedSize` dentro de un `ListView.builder` normal es más simple y suficiente
— no necesitas la sincronización manual de `AnimatedList` si el número de reordenamientos es bajo.
Reserva `AnimatedList` para cuando el **orden de inserción/eliminación en tiempo real** importa
visualmente (ej. un feed que recibe elementos nuevos por WebSocket), no como default para toda
lista con estado cambiante.

## ✅ Checklist de Verificación

- [ ] Sé cuándo usar `AnimatedSwitcher` en vez de `AnimatedContainer` (widgets distintos, no
      propiedades de un mismo widget)
- [ ] Sé por qué cada rama necesita una `ValueKey` distinta en `AnimatedSwitcher`
- [ ] Sé el patrón básico de `AnimatedList`: `GlobalKey<AnimatedListState>` +
      `insertItem`/`removeItem` sincronizados con la lista de datos real
- [ ] Sé cuándo `AnimatedList` es excesivo y basta con animar cada item dentro de un
      `ListView.builder` normal

## 📚 Próximo paso

[Buenas Prácticas y Rendimiento en Animaciones →](06-buenas-practicas-y-rendimiento.md)
