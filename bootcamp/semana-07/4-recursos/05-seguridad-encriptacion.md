# 🔒 Seguridad y Encriptación de Datos

## 📋 Guía de Seguridad

> Mejores prácticas para proteger datos sensibles en aplicaciones Flutter.

---

## 🎯 Niveles de Sensibilidad

### Clasificación de Datos

| Nivel | Tipo de Datos | Almacenamiento Recomendado |
|-------|---------------|---------------------------|
| 🔴 **Alto** | Contraseñas, tokens, claves API | Flutter Secure Storage |
| 🟠 **Medio** | Datos personales (email, teléfono) | Hive encriptado / SQLCipher |
| 🟡 **Bajo** | Preferencias, configuración | SharedPreferences / Hive |
| 🟢 **Público** | Datos de la app, cache | Cualquier método |

---

## 🔐 Flutter Secure Storage

### Setup

```yaml
# pubspec.yaml
dependencies:
  flutter_secure_storage: ^9.0.0
```

### Uso Básico

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio de almacenamiento seguro
class SecureStorageService {
  // Configuración con opciones de seguridad
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  // Claves de almacenamiento
  static const _keyToken = 'auth_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyApiKey = 'api_key';
  static const _keyUserCredentials = 'user_credentials';
  
  // === TOKEN DE AUTENTICACIÓN ===
  
  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }
  
  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }
  
  Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }
  
  // === REFRESH TOKEN ===
  
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _keyRefreshToken, value: token);
  }
  
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }
  
  // === CREDENCIALES DE USUARIO ===
  
  Future<void> saveCredentials({
    required String email,
    required String password,
  }) async {
    final credentials = jsonEncode({
      'email': email,
      'password': password,
    });
    await _storage.write(key: _keyUserCredentials, value: credentials);
  }
  
  Future<Map<String, String>?> getCredentials() async {
    final data = await _storage.read(key: _keyUserCredentials);
    if (data == null) return null;
    
    final decoded = jsonDecode(data) as Map<String, dynamic>;
    return {
      'email': decoded['email'] as String,
      'password': decoded['password'] as String,
    };
  }
  
  // === OPERACIONES GENERALES ===
  
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
  
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
  
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
```

### Configuración Avanzada

```dart
/// Opciones de seguridad por plataforma
const storage = FlutterSecureStorage(
  // Android
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
    sharedPreferencesName: 'secure_prefs',
    preferencesKeyPrefix: 'app_',
  ),
  
  // iOS
  iOptions: IOSOptions(
    groupId: 'group.com.example.app', // Para compartir entre apps
    accessibility: KeychainAccessibility.first_unlock,
    synchronizable: false, // No sincronizar con iCloud
  ),
  
  // Linux
  lOptions: LinuxOptions(),
  
  // Windows  
  wOptions: WindowsOptions(),
  
  // Web (menos seguro)
  webOptions: WebOptions(
    dbName: 'secure_storage',
    publicKey: 'your_public_key',
  ),
);
```

---

## 🗄️ SQLite con Encriptación (SQLCipher)

### Setup

```yaml
# pubspec.yaml
dependencies:
  sqflite_sqlcipher: ^2.2.1
  # Reemplaza sqflite normal
```

### Implementación

```dart
import 'package:sqflite_sqlcipher/sqflite.dart';

/// Base de datos encriptada con SQLCipher
class SecureDatabase {
  static const String _dbName = 'secure_app.db';
  static const int _dbVersion = 1;
  
  // La clave debe guardarse en Secure Storage
  static late String _encryptionKey;
  
  static Database? _database;
  
  /// Inicializar con clave de encriptación
  static Future<void> initialize(String key) async {
    _encryptionKey = key;
  }
  
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    
    return openDatabase(
      path,
      version: _dbVersion,
      password: _encryptionKey, // Clave de encriptación
      onCreate: _onCreate,
    );
  }
  
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sensitive_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT NOT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}

/// Uso con generación segura de clave
class SecureDatabaseManager {
  final SecureStorageService _secureStorage;
  static const _dbKeyName = 'db_encryption_key';
  
  SecureDatabaseManager(this._secureStorage);
  
  Future<void> initializeDatabase() async {
    // Obtener o generar clave
    String? key = await _secureStorage.read(key: _dbKeyName);
    
    if (key == null) {
      // Generar clave segura
      key = _generateSecureKey();
      await _secureStorage.write(key: _dbKeyName, value: key);
    }
    
    await SecureDatabase.initialize(key);
  }
  
  String _generateSecureKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }
}
```

---

## 📦 Hive con Encriptación

### Implementación

```dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio para boxes encriptados de Hive
class SecureHiveService {
  static const _secureStorage = FlutterSecureStorage();
  static const _hiveKeyName = 'hive_encryption_key';
  
  /// Obtener o generar clave de encriptación
  static Future<List<int>> _getEncryptionKey() async {
    final keyString = await _secureStorage.read(key: _hiveKeyName);
    
    if (keyString != null) {
      return base64Decode(keyString);
    }
    
    // Generar nueva clave
    final key = Hive.generateSecureKey();
    await _secureStorage.write(
      key: _hiveKeyName,
      value: base64Encode(key),
    );
    return key;
  }
  
  /// Abrir box encriptado
  static Future<Box<T>> openSecureBox<T>(String name) async {
    final key = await _getEncryptionKey();
    return await Hive.openBox<T>(
      name,
      encryptionCipher: HiveAesCipher(key),
    );
  }
  
  /// Abrir LazyBox encriptado
  static Future<LazyBox<T>> openSecureLazyBox<T>(String name) async {
    final key = await _getEncryptionKey();
    return await Hive.openLazyBox<T>(
      name,
      encryptionCipher: HiveAesCipher(key),
    );
  }
}

// Uso
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  // Registrar adapters
  Hive.registerAdapter(SensitiveDataAdapter());
  
  // Abrir box encriptado
  final secureBox = await SecureHiveService.openSecureBox<SensitiveData>('secure_data');
  
  runApp(MyApp());
}
```

---

## 🔑 Gestión de Claves

### Patrón de Rotación de Claves

```dart
/// Servicio de gestión de claves con rotación
class KeyManagementService {
  final FlutterSecureStorage _storage;
  
  static const _currentKeyName = 'current_encryption_key';
  static const _keyVersionName = 'key_version';
  static const _keyRotationDays = 90; // Rotar cada 90 días
  
  KeyManagementService(this._storage);
  
  /// Verificar si necesita rotación
  Future<bool> needsKeyRotation() async {
    final versionStr = await _storage.read(key: _keyVersionName);
    if (versionStr == null) return false;
    
    final version = int.tryParse(versionStr) ?? 0;
    final lastRotation = DateTime.fromMillisecondsSinceEpoch(version);
    final daysSinceRotation = DateTime.now().difference(lastRotation).inDays;
    
    return daysSinceRotation >= _keyRotationDays;
  }
  
  /// Rotar clave (requiere re-encriptar datos)
  Future<void> rotateKey({
    required Future<void> Function(String oldKey, String newKey) reEncryptData,
  }) async {
    // Obtener clave actual
    final oldKey = await _storage.read(key: _currentKeyName);
    if (oldKey == null) return;
    
    // Generar nueva clave
    final newKey = _generateSecureKey();
    
    // Re-encriptar datos con callback
    await reEncryptData(oldKey, newKey);
    
    // Guardar nueva clave
    await _storage.write(key: _currentKeyName, value: newKey);
    await _storage.write(
      key: _keyVersionName,
      value: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }
  
  String _generateSecureKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }
}
```

---

## 🛡️ Encriptación de Datos en Tránsito

### Encriptar Antes de Guardar

```dart
import 'package:encrypt/encrypt.dart' as encrypt;

/// Servicio de encriptación AES
class EncryptionService {
  late final encrypt.Key _key;
  late final encrypt.IV _iv;
  late final encrypt.Encrypter _encrypter;
  
  EncryptionService(String keyString) {
    // Clave de 32 bytes para AES-256
    _key = encrypt.Key.fromUtf8(keyString.padRight(32).substring(0, 32));
    _iv = encrypt.IV.fromLength(16);
    _encrypter = encrypt.Encrypter(encrypt.AES(_key));
  }
  
  /// Encriptar texto
  String encryptText(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }
  
  /// Desencriptar texto
  String decryptText(String encryptedText) {
    final encrypted = encrypt.Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
  
  /// Encriptar objeto JSON
  String encryptJson(Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    return encryptText(jsonString);
  }
  
  /// Desencriptar a JSON
  Map<String, dynamic> decryptJson(String encrypted) {
    final jsonString = decryptText(encrypted);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
}

// Uso
final encryption = EncryptionService(await getSecureKey());

// Encriptar datos sensibles antes de guardar
final sensitiveData = {'ssn': '123-45-6789', 'creditCard': '4111111111111111'};
final encrypted = encryption.encryptJson(sensitiveData);

// Guardar en cualquier storage (ya está encriptado)
await prefs.setString('encrypted_data', encrypted);
```

---

## 📱 Seguridad por Plataforma

### Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<application
    android:allowBackup="false"
    android:fullBackupContent="false"
    android:dataExtractionRules="@xml/data_extraction_rules">
    <!-- ... -->
</application>
```

```xml
<!-- android/app/src/main/res/xml/data_extraction_rules.xml -->
<?xml version="1.0" encoding="utf-8"?>
<data-extraction-rules>
    <cloud-backup>
        <exclude domain="sharedpref" path="." />
        <exclude domain="database" path="." />
        <exclude domain="file" path="." />
    </cloud-backup>
</data-extraction-rules>
```

### iOS

```swift
// ios/Runner/AppDelegate.swift
// Excluir de backup de iCloud
func excludeFromBackup(url: URL) {
    var resourceValues = URLResourceValues()
    resourceValues.isExcludedFromBackup = true
    try? (url as NSURL).setResourceValue(true, forKey: .isExcludedFromBackupKey)
}
```

---

## ⚠️ Anti-Patrones de Seguridad

### ❌ NO Hacer

```dart
// ❌ NUNCA guardar contraseñas en SharedPreferences
await prefs.setString('password', 'mi_contraseña');

// ❌ NUNCA hardcodear claves API
const apiKey = 'sk-1234567890abcdef';

// ❌ NUNCA loggear datos sensibles
print('Token: $token');
debugPrint('Contraseña: $password');

// ❌ NUNCA transmitir sin HTTPS
http.get(Uri.parse('http://api.example.com/user'));

// ❌ NUNCA guardar claves de encriptación en código
const encryptionKey = 'my-secret-key-123';
```

### ✅ SÍ Hacer

```dart
// ✅ Usar Secure Storage para contraseñas
await secureStorage.write(key: 'password', value: password);

// ✅ Usar variables de entorno para claves API
final apiKey = const String.fromEnvironment('API_KEY');

// ✅ Nunca loggear datos sensibles
// (simplemente no hacerlo)

// ✅ Siempre usar HTTPS
http.get(Uri.parse('https://api.example.com/user'));

// ✅ Generar y almacenar claves de forma segura
final key = await secureStorage.read(key: 'encryption_key');
```

---

## 📋 Checklist de Seguridad

### Almacenamiento
- [ ] Datos sensibles en Secure Storage
- [ ] Bases de datos encriptadas para datos personales
- [ ] Sin claves hardcodeadas en código
- [ ] Backup deshabilitado para datos sensibles

### Transmisión
- [ ] Siempre usar HTTPS
- [ ] Validar certificados SSL
- [ ] No transmitir datos sensibles en URLs

### Código
- [ ] No loggear datos sensibles
- [ ] Ofuscar código en release
- [ ] Variables de entorno para configuración sensible

### General
- [ ] Rotación periódica de claves
- [ ] Mínimo privilegio (solo datos necesarios)
- [ ] Limpieza de datos al cerrar sesión

---

## 🔍 Auditoría de Seguridad

```dart
/// Herramienta de auditoría de seguridad
class SecurityAudit {
  static Future<List<String>> runAudit() async {
    final issues = <String>[];
    
    // Verificar que no hay datos sensibles en prefs normales
    final prefs = await SharedPreferences.getInstance();
    final suspiciousKeys = ['password', 'token', 'secret', 'api_key', 'credit_card'];
    
    for (final key in prefs.getKeys()) {
      if (suspiciousKeys.any((s) => key.toLowerCase().contains(s))) {
        issues.add('⚠️ Posible dato sensible en SharedPreferences: $key');
      }
    }
    
    // Verificar encriptación de Hive boxes sensibles
    // ... más checks
    
    return issues;
  }
}
```

---

> 📌 **Regla de Oro**: Si dudas si un dato es sensible, trátalo como si lo fuera. Mejor sobre-proteger que sub-proteger.
