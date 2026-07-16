# Semana 08 — Persistencia Local

> **Fase 2 — Estado y Datos** | Semana 8 de 19 | ⏱️ 16 horas

Esta semana agrega persistencia local al proyecto de semana 7 — los favoritos y la lista de
elementos de tu dominio sobreviven al cierre de la app y quedan disponibles sin conexión.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Elegir entre `shared_preferences`, Hive/`hive_ce` y `sqflite` según el tipo de dato a
      persistir
- [ ] Leer y escribir valores primitivos con `SharedPreferences`
- [ ] Abrir y usar un `Box` de Hive para cachear datos estructurados
- [ ] Cargar instancias async (`SharedPreferences`, `Box`) antes de `runApp()` e inyectarlas en
      Riverpod con `overrideWithValue()`
- [ ] Implementar un repository con cache local (network-first con fallback), sin modificar la
      UI que lo consume
- [ ] Aplicar buenas prácticas de persistencia móvil (nunca datos sensibles sin cifrar,
      migraciones seguras, limpieza al cerrar sesión)

## 📚 Requisitos previos

- Semana 7 (Formularios y Validación) completada — `FormBuilder`, `AsyncNotifier` de acción
- Flutter SDK local configurado (`flutter doctor` sin errores) + emulador/simulador corriendo
- Docker (para `flutter analyze`/`flutter test` reproducibles)

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Introducción a Persistencia Local en Flutter](1-teoria/01-introduccion-a-persistencia-local-en-flutter.md)
2. [SharedPreferences — Clave-Valor Simple](1-teoria/02-shared-preferences-clave-valor.md)
3. [Hive/hive_ce — NoSQL Local](1-teoria/03-hive-ce-nosql-local.md)
4. [sqflite y Cuándo Usar SQL](1-teoria/04-sqflite-y-cuando-usar-sql.md)
5. [Repository Pattern con Cache Local](1-teoria/05-repository-pattern-con-cache-local.md)
6. [Buenas Prácticas de Persistencia Móvil](1-teoria/06-buenas-practicas-de-persistencia-movil.md)

### Prácticas

1. [Ejercicio 01 — SharedPreferences Básico](2-practicas/ejercicio-01-shared-preferences-basico/README.md)
2. [Ejercicio 02 — Hive/hive_ce CRUD Local](2-practicas/ejercicio-02-hive-ce-crud-local/README.md)
3. [Ejercicio 03 — Repository con Cache Offline](2-practicas/ejercicio-03-repository-con-cache-offline/README.md)

### Proyecto

[Persistencia Local](3-proyecto/README.md) — persiste favoritos con `SharedPreferences` y cachea
la lista de elementos de tu dominio con `CachedItemsRepository` (Hive), sobre el proyecto de
semana 7.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado, con favoritos y lista persistidos localmente
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 07 — Formularios y Validación](../week-07-formularios_validacion/README.md) | [Semana 09 — Autenticación Completa →](../week-09-autenticacion_completa/README.md)
