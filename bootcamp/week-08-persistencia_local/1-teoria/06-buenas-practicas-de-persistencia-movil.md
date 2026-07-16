# Buenas Prácticas de Persistencia Móvil

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué datos nunca debes persistir sin cifrar
- Cómo manejar cambios en la forma de tus datos guardados (migraciones)
- Cuándo limpiar la persistencia local

## 📋 Conceptos Clave

### 1. Nunca guardes datos sensibles sin cifrar

`shared_preferences` y Hive guardan en **texto plano** en el almacenamiento de la app —
accesible en un dispositivo rooteado/con jailbreak, o en un backup no cifrado. Nunca guardes
aquí:

- Tokens de sesión o de refresco
- Contraseñas
- Cualquier dato que la legislación de protección de datos de tu país considere sensible

Para eso existe `flutter_secure_storage` (semana 9), que usa el Keychain de iOS y el Keystore
de Android — almacenamiento cifrado a nivel de sistema operativo.

### 2. Migraciones — qué pasa cuando cambia la forma de tus datos

Si guardas `Map`/`List` directo en Hive (como este proyecto) y luego agregas un campo nuevo al
modelo, el dato viejo en el Box simplemente no tendrá esa clave. Dos estrategias:

```dart
Item _fromCacheMap(dynamic map) {
  final m = map as Map;
  return Item(
    id: m['id'] as String,
    name: m['name'] as String,
    description: m['description'] as String,
    // Si agregas `price` después: usa un default si la clave no existe.
    // price: (m['price'] as num?)?.toDouble() ?? 0.0,
  );
}
```

- **Default seguro al leer** (arriba): tolera datos viejos sin migración explícita — suficiente
  para un cache que se puede regenerar (como el de este proyecto).
- **Versionar el Box**: guardar un número de versión junto a los datos, y borrar/transformar el
  Box completo si no coincide con la versión actual del código — necesario cuando el dato es la
  única copia (no hay una API de la que volver a descargarlo).

Este proyecto usa la primera estrategia porque el cache **siempre se puede regenerar** desde la
API — si el formato cambia de forma incompatible, la opción más simple es limpiar el Box.

### 3. Cuándo limpiar la persistencia local

```dart
// Al cerrar sesión — nunca dejes datos de un usuario disponibles para el siguiente
await ref.read(itemsCacheBoxProvider).clear();
await ref.read(sharedPreferencesProvider).clear();
```

Limpia toda la persistencia local al cerrar sesión (tema central de semana 9) — sobre todo en
dispositivos compartidos. Un cache de "elementos" que sobrevive al logout no es sensible por sí
mismo, pero es una buena práctica no dejar rastro de la sesión anterior.

### 4. Checklist de buenas prácticas de la semana

- ✅ Nada sensible en `shared_preferences`/Hive sin cifrar
- ✅ Lecturas del cache toleran datos con forma vieja (default seguro)
- ✅ El cache se limpia al cerrar sesión
- ✅ `main()` async carga las instancias antes de `runApp()` — ningún provider de lectura
  frecuente queda async solo por esperar I/O de disco

## ✅ Checklist de Verificación

- [ ] Sé qué datos nunca deben persistirse sin cifrar y por qué
- [ ] Sé aplicar un default seguro al leer un dato con forma vieja
- [ ] Sé cuándo limpiar la persistencia local
- [ ] Repasé el checklist de buenas prácticas de la semana

## 📚 Siguiente paso

Continúa con los [ejercicios prácticos](../2-practicas/) de esta semana.
