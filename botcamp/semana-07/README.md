# Semana 7: Persistencia de Datos

## 🎯 Objetivos de Aprendizaje

- Almacenar datos localmente en dispositivos
- Usar SharedPreferences para preferencias simples
- Implementar SQLite para bases de datos relacionales
- Manejar almacenamiento de archivos
- Implementar caché de datos
- Sincronizar datos local y remoto

## 📚 Contenido Teórico

### 1. SharedPreferences (2 horas)

#### ¿Qué es SharedPreferences?

- Almacenamiento clave-valor
- Datos primitivos (String, int, bool, double)
- Persistencia de preferencias de usuario
- No encriptado

#### Instalación

```yaml
dependencies:
  shared_preferences: ^2.2.2
```

#### Uso Básico

```dart
import 'package:shared_preferences/shared_preferences.dart';

// Guardar datos
Future<void> guardarDatos() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('nombre', 'Juan');
  await prefs.setInt('edad', 25);
  await prefs.setBool('temaOscuro', true);
  await prefs.setDouble('altura', 1.75);
  await prefs.setStringList('tags', ['flutter', 'dart']);
}

// Leer datos
Future<void> leerDatos() async {
  final prefs = await SharedPreferences.getInstance();
  final nombre = prefs.getString('nombre') ?? 'Sin nombre';
  final edad = prefs.getInt('edad') ?? 0;
  final temaOscuro = prefs.getBool('temaOscuro') ?? false;
}

// Eliminar datos
Future<void> eliminarDato() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('nombre');
}

// Limpiar todo
Future<void> limpiarTodo() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
```

#### Casos de Uso

- Preferencias de tema
- Configuración de usuario
- Token de autenticación
- Datos de onboarding
- Idioma de la app

### 2. SQLite (3 horas)

#### ¿Qué es SQLite?

- Base de datos relacional
- Almacenamiento estructurado
- Consultas SQL
- Relaciones entre tablas

#### Instalación

```yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
```

#### Crear Base de Datos

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE notas (
        id $idType,
        titulo $textType,
        descripcion $textType,
        fecha $textType,
        importante $intType
      )
    ''');
  }
}
```

#### CRUD Operations

```dart
// Modelo
class Nota {
  final int? id;
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final bool importante;

  Nota({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.importante,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'importante': importante ? 1 : 0,
    };
  }

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'],
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      fecha: DateTime.parse(map['fecha']),
      importante: map['importante'] == 1,
    );
  }
}

// CREATE
Future<int> crearNota(Nota nota) async {
  final db = await database;
  return await db.insert('notas', nota.toMap());
}

// READ
Future<List<Nota>> obtenerNotas() async {
  final db = await database;
  final result = await db.query('notas', orderBy: 'fecha DESC');
  return result.map((map) => Nota.fromMap(map)).toList();
}

Future<Nota?> obtenerNota(int id) async {
  final db = await database;
  final maps = await db.query(
    'notas',
    where: 'id = ?',
    whereArgs: [id],
  );

  if (maps.isNotEmpty) {
    return Nota.fromMap(maps.first);
  }
  return null;
}

// UPDATE
Future<int> actualizarNota(Nota nota) async {
  final db = await database;
  return await db.update(
    'notas',
    nota.toMap(),
    where: 'id = ?',
    whereArgs: [nota.id],
  );
}

// DELETE
Future<int> eliminarNota(int id) async {
  final db = await database;
  return await db.delete(
    'notas',
    where: 'id = ?',
    whereArgs: [id],
  );
}

// Consultas complejas
Future<List<Nota>> buscarNotas(String query) async {
  final db = await database;
  final result = await db.query(
    'notas',
    where: 'titulo LIKE ? OR descripcion LIKE ?',
    whereArgs: ['%$query%', '%$query%'],
  );
  return result.map((map) => Nota.fromMap(map)).toList();
}
```

### 3. Almacenamiento de Archivos (1.5 horas)

#### Path Provider

```yaml
dependencies:
  path_provider: ^2.1.1
```

#### Directorios

```dart
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// Directorio de documentos (persistente)
Future<Directory> getDocumentsDir() async {
  return await getApplicationDocumentsDirectory();
}

// Directorio temporal (puede ser limpiado por el SO)
Future<Directory> getTempDir() async {
  return await getTemporaryDirectory();
}

// Directorio de caché
Future<Directory> getCacheDir() async {
  return await getApplicationCacheDirectory();
}
```

#### Guardar y Leer Archivos

```dart
// Guardar texto
Future<File> guardarTexto(String contenido) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/archivo.txt');
  return await file.writeAsString(contenido);
}

// Leer texto
Future<String> leerTexto() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/archivo.txt');
    return await file.readAsString();
  } catch (e) {
    return '';
  }
}

// Guardar imagen
Future<File> guardarImagen(Uint8List bytes) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/imagen.png');
  return await file.writeAsBytes(bytes);
}

// Eliminar archivo
Future<void> eliminarArchivo(String nombre) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$nombre');
  if (await file.exists()) {
    await file.delete();
  }
}
```

### 4. Hive (Alternativa a SQLite) (1.5 horas)

#### Instalación

```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.6
```

#### Uso Básico

```dart
import 'package:hive_flutter/hive_flutter.dart';

// Inicializar
await Hive.initFlutter();

// Abrir box
var box = await Hive.openBox('miBox');

// Guardar
await box.put('nombre', 'Juan');
await box.put('edad', 25);

// Leer
String nombre = box.get('nombre', defaultValue: '');
int edad = box.get('edad', defaultValue: 0);

// Eliminar
await box.delete('nombre');

// Cerrar
await box.close();
```

## 💻 Ejercicios Prácticos

### Ejercicio 1: Preferencias de App

Implementa sistema de configuración con SharedPreferences:

- Tema (claro/oscuro)
- Idioma (español/inglés)
- Notificaciones (on/off)
- Tamaño de fuente
- Persistir y recuperar al iniciar

### Ejercicio 2: Lista de Tareas con SQLite

Crea app de tareas con base de datos:

- Tabla de tareas (id, titulo, descripcion, completada, fecha)
- CRUD completo
- Búsqueda de tareas
- Filtrar por completadas/pendientes

### Ejercicio 3: Notas con Categorías

Implementa app de notas con relaciones:

- Tabla de notas
- Tabla de categorías
- Relación many-to-one
- Consultas con JOINs

### Ejercicio 4: Almacenamiento de Imágenes

Desarrolla galería personal:

- Guardar imágenes localmente
- Crear thumbnails
- Organizar en álbumes
- Eliminar imágenes

### Ejercicio 5: Caché de Datos

Implementa sistema de caché:

- Guardar respuestas de API
- Tiempo de expiración
- Actualizar caché
- Modo offline

## 🔨 Proyecto de la Semana

**App de Diario Personal (Journal)**

Desarrolla una aplicación completa de diario con persistencia:

**Características:**

1. **Entradas de Diario**

   - Crear entrada (título, contenido, fecha)
   - Adjuntar imágenes a entradas
   - Estado de ánimo (emoji selector)
   - Etiquetas/Tags
   - Ubicación (opcional)

2. **Organización**

   - Calendario para ver entradas por fecha
   - Búsqueda por texto
   - Filtrar por estado de ánimo
   - Filtrar por etiquetas
   - Vista de lista y vista de grid

3. **Multimedia**

   - Adjuntar múltiples fotos
   - Galería de imágenes en detalle
   - Eliminar imágenes
   - Comprimir imágenes automáticamente

4. **Estadísticas**

   - Total de entradas
   - Entradas por mes
   - Estados de ánimo más frecuentes
   - Palabras más usadas

5. **Configuración**
   - Bloqueo con PIN/biometría
   - Respaldo y restauración
   - Exportar a texto/PDF
   - Tema personalizable

**Requisitos técnicos:**

```dart
// Estructura de Base de Datos
CREATE TABLE entradas (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  titulo TEXT NOT NULL,
  contenido TEXT NOT NULL,
  fecha TEXT NOT NULL,
  estado_animo TEXT,
  ubicacion TEXT,
  creado_en TEXT NOT NULL,
  actualizado_en TEXT NOT NULL
);

CREATE TABLE imagenes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  entrada_id INTEGER NOT NULL,
  ruta TEXT NOT NULL,
  FOREIGN KEY (entrada_id) REFERENCES entradas (id) ON DELETE CASCADE
);

CREATE TABLE etiquetas (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nombre TEXT UNIQUE NOT NULL
);

CREATE TABLE entradas_etiquetas (
  entrada_id INTEGER NOT NULL,
  etiqueta_id INTEGER NOT NULL,
  PRIMARY KEY (entrada_id, etiqueta_id),
  FOREIGN KEY (entrada_id) REFERENCES entradas (id) ON DELETE CASCADE,
  FOREIGN KEY (etiqueta_id) REFERENCES etiquetas (id) ON DELETE CASCADE
);

// Modelos
class Entrada {
  final int? id;
  final String titulo;
  final String contenido;
  final DateTime fecha;
  final String? estadoAnimo;
  final String? ubicacion;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  List<String> imagenes;
  List<String> etiquetas;
}

// Database Helper
class DiarioDB {
  Future<int> crearEntrada(Entrada entrada) async { }
  Future<List<Entrada>> obtenerEntradas() async { }
  Future<Entrada?> obtenerEntrada(int id) async { }
  Future<int> actualizarEntrada(Entrada entrada) async { }
  Future<int> eliminarEntrada(int id) async { }
  Future<List<Entrada>> buscarEntradas(String query) async { }
  Future<List<Entrada>> obtenerEntradasPorFecha(DateTime fecha) async { }
  Future<Map<String, int>> obtenerEstadisticas() async { }
}
```

**Pantallas:**

1. Lista/Grid de entradas
2. Calendario
3. Crear/Editar entrada
4. Detalle de entrada
5. Búsqueda
6. Estadísticas
7. Configuración

**Funcionalidades adicionales:**

- Sincronización con cloud (opcional)
- Recordatorios para escribir
- Temas personalizados (SharedPreferences)
- Respaldo automático semanal
- Protección con contraseña

## 📖 Recursos

### Documentación

- [SharedPreferences](https://pub.dev/packages/shared_preferences)
- [SQLite (sqflite)](https://pub.dev/packages/sqflite)
- [Path Provider](https://pub.dev/packages/path_provider)
- [Hive](https://docs.hivedb.dev/)

### Videos

- [Flutter SQLite Tutorial](https://www.youtube.com/watch?v=HefHf5B1YM0)
- [Hive Database](https://www.youtube.com/watch?v=R1GSrrItqUs)

### Paquetes Útiles

- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [sqflite](https://pub.dev/packages/sqflite)
- [hive](https://pub.dev/packages/hive)
- [path_provider](https://pub.dev/packages/path_provider)
- [sembast](https://pub.dev/packages/sembast)
- [drift](https://pub.dev/packages/drift) (antes moor)

## ✅ Checklist de Completitud

- [ ] Ejercicio 1: Preferencias completado
- [ ] Ejercicio 2: Lista de tareas completado
- [ ] Ejercicio 3: Notas con categorías completado
- [ ] Ejercicio 4: Almacenamiento de imágenes completado
- [ ] Ejercicio 5: Caché completado
- [ ] Proyecto: Diario personal completado
- [ ] Base de datos correctamente estructurada
- [ ] CRUD completo funcionando
- [ ] Persistencia verificada
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios prácticos (1-5):** 30%
- **Proyecto de la semana:** 60%
- **Estructura de BD y optimización:** 10%

## 📝 Notas Importantes

- Cerrar conexiones de BD cuando no se usen
- Manejar migraciones de BD cuidadosamente
- No almacenar datos sensibles sin encriptar
- Limpiar caché periódicamente
- Probar comportamiento con grandes volúmenes de datos

## 🔧 Best Practices

```dart
// ✅ Singleton para Database
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();
}

// ✅ Usar transacciones para múltiples operaciones
await db.transaction((txn) async {
  await txn.insert('tabla1', data1);
  await txn.insert('tabla2', data2);
});

// ✅ Indices para optimizar consultas
await db.execute(
  'CREATE INDEX idx_fecha ON notas (fecha)'
);

// ❌ No hacer consultas en el build method
// ✅ Usar FutureBuilder o cargar en initState
```

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 6](../semana-06/README.md) | **Siguiente:** [Semana 8 →](../semana-08/README.md)
