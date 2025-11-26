# 🔐 Seguridad de API Keys

## ⚠️ Lo Que NUNCA Debes Hacer

```dart
// ❌ NUNCA hardcodear API keys
const apiKey = 'sk_live_abc123xyz789';

// ❌ NUNCA commitear a Git
class Config {
  static const newsApiKey = 'real_api_key_here';
}

// ❌ NUNCA exponer en código cliente
final url = 'https://api.example.com/data?api_key=secret123';
```

---

## ✅ Métodos Seguros

### 1. Variables de Entorno (Desarrollo)

```yaml
# pubspec.yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

```dart
// .env (NO commitear)
NEWS_API_KEY=tu_api_key_aqui
WEATHER_API_KEY=otra_api_key
```

```dart
// main.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

// Uso
final apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
```

```gitignore
# .gitignore
.env
.env.local
.env.production
```

### 2. Dart Define (Build time)

```bash
# Compilar con variables
flutter build apk --dart-define=API_KEY=tu_api_key

# O múltiples
flutter run --dart-define=API_KEY=key1 --dart-define=OTHER_KEY=key2
```

```dart
// En código
const apiKey = String.fromEnvironment('API_KEY');

// Con valor por defecto
const apiKey = String.fromEnvironment(
  'API_KEY',
  defaultValue: 'development_key',
);
```

### 3. Archivo de Configuración Ignorado

```dart
// lib/config/api_keys.dart (NO commitear)
class ApiKeys {
  static const newsApi = 'tu_api_key';
  static const weatherApi = 'otra_api_key';
}
```

```dart
// lib/config/api_keys.example.dart (SÍ commitear)
/// Copia este archivo como api_keys.dart y agrega tus keys
class ApiKeys {
  static const newsApi = 'YOUR_NEWS_API_KEY_HERE';
  static const weatherApi = 'YOUR_WEATHER_API_KEY_HERE';
}
```

```gitignore
# .gitignore
lib/config/api_keys.dart
```

---

## 🔒 Mejores Prácticas

### Backend Proxy (Más Seguro)

```
App Flutter → Tu Backend → API Externa
              (tiene la key)
```

```dart
// En lugar de llamar directamente a la API externa
// final url = 'https://newsapi.org/v2/news?apiKey=SECRET';

// Llamar a tu propio backend
final url = 'https://tu-backend.com/api/news';
// Tu backend agrega la API key de forma segura
```

### Ofuscación (Mínima Seguridad)

```dart
// Algo de ofuscación (NO es seguridad real)
class SecureStorage {
  static String get apiKey {
    // Encoded: tu_api_key_real
    const encoded = 'dHVfYXBpX2tleV9yZWFs';
    return utf8.decode(base64Decode(encoded));
  }
}
```

**⚠️ Nota:** Esto NO es seguro. Cualquiera puede decompilar la app y extraer la key. Es solo para evitar exposición accidental en código.

### Flutter Secure Storage

```yaml
dependencies:
  flutter_secure_storage: ^9.0.0
```

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureKeyStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveApiKey(String key) async {
    await _storage.write(key: 'api_key', value: key);
  }

  Future<String?> getApiKey() async {
    return await _storage.read(key: 'api_key');
  }

  Future<void> deleteApiKey() async {
    await _storage.delete(key: 'api_key');
  }
}
```

---

## 📋 Checklist de Seguridad

### Antes de Commitear

```
□ .env está en .gitignore
□ api_keys.dart está en .gitignore
□ No hay keys hardcodeadas en el código
□ Revisar git diff antes de push
□ Usar git-secrets o similar
```

### En Producción

```
□ API keys en variables de entorno del servidor
□ Usar backend proxy para APIs sensibles
□ Rate limiting en tu backend
□ Monitorear uso de API
□ Rotar keys periódicamente
```

### Si Se Expone Una Key

```
1. Revocar la key inmediatamente
2. Generar una nueva key
3. Revisar logs por uso no autorizado
4. Actualizar la app con la nueva key
5. Revisar historial de Git y limpiar si es necesario
```

---

## 🛠️ Herramientas

### git-secrets

Previene commitear secretos accidentalmente.

```bash
# Instalar
brew install git-secrets

# Configurar en repo
git secrets --install
git secrets --register-aws

# Agregar patrones personalizados
git secrets --add 'api[_-]?key[_-]?=["\'][a-zA-Z0-9]+'
```

### Gitleaks

Scanner de secretos en repositorios.

```bash
# Escanear repo
gitleaks detect --source . --verbose
```

### truffleHog

Busca secrets en historial de Git.

```bash
# Escanear
trufflehog git file://. --since-commit HEAD~50
```

---

## 📊 Niveles de Seguridad

| Nivel    | Método           | Seguridad | Uso               |
| -------- | ---------------- | --------- | ----------------- |
| 🔴 Bajo  | Hardcoded        | ❌        | Nunca             |
| 🟠 Medio | .env / gitignore | ⚠️        | Desarrollo        |
| 🟡 Medio | Dart Define      | ⚠️        | CI/CD             |
| 🟢 Alto  | Backend Proxy    | ✅        | Producción        |
| 🟢 Alto  | Secure Storage   | ✅        | Tokens de usuario |

---

## 💡 Resumen

```dart
// ❌ MAL
const apiKey = 'sk_live_secret_key';

// ⚠️ MEJOR (desarrollo)
final apiKey = dotenv.env['API_KEY']!;

// ✅ MEJOR (producción)
const apiKey = String.fromEnvironment('API_KEY');

// ✅ MEJOR (sensible)
// Llamar a tu backend que tiene la key segura
final response = await dio.get('/api/proxy/news');
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
