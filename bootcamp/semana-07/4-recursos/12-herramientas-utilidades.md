# 🛠️ Herramientas y Utilidades

## 📋 Herramientas de Desarrollo

> Colección de herramientas útiles para trabajar con persistencia de datos.

---

## 🗄️ Visualizadores de Base de Datos

### DB Browser for SQLite

**Descripción**: Editor visual para bases de datos SQLite

| Característica  | Descripción                              |
| --------------- | ---------------------------------------- |
| **Plataformas** | Windows, macOS, Linux                    |
| **Precio**      | Gratuito (Open Source)                   |
| **Funciones**   | Ver/editar datos, ejecutar SQL, exportar |

**Instalación**:

```bash
# macOS
brew install --cask db-browser-for-sqlite

# Ubuntu/Debian
sudo apt install sqlitebrowser

# Windows
# Descargar desde sqlitebrowser.org
```

**Link**: [sqlitebrowser.org](https://sqlitebrowser.org/)

---

### DBeaver

**Descripción**: Cliente universal de bases de datos

| Característica  | Descripción                             |
| --------------- | --------------------------------------- |
| **Plataformas** | Windows, macOS, Linux                   |
| **Precio**      | Community Edition gratuita              |
| **Funciones**   | Multi-database, SQL editor, ER diagrams |

**Link**: [dbeaver.io](https://dbeaver.io/)

---

### SQLite Viewer (VS Code Extension)

**Descripción**: Ver bases de datos SQLite directamente en VS Code

| Característica | Descripción                  |
| -------------- | ---------------------------- |
| **ID**         | `alexcvzz.vscode-sqlite`     |
| **Funciones**  | Ver tablas, ejecutar queries |

**Instalación**:

```
ext install alexcvzz.vscode-sqlite
```

---

## 📱 Herramientas de Debugging

### Flutter DevTools

**Descripción**: Suite oficial de debugging para Flutter

| Característica  | Uso                     |
| --------------- | ----------------------- |
| **Network**     | Ver requests HTTP       |
| **Memory**      | Detectar memory leaks   |
| **Performance** | Análisis de rendimiento |
| **Logging**     | Ver logs de la app      |

**Acceso**:

```bash
# Desde terminal
flutter pub global activate devtools
dart devtools

# Desde VS Code
# Clic en "Open DevTools" en la barra de debug
```

---

### Android Studio Database Inspector

**Descripción**: Inspector de bases de datos integrado

| Característica | Descripción                                               |
| -------------- | --------------------------------------------------------- |
| **Acceso**     | View > Tool Windows > App Inspection > Database Inspector |
| **Funciones**  | Ver DB en tiempo real, ejecutar queries                   |
| **Requisitos** | API 26+                                                   |

---

### Flipper

**Descripción**: Plataforma de debugging para mobile

| Plugin                | Funcionalidad         |
| --------------------- | --------------------- |
| **Database**          | Ver SQLite databases  |
| **SharedPreferences** | Ver key-value storage |
| **Network**           | Inspeccionar requests |

**Link**: [fbflipper.com](https://fbflipper.com/)

---

## 🔧 Extensiones de VS Code

### Recomendadas para Persistencia

| Extensión     | ID                       | Uso             |
| ------------- | ------------------------ | --------------- |
| SQLite Viewer | `alexcvzz.vscode-sqlite` | Ver SQLite      |
| SQLTools      | `mtxr.sqltools`          | Editor SQL      |
| Dart          | `dart-code.dart-code`    | Soporte Dart    |
| Flutter       | `dart-code.flutter`      | Soporte Flutter |
| Hive Support  | Community                | Snippets Hive   |

### Configuración settings.json

```json
{
  "dart.flutterSdkPath": "/path/to/flutter",
  "editor.formatOnSave": true,
  "dart.lineLength": 80,
  "[dart]": {
    "editor.rulers": [80],
    "editor.tabSize": 2
  }
}
```

---

## 📊 Generadores de Código

### build_runner

**Descripción**: Ejecutor de generadores de código

**Comandos útiles**:

```bash
# Generar una vez
dart run build_runner build

# Modo watch (regenera automáticamente)
dart run build_runner watch

# Limpiar archivos generados
dart run build_runner clean

# Forzar regeneración
dart run build_runner build --delete-conflicting-outputs
```

---

### Generadores Comunes

| Paquete             | Genera             | Uso     |
| ------------------- | ------------------ | ------- |
| `hive_generator`    | TypeAdapters       | Hive    |
| `json_serializable` | toJson/fromJson    | APIs    |
| `freezed`           | Modelos inmutables | Estado  |
| `mockito`           | Mocks para tests   | Testing |

---

## 📁 Explorador de Archivos de App

### Android

**Ubicación de archivos**:

```
/data/data/com.example.app/
├── databases/          # SQLite databases
├── shared_prefs/       # SharedPreferences XML
├── files/              # App files
├── cache/              # Cache
└── app_flutter/        # Hive boxes
```

**Acceder con ADB**:

```bash
# Listar archivos
adb shell run-as com.example.app ls -la /data/data/com.example.app/

# Copiar base de datos a PC
adb shell run-as com.example.app cat /data/data/com.example.app/databases/app.db > app.db

# Para debug builds
adb pull /data/data/com.example.app/databases/app.db
```

---

### iOS Simulator

**Ubicación**:

```bash
# Encontrar directorio del simulador
xcrun simctl get_app_container booted com.example.app data

# Típicamente en:
~/Library/Developer/CoreSimulator/Devices/[UUID]/data/Containers/Data/Application/[UUID]/
├── Documents/          # Documentos
├── Library/
│   ├── Preferences/    # UserDefaults
│   └── Application Support/  # Hive, otros
└── tmp/                # Temporal
```

---

## 🧪 Herramientas de Testing

### sqflite_common_ffi

**Descripción**: Permite ejecutar tests de sqflite en desktop/CI

**Setup**:

```yaml
dev_dependencies:
  sqflite_common_ffi: ^2.3.0
```

```dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  // Tests...
}
```

---

### Mocktail / Mockito

**Descripción**: Crear mocks para tests

```yaml
dev_dependencies:
  mockito: ^5.4.0
  build_runner: ^2.4.6
```

```dart
import 'package:mockito/annotations.dart';

@GenerateMocks([Database, Box])
void main() {}
```

---

## 📈 Monitoring y Analytics

### Firebase Performance

**Para monitorear**:

- Tiempo de queries
- Operaciones de I/O
- Network requests

```yaml
dependencies:
  firebase_performance: ^0.9.3
```

---

### Sentry

**Para capturar errores**:

- Errores de base de datos
- Exceptions de persistencia
- Stack traces

```yaml
dependencies:
  sentry_flutter: ^7.14.0
```

---

## 🔒 Herramientas de Seguridad

### sqlcipher

**Descripción**: SQLite con encriptación

```yaml
dependencies:
  sqflite_sqlcipher: ^2.2.1
```

---

### flutter_secure_storage

**Descripción**: Almacenamiento seguro (Keychain/Keystore)

```yaml
dependencies:
  flutter_secure_storage: ^9.0.0
```

---

## 📦 Scripts Útiles

### Script: Backup de desarrollo

```bash
#!/bin/bash
# backup_dev_db.sh

APP_ID="com.example.app"
BACKUP_DIR="./db_backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Android
adb shell run-as $APP_ID cat databases/app.db > "$BACKUP_DIR/android_$TIMESTAMP.db"

echo "Backup guardado en $BACKUP_DIR/android_$TIMESTAMP.db"
```

---

### Script: Limpiar datos de desarrollo

```bash
#!/bin/bash
# clear_app_data.sh

APP_ID="com.example.app"

# Android
adb shell pm clear $APP_ID

# iOS Simulator
xcrun simctl uninstall booted $APP_ID
xcrun simctl install booted build/ios/iphonesimulator/Runner.app

echo "Datos de la app limpiados"
```

---

### Script: Generar código Hive

```bash
#!/bin/bash
# generate_hive.sh

echo "🔄 Limpiando archivos generados..."
dart run build_runner clean

echo "🏗️ Generando TypeAdapters..."
dart run build_runner build --delete-conflicting-outputs

echo "✅ Generación completada"
```

---

## 📋 Checklist de Herramientas

### Desarrollo

- [ ] VS Code con extensiones
- [ ] DB Browser for SQLite
- [ ] ADB configurado
- [ ] build_runner instalado

### Testing

- [ ] sqflite_common_ffi
- [ ] Mockito/Mocktail
- [ ] Integration test setup

### Debugging

- [ ] Flutter DevTools
- [ ] Database Inspector (Android Studio)
- [ ] Logs configurados

### Producción

- [ ] Monitoring (Firebase/Sentry)
- [ ] Backup automático
- [ ] Encriptación si es necesario

---

## 💡 Tips de Productividad

1. **Alias útiles** en `.zshrc` o `.bashrc`:

```bash
alias fgen="dart run build_runner build --delete-conflicting-outputs"
alias fwatch="dart run build_runner watch"
alias fclean="flutter clean && flutter pub get"
```

2. **VS Code snippets** para Hive:

```json
{
  "Hive Model": {
    "prefix": "hivemodel",
    "body": [
      "@HiveType(typeId: $1)",
      "class $2 extends HiveObject {",
      "  @HiveField(0)",
      "  $3;",
      "}"
    ]
  }
}
```

3. **Git hooks** para regenerar código:

```bash
# .git/hooks/post-merge
#!/bin/bash
dart run build_runner build --delete-conflicting-outputs
```

---

> 📌 **Consejo**: Configura tus herramientas una vez y automatiza todo lo que puedas. El tiempo invertido en setup se recupera rápidamente.
