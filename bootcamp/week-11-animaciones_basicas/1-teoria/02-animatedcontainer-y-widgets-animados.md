# AnimatedContainer y Widgets Animados Implícitos

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo funciona `AnimatedContainer` y qué propiedades puede interpolar
- El resto de la familia `Animated*` (`AnimatedOpacity`, `AnimatedAlign`, `AnimatedPadding`,
  `AnimatedDefaultTextStyle`) y cuándo usar cada una
- Por qué el `key` importa cuando el widget puede reconstruirse desde cero

## 📋 Conceptos Clave

### 1. AnimatedContainer

`AnimatedContainer` es un `Container` que anima automáticamente **cualquier propiedad que
cambie** entre rebuilds: `width`, `height`, `color`, `padding`, `margin`, `alignment`,
`decoration`, `transform`.

```dart
class ExpandableCard extends StatefulWidget {
  const ExpandableCard({super.key});

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        height: _expanded ? 220 : 96,
        decoration: BoxDecoration(
          color: _expanded ? Colors.indigo : Colors.indigo.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(_expanded ? 24 : 12),
        child: const Text('Toca para expandir'),
      ),
    );
  }
}
```

Cada `setState` que cambia `_expanded` produce un nuevo `build()` con valores distintos de
`height`, `color` y `padding` — `AnimatedContainer` compara los valores viejo/nuevo e interpola
los tres a la vez, en la misma `duration`. No necesitas tres animaciones separadas.

### 2. El resto de la familia

| Widget | Anima | Caso de uso típico |
|---|---|---|
| `AnimatedOpacity` | `opacity` (0.0–1.0) | Aparecer/desaparecer un elemento sin quitarlo del layout |
| `AnimatedAlign` | `alignment` | Mover un widget dentro de su padre (ej. un indicador que se desliza) |
| `AnimatedPadding` | `padding` | Separación que crece/decrece (ej. indentar un ítem seleccionado) |
| `AnimatedDefaultTextStyle` | `style` de texto | Texto que cambia de tamaño/peso al seleccionarse |
| `AnimatedPositioned` | posición dentro de un `Stack` | Elemento que se desliza dentro de un stack (requiere `Stack` + `Positioned`) |

```dart
AnimatedOpacity(
  duration: const Duration(milliseconds: 200),
  opacity: _isLoading ? 0.4 : 1.0,
  child: const ItemCard(),
)
```

`AnimatedOpacity` **no** remueve el widget del árbol ni de la interacción táctil — solo cambia su
transparencia. Si necesitas que además deje de ser "tocable" cuando está invisible, combínalo con
`IgnorePointer` o `AbsorbPointer`.

### 3. AnimatedSize — cuando no controlas el valor destino

`AnimatedContainer` requiere que tú conozcas el tamaño destino (`height: 220`). Cuando el tamaño
depende del contenido (ej. un texto que puede tener 1 o 5 líneas), usa `AnimatedSize`: envuelve el
child y anima el tamaño que el propio child termine ocupando, sin que tengas que calcularlo.

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 250),
  child: Text(_expanded ? longDescription : shortDescription),
)
```

### 4. El detalle del `key`

Los widgets `Animated*` interpolan mientras el **mismo elemento** siga vivo en el árbol. Si
envuelves el widget en una condición que lo reconstruye desde cero (`if (condicion) WidgetA() else
WidgetB()` sin relación entre ambos), Flutter no tiene "viejo" y "nuevo" que comparar — lo destruye
y lo vuelve a crear sin animación. Esto no aplica a `AnimatedContainer` con las mismas propiedades
cambiando de valor (ese caso sí anima), sino a cuando cambias de **tipo de widget** o de posición
en una lista. Ahí es donde entra `AnimatedSwitcher` (archivo 05) — resuelve exactamente ese caso.

## ✅ Checklist de Verificación

- [ ] Sé qué propiedades puede interpolar `AnimatedContainer` y cómo se disparan (cambiando el
      valor en un rebuild)
- [ ] Conozco al menos tres widgets `Animated*` además de `AnimatedContainer` y su caso de uso
- [ ] Sé cuándo usar `AnimatedSize` en vez de fijar un `height` a mano
- [ ] Entiendo por qué cambiar de tipo de widget rompe la interpolación implícita

## 📚 Próximo paso

[Curves y Duration →](03-curves-y-duration.md)
