# Glosario — Semana 13: APIs Nativas y Platform Channels

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

---

**geolocator**
Paquete que expone la ubicación GPS del dispositivo, con su propia API de permisos
(`LocationPermission`), independiente de `permission_handler`.

**image_picker**
Paquete que permite capturar una foto con la cámara o elegir una de la galería, retornando un
`XFile?` (`null` si el usuario cancela).

**LocationPermission**
Enum de `geolocator` para el estado de su propio permiso de ubicación (`denied`, `deniedForever`,
`whileInUse`, `always`) — equivalente conceptual a `PermissionStatus` de `permission_handler`, con
nombres distintos.

**MethodChannel**
Canal con nombre único por el que Dart y el código nativo (Kotlin/Swift) se pasan mensajes
serializados — `invokeMethod` del lado Dart, `setMethodCallHandler` del lado nativo.

**MissingPluginException**
Excepción que Dart recibe cuando invoca un método en un canal sin `MethodCallHandler` registrado
del lado nativo — típicamente indica que el nombre del canal no coincide.

**openAppSettings()**
Función de `permission_handler` que abre la pantalla de ajustes de la app — el único camino de
vuelta cuando un permiso quedó en `permanentlyDenied`.

**permission_handler**
Paquete para verificar (`.status`) y solicitar (`.request()`) permisos en runtime, con el enum
`PermissionStatus`.

**PermissionStatus**
Enum de `permission_handler` para el estado de un permiso: `granted`, `denied`,
`permanentlyDenied`, `restricted`.

**PlatformException**
Excepción que Dart recibe cuando el lado nativo de un `MethodChannel` responde con
`result.error(code, message, details)`.

**PlatformException.code / .message / .details**
Los tres campos de una `PlatformException` — identificador corto, descripción legible, y datos
estructurados adicionales, respectivamente.

**Platform.isAndroid / Platform.isIOS**
Getters de `dart:io` para ejecutar lógica distinta según la plataforma — el lugar donde una
divergencia real entre Android e iOS se vuelve código, no solo una nota mental.

**Platform channel**
Mecanismo de comunicación entre Dart y el código nativo de la plataforma anfitriona — la base
sobre la que están construidos todos los plugins de pub.dev que acceden a hardware o APIs del SO.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
