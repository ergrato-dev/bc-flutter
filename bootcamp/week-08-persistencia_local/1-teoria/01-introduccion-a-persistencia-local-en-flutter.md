# Introducción a Persistencia Local en Flutter

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué problema resuelve la persistencia local frente al estado en memoria y al backend remoto
- Panorama de las tres opciones del ecosistema Flutter: `shared_preferences`, `hive`/`hive_ce`,
  `sqflite`
- Cómo decidir cuál usar según el tipo de dato que necesitas guardar

## 📋 Conceptos Clave

### 1. Tres lugares donde puede vivir un dato

Hasta semana 7, tus apps guardaban datos en dos lugares:

- **Memoria (estado de Riverpod)**: se pierde al cerrar la app — `FavoritesNotifier` de semana 4
  reinicia en `{}` cada vez que el proceso arranca de nuevo.
- **Backend remoto (API vía Dio)**: sobrevive al cierre de la app, pero requiere conexión — sin
  internet, `ItemsNotifier` de semana 6 falla.

**Persistencia local** es el tercer lugar: datos que sobreviven al cierre de la app y están
disponibles sin conexión, guardados en el almacenamiento del dispositivo.

### 2. Panorama: tres paquetes, tres necesidades distintas

| Paquete | Qué guarda | Consultas | Caso de uso típico |
|---|---|---|---|
| `shared_preferences` | Pares clave-valor de tipos primitivos (`String`, `int`, `bool`, `List<String>`) | Ninguna — solo `get`/`set` por clave | Preferencias simples: tema, idioma, ids favoritos |
| `hive`/`hive_ce` | Objetos Dart completos (`Map`, listas, clases con `TypeAdapter`) en "boxes" | Por clave, o recorrer todos los valores | Cache de listas de datos (offline-first) |
| `sqflite` | Filas en tablas SQL relacionales | SQL completo (`WHERE`, `JOIN`, índices) | Datos con relaciones complejas entre sí |

Esta semana usa **`shared_preferences`** para persistir favoritos (dato simple, ya lo tienes
desde semana 4) y **`hive_ce`** para cachear la lista de elementos del proyecto (dato
estructurado, offline-first). `sqflite` se cubre a nivel de criterio de decisión — este bootcamp
no profundiza en SQL crudo, pero necesitas saber cuándo lo elegirías en un proyecto real.

### 3. Instalación

```yaml
# pubspec.yaml
dependencies:
  shared_preferences: 2.5.5
  hive_ce_flutter: 2.3.4

dev_dependencies:
  hive_ce_generator: 1.11.2
  build_runner: 2.15.1
```

```bash
flutter pub add shared_preferences hive_ce_flutter
flutter pub add -d hive_ce_generator build_runner
```

> 📌 **Por qué `hive_ce` y no `hive`**: el paquete original `hive` no publica una versión estable
> nueva desde hace años (su propia documentación recomienda opciones más nuevas para necesidades
> avanzadas). `hive_ce` ("Community Edition") es la continuación activamente mantenida del mismo
> motor y API — mismo código que ya conoces de la comunidad Hive, sin quedarte en un paquete
> congelado.

### 4. Por qué esto no reemplaza `flutter_secure_storage`

Ninguno de estos tres paquetes cifra los datos por defecto — guardan en texto plano en el
almacenamiento de la app. Nunca guardes tokens de sesión ni contraseñas aquí; eso se cubre en
semana 9 con `flutter_secure_storage`, diseñado específicamente para datos sensibles.

## ✅ Checklist de Verificación

- [ ] Sé explicar la diferencia entre estado en memoria, backend remoto y persistencia local
- [ ] Sé qué paquete elegir según el tipo de dato (clave-valor simple, objeto estructurado,
      datos relacionales)
- [ ] Sé instalar `shared_preferences` y `hive_ce_flutter`
- [ ] Sé por qué ninguno de estos paquetes es apto para datos sensibles

## 📚 Próximo paso

[SharedPreferences — Clave-Valor Simple →](02-shared-preferences-clave-valor.md)
