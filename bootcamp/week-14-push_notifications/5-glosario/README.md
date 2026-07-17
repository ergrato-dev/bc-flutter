# Glosario — Semana 14: Push Notifications

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

---

**Background message handler**
Función top-level (fuera de cualquier clase) anotada con `@pragma('vm:entry-point')` que
`firebase_messaging` invoca en un isolate propio cuando llega un mensaje con la app en
background — no puede acceder al estado de los widgets.

**FCM (Firebase Cloud Messaging)**
Servicio gratuito de Google para enviar mensajes push a apps Android, iOS y web desde un backend
o la consola de Firebase, sin mantener conexiones propias con cada dispositivo.

**FCM token**
Identificador único que Firebase asigna a una instalación de la app en un dispositivo — el
backend lo usa para enviarle un mensaje dirigido. Cambia si se reinstala la app o se limpian
los datos (`onTokenRefresh`).

**Foreground / background / terminated**
Los tres estados posibles de la app cuando llega un mensaje — cada uno dispara un callback
distinto de `firebase_messaging` (`onMessage`, `onMessageOpenedApp`, `getInitialMessage`).

**flutter_local_notifications**
Paquete que muestra una notificación nativa visible en la barra de estado — necesario porque
FCM no la despliega automáticamente cuando la app está en foreground (ver teoría 03).

**FlutterFire CLI**
Herramienta oficial (`dart pub global activate flutterfire_cli`) que genera
`firebase_options.dart` y configura los proyectos nativos (Android/iOS) a partir de un proyecto
de Firebase — reemplaza la configuración manual de `google-services.json`.

**Notification channel (Android)**
Categoría de notificaciones en Android 8+ (`NotificationChannel`) con su propio nivel de
importancia y sonido — el usuario las administra por separado en ajustes del sistema.

**onMessage**
Stream de `firebase_messaging` que emite cuando llega un mensaje con la app abierta en
foreground — el único caso donde el desarrollador debe mostrar la notificación manualmente.

**onMessageOpenedApp**
Stream que emite cuando el usuario toca una notificación y la app pasa de background a
foreground — el lugar típico para hacer deep linking con el payload del mensaje.

**getInitialMessage()**
Método que devuelve el mensaje que abrió la app desde el estado terminated (cerrada) — se
consulta una sola vez al iniciar, antes de montar el árbol de widgets de navegación.

**Payload / data message**
Datos adicionales (`Map<String, String>`) que viaja junto a un mensaje FCM — el lugar donde se
codifica, por ejemplo, el `itemId` al que debe navegar la app al tocar la notificación.

**Server key / Server Key API**
Credencial privada de Firebase para enviar mensajes desde un backend — nunca debe incluirse en
el código cliente ni en un repositorio público.

**Topic**
Canal de suscripción (`subscribeToTopic('promos')`) al que cualquier dispositivo puede
suscribirse — permite enviar un mensaje a todos los suscriptores sin conocer sus tokens
individuales.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
