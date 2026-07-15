# Listas con ListView

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cuándo usar `ListView` vs `ListView.builder`
- Por qué `ListView.builder` es la opción correcta para listas de datos
- Cómo hacer scroll de contenido que no cabe en pantalla

## 📋 Conceptos Clave

### 1. ListView simple

```dart
ListView(
  children: const [
    ListTile(title: Text('Elemento 1')),
    ListTile(title: Text('Elemento 2')),
    ListTile(title: Text('Elemento 3')),
  ],
)
```

Útil cuando la lista es corta y conocida de antemano (un menú de configuración, por ejemplo).

### 2. ListView.builder — la forma correcta para datos dinámicos

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.id),
    );
  },
)
```

> 💡 **Por qué `.builder` y no `ListView(children: items.map(...).toList())`**: `.builder`
> construye **solo** los widgets visibles en pantalla (más algunos de margen), en vez de crear
> los mil elementos de una lista larga de una sola vez. Es el equivalente conceptual de
> `FlatList` en React Native — misma razón de ser: rendimiento con listas grandes.

### 3. ListTile: la fila de lista estándar de Material

```dart
ListTile(
  leading: const CircleAvatar(child: Icon(Icons.person)),
  title: const Text('Nombre'),
  subtitle: const Text('Descripción breve'),
  trailing: const Icon(Icons.chevron_right),
  onTap: () => debugPrint('Tocaste el elemento'),
)
```

`ListTile` ya resuelve el layout típico ícono-título-subtítulo-flecha sin que tengas que armarlo
a mano con `Row`/`Column` — pero puedes reemplazarlo con tu propio widget cuando el diseño lo
requiera (lo harás en el proyecto de esta semana).

### 4. SingleChildScrollView

```dart
SingleChildScrollView(
  child: Column(
    children: [/* contenido más alto que la pantalla */],
  ),
)
```

Para contenido que no es una lista repetitiva pero puede no caber en pantalla (un formulario
largo, por ejemplo). No uses esto para listas de datos — ahí siempre `ListView.builder`.

## ⚠️ Errores Comunes

- Usar `ListView` con `children: items.map(...).toList()` para listas potencialmente largas —
  siempre `ListView.builder` en ese caso.
- Poner un `ListView` dentro de una `Column` sin restricción de altura — Flutter lanza una
  excepción de layout porque ambos "quieren" ocupar todo el alto disponible. Solución: envolver
  el `ListView` en `Expanded` dentro de la `Column`.
- Olvidar `keyExtractor`-equivalente en Flutter: usar `key: ValueKey(item.id)` en el widget raíz
  de `itemBuilder` cuando la lista puede reordenarse o filtrarse, para que Flutter identifique
  correctamente cada fila.

## 📚 Recursos Adicionales

- [Flutter — Working with lists](https://docs.flutter.dev/cookbook/lists/basic-list)
- [Flutter — ListView.builder](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html)

## ✅ Checklist de Verificación

- [ ] Sé cuándo usar ListView vs ListView.builder
- [ ] Puedo construir una lista a partir de una colección de datos
- [ ] Sé resolver el error de un ListView dentro de una Column sin Expanded
