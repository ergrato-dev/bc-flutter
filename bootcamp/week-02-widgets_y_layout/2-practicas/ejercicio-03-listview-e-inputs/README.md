# Ejercicio 03 — ListView, TextField y Filtrado

> Construirás una lista con buscador: `ListView.builder` + `TextField` + `setState`,
> descomentando código paso a paso. Es el ejercicio más largo de la semana — integra
> casi todo lo visto hasta ahora.

## 🎯 Objetivos

- Renderizar una colección con `ListView.builder` y `ListTile`
- Capturar texto con `TextField` + `TextEditingController`
- Filtrar la lista en tiempo real según el texto ingresado

## 📋 Requisitos

- Ejercicios 01 y 02 completados

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: ListView.builder con datos estáticos

```dart
ListView.builder(
  itemCount: _allItems.length,
  itemBuilder: (context, index) {
    final item = _allItems[index];
    return ListTile(title: Text(item));
  },
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: debe verse una lista de 6 elementos de ejemplo, con scroll si no caben.

---

## Paso 2: TextField para capturar la búsqueda

```dart
TextField(
  controller: _searchController,
  decoration: const InputDecoration(labelText: 'Buscar', prefixIcon: Icon(Icons.search)),
  onChanged: (value) => setState(() => _query = value),
)
```

**Descomenta la sección `PASO 2`** (agrega el `TextField` arriba del `ListView.builder`, dentro
de una `Column`).

✅ **Verifica**: al escribir, el texto en `_query` debe actualizarse (agrega un `print` temporal
si quieres confirmarlo, aunque el paso 3 ya lo hace visible).

---

## Paso 3: Filtrar la lista según `_query`

```dart
final filtered = _allItems
    .where((item) => item.toLowerCase().contains(_query.toLowerCase()))
    .toList();
```

**Descomenta la sección `PASO 3`** y usa `filtered` (en vez de `_allItems`) como fuente del
`ListView.builder`.

✅ **Verifica**: al escribir texto que coincide con algún elemento, la lista se reduce en tiempo
real. Si no hay coincidencias, la lista debe quedar vacía (sin errores).

---

## ✅ Resultado final

Una pantalla con buscador funcional sobre una lista de 6 elementos — la misma mecánica que
implementarás en el proyecto de esta semana sobre tu dominio asignado.
