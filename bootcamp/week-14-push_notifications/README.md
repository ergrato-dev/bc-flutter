# Semana 14 — Push Notifications

> **Fase 3 — Avanzado** | Semana 14 de 19 | ⏱️ 16 horas

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Configurar Firebase Cloud Messaging en un proyecto Flutter con FlutterFire CLI
- [ ] Solicitar permiso de notificaciones en iOS y Android 13+ (`POST_NOTIFICATIONS`)
- [ ] Obtener y renovar el FCM token del dispositivo (`getToken`, `onTokenRefresh`)
- [ ] Manejar mensajes en los tres estados de la app: foreground, background y terminated
- [ ] Mostrar una notificación local visible cuando el mensaje llega con la app en foreground
- [ ] Navegar a una pantalla específica al tocar una notificación (deep link con el payload)
- [ ] Envolver `FirebaseMessaging` en un repository para poder simularlo en tests

## 📚 Requisitos previos

- Semana 13 completada (permission_handler, platform channels)
- Flutter SDK local configurado (`flutter doctor` sin errores) + Docker
- Cuenta de Google gratuita para crear un proyecto de prueba en
  [Firebase Console](https://console.firebase.google.com/)

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Configuración de Firebase Cloud Messaging](1-teoria/01-configuracion-firebase-cloud-messaging.md)
2. [Fundamentos de FCM: Tokens y Topics](1-teoria/02-fcm-fundamentos-tokens-y-topics.md)
3. [Manejo de Mensajes: Foreground, Background y Terminated](1-teoria/03-manejo-mensajes-foreground-background-terminated.md)
4. [Permisos de Notificaciones](1-teoria/04-permisos-de-notificaciones.md)
5. [Deep Linking desde Notificaciones](1-teoria/05-deep-linking-desde-notificaciones.md)
6. [Buenas Prácticas: Testing y Seguridad](1-teoria/06-buenas-practicas-testing-y-seguridad.md)

### Prácticas

1. [Ejercicio 01 — Configurar Firebase y Obtener el Token](2-practicas/ejercicio-01-configurar-firebase-y-token/README.md)
2. [Ejercicio 02 — Notificación Local en Foreground](2-practicas/ejercicio-02-notificacion-local-foreground/README.md)
3. [Ejercicio 03 — Deep Link al Tocar la Notificación](2-practicas/ejercicio-03-deep-link-notificacion/README.md)

### Proyecto

[Push Notifications](3-proyecto/README.md) — agrega notificaciones push (`firebase_messaging` +
`flutter_local_notifications`) al proyecto Clean Architecture de semanas 10-13.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android con tu propio proyecto de Firebase

## 🔗 Navegación

[← Semana 13 — APIs Nativas y Platform Channels](../week-13-apis_nativas_platform_channels/README.md) | [Semana 15 — Testing →](../week-15-testing/README.md)
