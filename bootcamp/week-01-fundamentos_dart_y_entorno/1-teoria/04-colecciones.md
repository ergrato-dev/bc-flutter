# Colecciones: List, Set y Map

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo crear y manipular `List`, `Set` y `Map`
- Los operadores de colección: spread (`...`), `if` y `for` dentro de literales
- Los métodos funcionales más usados: `map`, `where`, `fold`

## 📋 Conceptos Clave

### 1. List

```dart
final fruits = <String>['manzana', 'pera', 'uva'];

fruits.add('mango');
fruits.remove('pera');

print(fruits.first);       // 'manzana'
print(fruits.length);      // 3
print(fruits.contains('uva')); // true

// Lista inmutable (no se puede modificar después de crearla)
const readonlyTags = ['dart', 'flutter'];
```

### 2. Set — colección sin duplicados

```dart
final uniqueTags = <String>{'dart', 'flutter', 'dart'}; // {'dart', 'flutter'}

uniqueTags.add('mobile');
print(uniqueTags.contains('flutter')); // true
```

> 💡 **Cuándo usar Set vs List**: usa `Set` cuando el orden no importa y necesitas garantizar
> que no haya elementos repetidos (por ejemplo, IDs seleccionados en una lista con checkboxes).

### 3. Map — pares clave-valor

```dart
final stock = <String, int>{
  'manzana': 50,
  'pera': 30,
};

stock['mango'] = 10;           // agregar
print(stock['manzana']);       // 50
print(stock.containsKey('uva')); // false

// Iterar un Map
stock.forEach((product, quantity) {
  print('$product: $quantity unidades');
});
```

### 4. Operadores de colección

```dart
final base = ['a', 'b'];
final extended = [...base, 'c', 'd']; // spread: ['a', 'b', 'c', 'd']

final includeExtra = true;
final conditional = [
  'siempre',
  if (includeExtra) 'extra', // collection-if
];

final numbers = [
  for (var i = 1; i <= 3; i++) i * 10, // collection-for → [10, 20, 30]
];
```

### 5. Métodos funcionales

```dart
final prices = [10, 25, 8, 40];

final withTax = prices.map((p) => p * 1.19).toList(); // transformar
final expensive = prices.where((p) => p > 15).toList(); // filtrar
final total = prices.fold<int>(0, (sum, p) => sum + p); // reducir

print(total); // 83
```

> 💡 **Casos de uso móvil**: `ListView.builder` (semana 2) recorre exactamente este tipo de
> colecciones — dominar `map`/`where` ahora te ahorra lógica repetida después.

## ⚠️ Errores Comunes

- Modificar una lista mientras la recorres con `for-in` (usa `.toList()` sobre una copia si
  necesitas mutar durante la iteración).
- Usar `List` cuando en realidad necesitas unicidad garantizada (usa `Set`).
- Olvidar `.toList()` al final de una cadena `map`/`where` — ambos retornan un `Iterable`
  perezoso, no una `List`.

## 📚 Recursos Adicionales

- [Dart — Collections](https://dart.dev/language/collections)

## ✅ Checklist de Verificación

- [ ] Sé cuándo usar List, Set o Map según el problema
- [ ] Puedo usar spread, collection-if y collection-for
- [ ] Puedo encadenar `map`/`where`/`fold` para transformar colecciones
