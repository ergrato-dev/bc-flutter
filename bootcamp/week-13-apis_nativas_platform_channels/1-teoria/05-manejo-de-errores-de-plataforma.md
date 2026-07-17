# Manejo de Errores de Plataforma

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es una `PlatformException` y en qué se diferencia de una excepción Dart normal
- Qué es `MissingPluginException` y cuándo aparece
- Cómo estructurar código que se comporta distinto en Android vs. iOS, de forma explícita

## 📋 Conceptos Clave

### 1. PlatformException — el error cruza la frontera nativa

Cuando el lado nativo llama `result.error(code, message, details)` (teoría 04), Dart recibe una
`PlatformException` — no una excepción Dart genérica:

```dart
try {
  final level = await BatteryService().getBatteryLevel();
} on PlatformException catch (e) {
  debugPrint('Error nativo: ${e.code} — ${e.message}');
}
```

`e.code` es el identificador corto que el lado nativo definió (`"UNAVAILABLE"` en el ejemplo de
teoría 04), `e.message` es la descripción legible, y `e.details` puede llevar información
adicional estructurada. Trátala como tratarías el `code`/`message` de una respuesta de error HTTP
(semana 6) — un identificador para decidir lógica, un mensaje para mostrar o loguear.

### 2. MissingPluginException — el canal no tiene handler

Si invocas un método en un canal cuyo nombre no coincide con ningún `setMethodCallHandler` nativo
(typo en el nombre del canal, o el handler nunca se registró), Dart recibe
`MissingPluginException` en vez de `PlatformException`. Es la señal más común de "el canal no está
bien emparejado" — revisa primero que el string del canal sea idéntico en Dart y en Kotlin/Swift.

```dart
try {
  final level = await BatteryService().getBatteryLevel();
} on MissingPluginException {
  debugPrint('El canal no tiene handler nativo registrado — revisa el nombre del canal');
} on PlatformException catch (e) {
  debugPrint('Error nativo: ${e.code}');
}
```

### 3. Divergencia intencional entre plataformas

No toda funcionalidad nativa existe igual en Android y iOS — un plugin (o tu propio platform
channel) puede necesitar comportarse distinto según la plataforma. La forma explícita de manejarlo:

```dart
import 'dart:io' show Platform;

Future<int> getBatteryLevel() async {
  if (Platform.isAndroid) {
    return _channel.invokeMethod<int>('getBatteryLevel').then((v) => v ?? -1);
  }
  if (Platform.isIOS) {
    // Distinto nombre de método o distinto formato de respuesta, si aplica.
    return _channel.invokeMethod<int>('getBatteryLevelIOS').then((v) => v ?? -1);
  }
  throw UnsupportedError('Batería no soportada en esta plataforma');
}
```

`Platform.isAndroid`/`Platform.isIOS` (de `dart:io`, no de Flutter) es el mismo mecanismo que ya
mencionan las instrucciones del bootcamp para "siempre considerar diferencias iOS/Android" — un
platform channel es, con frecuencia, el lugar exacto donde esa divergencia se vuelve código real
en vez de una nota mental.

### 4. Un repository que envuelve el channel — no el widget directamente

Igual que el chequeo de permiso (teoría 01), la llamada a `invokeMethod` y el manejo de sus
excepciones pertenecen a una clase dedicada (un repository o servicio), no a un widget. Esto deja
la UI limpia de `try`/`catch` de bajo nivel y hace testeable la lógica con un canal simulado (ver
teoría 06).

## ✅ Checklist de Verificación

- [ ] Sé la diferencia entre `PlatformException` (el nativo respondió con error) y
      `MissingPluginException` (el canal no tiene handler)
- [ ] Sé leer `code`/`message`/`details` de una `PlatformException`
- [ ] Sé usar `Platform.isAndroid`/`Platform.isIOS` para lógica que diverge entre plataformas
- [ ] Sé por qué el manejo de un platform channel vive en un repository, no en el widget

## 📚 Próximo paso

[Buenas Prácticas: Permisos y Testing →](06-buenas-practicas-permisos-y-testing.md)
