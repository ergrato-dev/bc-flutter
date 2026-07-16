# Glosario — Semana 08: Persistencia Local

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## B

**Box**: contenedor clave-valor persistente en disco de Hive/`hive_ce` — el equivalente a una
tabla o colección. Se abre con `Hive.openBox()`.

## C

**CachedItemsRepository**: implementación de `ItemsRepository` que decora otra implementación
(`DioItemsRepository`) agregándole cache local en un `Box` de Hive — patrón Decorator.

## D

**Decorator**: patrón de diseño donde una clase envuelve a otra que implementa la misma
interfaz, agregándole comportamiento sin modificarla — usado por `CachedItemsRepository` sobre
`DioItemsRepository`.

## H

**Hive/hive_ce**: motor de base de datos NoSQL clave-valor embebido para Flutter/Dart.
`hive_ce` ("Community Edition") es la continuación activamente mantenida del paquete original
`hive`.

**Hive.initFlutter()**: inicializa Hive con el directorio de almacenamiento correcto de cada
plataforma — se llama una vez, antes de abrir cualquier Box.

## M

**Migración (de datos persistidos)**: estrategia para tolerar cambios en la forma de un dato ya
guardado — un default seguro al leer, o versionar el Box completo.

## N

**Network-first con fallback**: estrategia de cache que intenta la red primero, y solo recurre
al cache local si la red falla — la estrategia usada en `CachedItemsRepository` de esta semana.

## O

**overrideWithValue()**: método de Riverpod que reemplaza el resultado de un provider por un
valor ya calculado — usado para inyectar `SharedPreferences` y el `Box` de Hive, ya cargados en
`main()`, sin volver async a los providers que los consumen.

## P

**Persistencia local**: datos guardados en el almacenamiento del dispositivo que sobreviven al
cierre de la app y están disponibles sin conexión — el tercer lugar donde puede vivir un dato,
junto a la memoria (estado de Riverpod) y el backend remoto (API vía Dio).

## S

**SharedPreferences**: paquete que persiste pares clave-valor de tipos primitivos
(`String`, `int`, `bool`, `List<String>`) — apto para preferencias simples, no para objetos
estructurados.

**sqflite**: wrapper de SQLite para Flutter — base de datos relacional con soporte de SQL
completo (`JOIN`, índices, `WHERE` compuestos).

## T

**TypeAdapter**: clase generada (`@HiveType`/`@HiveField` + `hive_ce_generator`) que le permite
a un Box guardar instancias de una clase Dart directamente, con seguridad de tipos al leer.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
