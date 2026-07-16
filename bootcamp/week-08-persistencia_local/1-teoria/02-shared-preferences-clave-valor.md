# SharedPreferences — Clave-Valor Simple

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo leer y escribir valores primitivos con `SharedPreferences`
- Por qué su API es asíncrona para abrir la instancia, pero síncrona para leer/escribir
- Cómo inyectar una instancia ya cargada en Riverpod sin volver async un provider síncrono

## 📋 Conceptos Clave

### 1. API básica

```dart
final prefs = await SharedPreferences.getInstance();

await prefs.setString('username', 'erick');
await prefs.setBool('dark_mode', true);
await prefs.setStringList('favorite_ids', ['1', '3', '7']);

final username = prefs.getString('username'); // String?
final darkMode = prefs.getBool('dark_mode') ?? false;
final favoriteIds = prefs.getStringList('favorite_ids') ?? const [];
```

Solo acepta tipos primitivos: `String`, `int`, `double`, `bool`, `List<String>`. Para guardar un
objeto más complejo, tienes dos opciones: serializarlo a JSON con `jsonEncode`/`jsonDecode` y
guardarlo como `String`, o usar Hive (siguiente archivo) directamente.

### 2. Async solo para abrir la instancia

`SharedPreferences.getInstance()` es la única operación async — internamente lee todo el
almacenamiento una vez y lo cachea en memoria. A partir de ahí, `getString()`, `setBool()`, etc.
leen de esa copia en memoria de forma síncrona (el "escribir a disco" ocurre en segundo plano).

Esto importa para Riverpod: si abrieras la instancia dentro de un provider, ese provider tendría
que ser un `FutureProvider` — y todo lo que dependa de él (como `FavoritesNotifier`) también
terminaría siendo async, complicando cada `ref.watch()` con `.when()`.

### 3. El patrón: cargar antes de runApp(), inyectar con overrides

La solución estándar de Riverpod es abrir la instancia **antes** de `runApp()`, y pasarla ya
resuelta al árbol de providers:

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}
```

```dart
// providers/shared_preferences_provider.dart
@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Debe sobreescribirse en main() — ver overrides de ProviderScope.');
}
```

El provider "real" nunca se ejecuta — `overrideWithValue()` reemplaza su resultado directamente.
Esto mantiene cualquier provider que dependa de `sharedPreferencesProvider` completamente
síncrono, porque para cuando Riverpod los construye, la instancia ya está cargada en memoria.

### 4. Consumirlo desde otro provider

```dart
@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  static const _prefsKey = 'favorite_ids';

  @override
  Set<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return (prefs.getStringList(_prefsKey) ?? const []).toSet();
  }

  void toggle(String id) {
    state = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
    ref.read(sharedPreferencesProvider).setStringList(_prefsKey, state.toList());
  }
}
```

`toggle()` no espera (`await`) la escritura a disco — actualiza el estado en memoria de
inmediato para que la UI responda al toque, y la escritura ocurre en segundo plano. Es el mismo
principio de "no bloquear la UI por I/O" que ya aplicaste con Dio.

## ✅ Checklist de Verificación

- [ ] Sé leer/escribir valores primitivos con `SharedPreferences`
- [ ] Sé explicar por qué solo `getInstance()` es async, no el resto de la API
- [ ] Sé cargar `SharedPreferences` antes de `runApp()` e inyectarla con
      `overrideWithValue()`
- [ ] Sé por qué `toggle()` no espera la escritura a disco antes de actualizar el estado

## 📚 Próximo paso

[Hive/hive_ce — NoSQL Local →](03-hive-ce-nosql-local.md)
