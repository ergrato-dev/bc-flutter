# 💻 Prácticas - Semana 07: Persistencia de Datos

## Ejercicios Prácticos

Esta semana contiene 5 prácticas progresivas para dominar el almacenamiento local.

| #   | Práctica                                                         | Tecnología        | Duración | Nivel  |
| --- | ---------------------------------------------------------------- | ----------------- | -------- | ------ |
| 01  | [Preferencias de Usuario](./practica-01-preferencias-usuario.md) | SharedPreferences | 30 min   | ⭐     |
| 02  | [Base de Datos de Contactos](./practica-02-sqlite-contactos.md)  | SQLite            | 45 min   | ⭐⭐   |
| 03  | [Lista de Tareas con Hive](./practica-03-hive-tasks.md)          | Hive              | 45 min   | ⭐⭐   |
| 04  | [Caché de Imágenes](./practica-04-cache-imagenes.md)             | path_provider     | 40 min   | ⭐⭐   |
| 05  | [Sincronización Offline](./practica-05-sync-offline.md)          | SQLite + API      | 50 min   | ⭐⭐⭐ |

---

## 🎯 Objetivos

Al completar todas las prácticas serás capaz de:

1. ✅ Persistir preferencias simples con SharedPreferences
2. ✅ Diseñar e implementar bases de datos SQLite
3. ✅ Usar Hive para almacenamiento NoSQL rápido
4. ✅ Manejar archivos y crear sistemas de caché
5. ✅ Implementar estrategias de sincronización offline

---

## 📋 Requisitos Previos

- Conocimientos de async/await
- Experiencia con Provider o setState
- Fundamentos de serialización JSON
- Flutter SDK instalado y configurado

---

## 🔧 Dependencias Comunes

```yaml
dependencies:
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0
  path: ^1.8.3
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.1
  provider: ^6.1.1
  http: ^1.1.0
  uuid: ^4.2.1
  intl: ^0.18.1

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
```

---

## 📊 Progresión de Dificultad

```
Práctica 01  ━━━━━━━━━━░░░░░░░░░░  Básico
Práctica 02  ━━━━━━━━━━━━━━░░░░░░  Intermedio
Práctica 03  ━━━━━━━━━━━━━━░░░░░░  Intermedio
Práctica 04  ━━━━━━━━━━━━━━░░░░░░  Intermedio
Práctica 05  ━━━━━━━━━━━━━━━━━━░░  Avanzado
```

---

## ✅ Checklist de Completitud

- [ ] Práctica 01 - Preferencias implementadas
- [ ] Práctica 02 - CRUD SQLite funcionando
- [ ] Práctica 03 - Tareas con Hive completas
- [ ] Práctica 04 - Caché de imágenes operativo
- [ ] Práctica 05 - Sincronización offline implementada
