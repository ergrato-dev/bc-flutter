# Ejercicio 01 — SharedPreferences Básico

> Persistirás un contador simple con `SharedPreferences`, descomentando código paso a paso, para
> comprobar que sobrevive a un reinicio completo de la app.

## 🎯 Objetivos

- Cargar `SharedPreferences` antes de `runApp()` con `main()` async
- Leer un valor guardado al iniciar la app
- Escribir un valor cada vez que cambia

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: main() async + SharedPreferences.getInstance()

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — reemplaza el `main()` actual
y agrega el parámetro `prefs` a `MyApp` y `HomeScreen`.

---

## Paso 2: leer el valor guardado al iniciar

```dart
class _HomeScreenState extends State<HomeScreen> {
  late int _counter = widget.prefs.getInt('counter') ?? 0;

  // ...
}
```

**Descomenta la sección `PASO 2`** — reemplaza la inicialización de `_counter`.

✅ **Verifica**: la primera vez que corres la app, el contador arranca en `0` (no hay nada
guardado todavía).

---

## Paso 3: escribir el valor en cada cambio

```dart
void _increment() {
  setState(() => _counter++);
  widget.prefs.setInt('counter', _counter);
}
```

**Descomenta la sección `PASO 3`** y conecta `_increment` al `FloatingActionButton`.

✅ **Verifica**: presiona el botón varias veces, luego haz un **hot restart** (no hot reload —
`Shift+R` en la terminal, o el botón de restart en tu IDE). El contador debe mantener el valor
en vez de volver a `0`, porque hot restart reinicia el estado de Dart pero no borra el
almacenamiento persistente del dispositivo.

---

## ✅ Resultado final

Un contador que persiste entre reinicios completos de la app usando `SharedPreferences` — la
base que extenderás en el ejercicio 02 con Hive para datos más estructurados.
