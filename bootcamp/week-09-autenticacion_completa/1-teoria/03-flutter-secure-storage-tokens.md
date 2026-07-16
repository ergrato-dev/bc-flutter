# flutter_secure_storage — Persistencia Segura de Tokens

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué un token nunca debe guardarse con `SharedPreferences`/Hive (semana 8)
- Cómo leer y escribir con `flutter_secure_storage`
- Cómo inyectarlo en Riverpod sin necesitar overrides en `main()`

## 📋 Conceptos Clave

### 1. Por qué no SharedPreferences ni Hive

Semana 8 ya lo advirtió: `SharedPreferences` y Hive guardan en **texto plano**. Un token de
sesión es la credencial que le da acceso a la cuenta del usuario a cualquiera que la lea — en
texto plano, queda expuesto en un dispositivo rooteado, un backup no cifrado, o un simple
`adb pull` en un emulador de pruebas.

`flutter_secure_storage` usa el mecanismo de almacenamiento cifrado nativo de cada plataforma:

| Plataforma | Mecanismo |
|---|---|
| iOS/macOS | Keychain |
| Android | Keystore (vía `EncryptedSharedPreferences`) |
| Web | Web Crypto API (menos robusto — evita guardar secretos de producción) |

### 2. API — igual de simple que SharedPreferences

```dart
const storage = FlutterSecureStorage();

await storage.write(key: 'auth_token', value: 'eyJhbGci...');

final token = await storage.read(key: 'auth_token'); // String?

await storage.delete(key: 'auth_token');
```

Toda la API es async (a diferencia de `SharedPreferences`, que solo es async al abrir la
instancia) — cada operación de lectura/escritura pasa por el cifrado nativo.

### 3. Por qué no necesita overrideWithValue() en main()

`SharedPreferences.getInstance()` (semana 8) es async porque carga todo el almacenamiento una
vez a memoria. `FlutterSecureStorage()` es un constructor **síncrono** — no carga nada por
adelantado, cada `read()`/`write()` golpea el cifrado nativo en el momento:

```dart
@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}
```

Este provider no necesita override en `main()` — a diferencia de `sharedPreferencesProvider` e
`itemsCacheBoxProvider` de semana 8, que sí requerían cargar su instancia antes de `runApp()`.

### 4. Consumirlo desde AuthNotifier

```dart
@riverpod
class AuthNotifier extends _$AuthNotifier {
  static const _tokenKey = 'auth_token';

  @override
  Future<String?> build() async {
    final storage = ref.watch(secureStorageProvider);
    return storage.read(key: _tokenKey); // auto-login si ya había sesión
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token = await ref.read(authRepositoryProvider).login(username, password);
      await ref.read(secureStorageProvider).write(key: _tokenKey, value: token);
      return token;
    });
  }
}
```

`build()` lee el token guardado al iniciar la app — si el usuario ya había iniciado sesión antes
(y no cerró sesión), la app arranca autenticada sin pedir login de nuevo.

## ✅ Checklist de Verificación

- [ ] Sé por qué un token nunca debe guardarse con `SharedPreferences`/Hive
- [ ] Sé leer/escribir/borrar con `flutter_secure_storage`
- [ ] Sé por qué `secureStorageProvider` no necesita override en `main()`
- [ ] Sé por qué `build()` de `AuthNotifier` lee el token guardado (auto-login)

## 📚 Próximo paso

[Interceptor de Autenticación con Dio →](04-interceptor-de-autenticacion-con-dio.md)
