# Ejercicio 02 — flutter_secure_storage

> Guardarás, leerás y borrarás un valor con `flutter_secure_storage`, descomentando código paso
> a paso, para comprobar que sobrevive a un hot restart cifrado — a diferencia de una variable en
> memoria.

## 🎯 Objetivos

- Escribir un valor con `FlutterSecureStorage.write()`
- Leer un valor guardado con `FlutterSecureStorage.read()`
- Borrar un valor con `FlutterSecureStorage.delete()`

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

## Paso 1: instancia de FlutterSecureStorage + leer al iniciar

```dart
class _HomeScreenState extends State<HomeScreen> {
  static const _storage = FlutterSecureStorage();
  static const _key = 'demo_token';
  String? _storedValue;

  @override
  void initState() {
    super.initState();
    _storage.read(key: _key).then((value) => setState(() => _storedValue = value));
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: la primera vez que corres la app, el texto muestra "(nada guardado)" — no hay
valor todavía.

---

## Paso 2: guardar un valor

```dart
Future<void> _save() async {
  await _storage.write(key: _key, value: 'token-de-ejemplo-${DateTime.now().second}');
  final value = await _storage.read(key: _key);
  setState(() => _storedValue = value);
}
```

**Descomenta la sección `PASO 2`** y conéctalo al botón "Guardar".

✅ **Verifica**: al presionar "Guardar", el texto cambia a mostrar el valor recién escrito. Haz
un **hot restart** — el valor debe seguir ahí (viene de `initState`, no de memoria).

---

## Paso 3: borrar el valor

```dart
Future<void> _delete() async {
  await _storage.delete(key: _key);
  setState(() => _storedValue = null);
}
```

**Descomenta la sección `PASO 3`** y conéctalo al botón "Borrar".

✅ **Verifica**: al presionar "Borrar", el texto vuelve a "(nada guardado)". Haz un hot restart
de nuevo — debe seguir sin nada guardado (la escritura del borrado también persistió).

---

## ✅ Resultado final

Lectura, escritura y borrado de un valor cifrado con `flutter_secure_storage` — el mismo
mecanismo que usarás para guardar el token de sesión en el proyecto de esta semana, en vez de un
valor de ejemplo.
