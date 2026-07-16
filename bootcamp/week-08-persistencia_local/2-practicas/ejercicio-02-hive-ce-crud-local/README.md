# Ejercicio 02 — Hive/hive_ce CRUD Local

> Construirás una lista de notas persistida con un `Box` de Hive, con la UI actualizándose sola
> vía `box.listenable()`, descomentando código paso a paso.

## 🎯 Objetivos

- Abrir un `Box` con `Hive.initFlutter()` + `Hive.openBox()`
- Agregar y eliminar valores de un `Box` (`box.add()`, `box.deleteAt()`)
- Reconstruir la UI automáticamente al cambiar el `Box` con `ValueListenableBuilder` +
  `box.listenable()`

## 📋 Requisitos

- Ejercicio 01 completado
- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: Hive.initFlutter() + Hive.openBox()

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final notesBox = await Hive.openBox<String>('notes');
  runApp(MyApp(notesBox: notesBox));
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — reemplaza el `main()` actual
y agrega el parámetro `notesBox` a `MyApp` y `HomeScreen`.

---

## Paso 2: agregar una nota con box.add()

```dart
void _addNote(String text) {
  if (text.trim().isEmpty) return;
  widget.notesBox.add(text.trim());
  _controller.clear();
}
```

**Descomenta la sección `PASO 2`** y conéctalo al botón "Agregar" junto al `TextField`.

`box.add()` asigna una clave numérica autoincremental — no necesitas generarla tú.

✅ **Verifica**: al escribir una nota y presionar "Agregar", el campo de texto se limpia.

---

## Paso 3: lista reactiva con box.listenable() + eliminar

```dart
ValueListenableBuilder(
  valueListenable: widget.notesBox.listenable(),
  builder: (context, Box<String> box, _) {
    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(box.getAt(index) ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => box.deleteAt(index),
        ),
      ),
    );
  },
)
```

**Descomenta la sección `PASO 3`** y reemplaza el `Placeholder` del body por este widget.

`box.listenable()` es un `ValueListenable` — `ValueListenableBuilder` reconstruye la lista solo
cuando el contenido del Box cambia, sin necesitar `setState()` manual en `_addNote()` ni en la
eliminación.

✅ **Verifica**: agrega 2-3 notas, elimina una con el ícono de basura, y haz un **hot restart**
— las notas restantes deben seguir ahí.

---

## ✅ Resultado final

Una lista de notas persistida en un `Box` de Hive, con la UI reaccionando automáticamente a los
cambios — la base del cache que construirás en el ejercicio 03 combinando Hive con Dio.
