# 📖 Glosario - Semana 07: Persistencia de Datos

## 📋 Términos y Definiciones

> Glosario completo de términos relacionados con la persistencia de datos en Flutter.

---

## A

### ACID

**Atomicity, Consistency, Isolation, Durability** - Propiedades que garantizan transacciones confiables en bases de datos.

- **Atomicidad**: La transacción se completa totalmente o no se ejecuta
- **Consistencia**: La base de datos pasa de un estado válido a otro
- **Aislamiento**: Las transacciones concurrentes no se afectan entre sí
- **Durabilidad**: Los cambios son permanentes una vez confirmados

### Adapter (Hive)

Clase que define cómo Hive serializa y deserializa un tipo de dato personalizado. Se genera automáticamente con `hive_generator` usando anotaciones `@HiveType` y `@HiveField`.

### ALTER TABLE

Comando SQL para modificar la estructura de una tabla existente (agregar/eliminar columnas, cambiar tipos).

```sql
ALTER TABLE users ADD COLUMN avatar TEXT;
```

### Async/Await

Patrón de programación asíncrona en Dart que permite escribir código asíncrono de forma secuencial y legible.

### AUTOINCREMENT

Propiedad de SQLite que genera automáticamente valores únicos incrementales para una columna (típicamente el ID).

---

## B

### Backup

Copia de seguridad de los datos almacenados para recuperación en caso de pérdida o corrupción.

### Batch

Agrupación de múltiples operaciones de base de datos para ejecutarlas de forma más eficiente que individualmente.

```dart
final batch = db.batch();
batch.insert('users', data1);
batch.insert('users', data2);
await batch.commit();
```

### BLOB (Binary Large Object)

Tipo de dato SQLite para almacenar datos binarios como imágenes, archivos, etc.

### Box (Hive)

Contenedor de almacenamiento en Hive, similar a una tabla en SQL pero para datos NoSQL. Puede ser tipado (`Box<User>`) o genérico (`Box`).

### build_runner

Herramienta de Dart que ejecuta generadores de código. Usado para generar TypeAdapters de Hive, JSON serialization, etc.

---

## C

### Cache

Almacenamiento temporal de datos para acceso rápido, evitando consultas repetidas a la fuente original.

### CASCADE (ON DELETE/UPDATE)

Acción de SQLite que propaga cambios (eliminación o actualización) a registros relacionados mediante foreign keys.

### COMMIT

Comando que confirma permanentemente los cambios de una transacción en la base de datos.

### Compaction (Hive)

Proceso de optimización que elimina espacio no utilizado en archivos de Hive, reduciendo el tamaño del storage.

### ConflictAlgorithm

Enum de sqflite que define cómo manejar conflictos al insertar/actualizar datos (REPLACE, IGNORE, ABORT, etc.).

### CRUD

**Create, Read, Update, Delete** - Las cuatro operaciones básicas de persistencia de datos.

---

## D

### DAO (Data Access Object)

Patrón de diseño que abstrae el acceso a datos, separando la lógica de negocio de los detalles de persistencia.

### Database

Colección organizada de datos estructurados, almacenados electrónicamente.

### Database Migration

Proceso de modificar el esquema de una base de datos de una versión a otra manteniendo los datos existentes.

### Deserialización

Proceso de convertir datos almacenados (JSON, bytes) de vuelta a objetos de Dart.

### DROP TABLE

Comando SQL para eliminar completamente una tabla y todos sus datos.

---

## E

### Encryption

Proceso de codificar datos para protegerlos de acceso no autorizado. En persistencia, se aplica a databases (SQLCipher) y boxes (Hive AES).

### Entity

Objeto que representa un registro de datos, típicamente mapeado a una fila de tabla o documento.

### EXISTS

Operador SQL que verifica si una subconsulta devuelve algún resultado. Más eficiente que COUNT para verificaciones.

---

## F

### Foreign Key

Columna que referencia la clave primaria de otra tabla, estableciendo una relación entre tablas.

### fromMap / toMap

Métodos en modelos Dart para convertir entre objetos y Maps (para almacenamiento en SQLite).

### FTS (Full-Text Search)

Capacidad de búsqueda de texto completo en bases de datos. SQLite soporta FTS5.

### Future

Objeto de Dart que representa un valor o error que estará disponible en algún momento futuro (operación asíncrona).

---

## G

### getDatabasesPath()

Función de sqflite que retorna el directorio donde se almacenan las bases de datos SQLite.

### getApplicationDocumentsDirectory()

Función de path_provider que retorna el directorio para documentos de la aplicación (persiste entre sesiones).

### GROUP BY

Cláusula SQL que agrupa filas con valores iguales en columnas especificadas.

---

## H

### Hive

Base de datos NoSQL ligera y rápida para Flutter/Dart, optimizada para dispositivos móviles.

### HiveField

Anotación que marca un campo de clase para serialización en Hive, con un índice único.

### HiveObject

Clase base opcional de Hive que proporciona métodos convenientes como `save()`, `delete()`, y acceso a la key.

### HiveType

Anotación que marca una clase para generar un TypeAdapter, con un typeId único.

---

## I

### INDEX

Estructura de datos que mejora la velocidad de consultas en columnas específicas. Trade-off: más rápido leer, más lento escribir.

### INSERT

Comando SQL para agregar nuevos registros a una tabla.

### Isolate

Mecanismo de concurrencia en Dart. Las operaciones de DB pesadas pueden ejecutarse en isolates separados.

---

## J

### JOIN

Operación SQL que combina filas de dos o más tablas basándose en columnas relacionadas.

### JSON (JavaScript Object Notation)

Formato ligero de intercambio de datos. SharedPreferences puede almacenar objetos como JSON strings.

---

## K

### Key (Hive)

Identificador único de un valor en un Box. Puede ser auto-generado (int) o especificado (cualquier tipo).

### Key-Value Storage

Modelo de almacenamiento simple donde cada dato se asocia con una clave única. SharedPreferences y Hive lo utilizan.

### Keychain (iOS)

Almacenamiento seguro de iOS para datos sensibles como contraseñas y tokens.

### Keystore (Android)

Sistema de almacenamiento seguro de Android para credenciales y claves criptográficas.

---

## L

### Lazy Loading

Técnica que carga datos solo cuando se necesitan, no al inicio. LazyBox de Hive implementa esto.

### LazyBox

Variante de Box en Hive que no carga todos los datos en memoria, útil para grandes conjuntos de datos.

### LIKE

Operador SQL para búsqueda de patrones en strings usando wildcards (% y \_).

### LIMIT

Cláusula SQL que restringe el número de filas retornadas por una consulta.

---

## M

### Migration

Ver "Database Migration".

### Mock

Objeto simulado usado en testing que imita el comportamiento de objetos reales (como una base de datos).

### Model

Clase que representa la estructura de datos de la aplicación, típicamente con métodos de serialización.

---

## N

### NoSQL

Tipo de base de datos que no usa el modelo relacional tradicional. Hive es un ejemplo de NoSQL en Flutter.

### NOT NULL

Constraint SQL que requiere que una columna siempre tenga un valor.

### Nullable

En Dart, un tipo que puede contener null (indicado con `?`). Importante para datos opcionales.

---

## O

### OFFSET

Cláusula SQL usada con LIMIT para paginación, indica cuántas filas saltar.

### Offline-First

Arquitectura donde la aplicación funciona sin conexión, sincronizando con el servidor cuando hay red.

### ORM (Object-Relational Mapping)

Técnica que mapea objetos de código a tablas de base de datos relacional.

### openDatabase

Función de sqflite para abrir o crear una base de datos SQLite.

---

## P

### Paginación

Técnica de cargar datos en páginas (chunks) en lugar de todos a la vez.

### path_provider

Paquete Flutter para obtener rutas de directorios del sistema de archivos.

### Persistence

Almacenamiento de datos que sobrevive al cierre de la aplicación.

### PRAGMA

Comandos especiales de SQLite para configuración de la base de datos.

### Primary Key

Columna que identifica únicamente cada fila en una tabla.

---

## Q

### Query

Solicitud para recuperar o modificar datos en una base de datos.

---

## R

### Raw Query

Consulta SQL escrita manualmente (vs. métodos helper como `db.query()`).

### Repository Pattern

Patrón que abstrae la lógica de acceso a datos, proporcionando una interfaz limpia al resto de la aplicación.

### ROLLBACK

Comando que deshace los cambios de una transacción no confirmada.

---

## S

### Schema

Estructura de la base de datos: definición de tablas, columnas, tipos, relaciones.

### SELECT

Comando SQL para consultar y recuperar datos de una o más tablas.

### Serialización

Proceso de convertir objetos de Dart a formato almacenable (JSON, bytes, Map).

### SharedPreferences

Sistema simple de almacenamiento key-value para preferencias y configuraciones.

### Singleton

Patrón de diseño que asegura una única instancia de una clase (común para servicios de DB).

### SQL (Structured Query Language)

Lenguaje estándar para gestionar bases de datos relacionales.

### SQLite

Motor de base de datos relacional embebido, ligero y sin servidor.

### sqflite

Paquete Flutter que proporciona acceso a SQLite.

### Stream

Secuencia de eventos asíncronos en Dart. Útil para observar cambios en datos.

### Sync (Synchronization)

Proceso de mantener datos consistentes entre almacenamiento local y remoto.

---

## T

### Table

Estructura de datos relacional organizada en filas y columnas.

### Transaction

Conjunto de operaciones de base de datos que se ejecutan como una unidad atómica.

### Trigger

Procedimiento que se ejecuta automáticamente ante eventos específicos en la base de datos.

### TypeAdapter (Hive)

Clase que define cómo serializar/deserializar un tipo personalizado en Hive.

### typeId (Hive)

Identificador único numérico para cada TypeAdapter registrado (0-223).

---

## U

### UNIQUE

Constraint SQL que asegura valores únicos en una columna.

### UPDATE

Comando SQL para modificar registros existentes en una tabla.

---

## V

### ValueListenableBuilder

Widget de Flutter que reconstruye la UI cuando un ValueListenable (como un Box de Hive) cambia.

### Version (Database)

Número que identifica la versión del schema de la base de datos, usado para migraciones.

---

## W

### WHERE

Cláusula SQL que filtra registros basándose en condiciones específicas.

### Widget

Elemento básico de UI en Flutter. Algunos widgets se actualizan automáticamente con cambios en datos persistidos.

---

## Símbolos y Operadores SQL

| Símbolo | Nombre        | Uso                               |
| ------- | ------------- | --------------------------------- |
| `*`     | Asterisco     | SELECT \* (todas las columnas)    |
| `?`     | Placeholder   | Parámetros en prepared statements |
| `%`     | Wildcard      | LIKE pattern matching             |
| `_`     | Underscore    | Single character wildcard         |
| `=`     | Igual         | Comparación exacta                |
| `<>`    | Diferente     | No igual                          |
| `>=`    | Mayor o igual | Comparación                       |
| `<=`    | Menor o igual | Comparación                       |

---

## 📚 Acrónimos Comunes

| Acrónimo | Significado                                   |
| -------- | --------------------------------------------- |
| ACID     | Atomicity, Consistency, Isolation, Durability |
| API      | Application Programming Interface             |
| BLOB     | Binary Large Object                           |
| CRUD     | Create, Read, Update, Delete                  |
| DAO      | Data Access Object                            |
| DB       | Database                                      |
| FK       | Foreign Key                                   |
| FTS      | Full-Text Search                              |
| JSON     | JavaScript Object Notation                    |
| ORM      | Object-Relational Mapping                     |
| PK       | Primary Key                                   |
| SQL      | Structured Query Language                     |

---

## 🔗 Referencias Cruzadas

- **Conceptos de Flutter**: Ver glosarios de semanas anteriores
- **Programación Asíncrona**: Future, async/await, Stream
- **Arquitectura**: Repository Pattern, DAO, Clean Architecture
- **Testing**: Mock, Integration Test, Unit Test

---

> 💡 **Tip**: Familiarízate con estos términos. El vocabulario técnico correcto facilita la comunicación y la búsqueda de soluciones.
