# Rúbrica de Evaluación — Semana 14

## Distribución de Puntaje

| Tipo de Evidencia    | Peso | Instrumento             |
| --------------------- | ---- | ------------------------ |
| Conocimiento 🧠      | 30%  | Cuestionario teórico     |
| Desempeño 💪         | 40%  | Ejercicios en clase      |
| Producto 📦          | 30%  | Proyecto entregable      |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

| Criterio | Puntos |
|---|---|
| FCM token vs topic — cuándo usar cada uno, `getToken`/`onTokenRefresh`/`subscribeToTopic` | 20 |
| Los tres estados de la app ante un mensaje: foreground (`onMessage`), background (`onMessageOpenedApp`), terminated (`getInitialMessage`) | 25 |
| Por qué Android no muestra el mensaje en foreground sin `flutter_local_notifications` (iOS sí) | 15 |
| `requestPermission()` (iOS) vs `POST_NOTIFICATIONS` runtime (Android 13+) | 15 |
| Por qué el server key de FCM nunca debe viajar al cliente | 10 |
| Por qué envolver `FirebaseMessaging` en un repository lo hace testeable | 15 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (configurar Firebase y token) | 25 | Los pasos descomentados, `Firebase.initializeApp()` exitoso, token visible en pantalla |
| Ejercicio 02 (notificación local en foreground) | 35 | Los pasos descomentados, `onMessage` dispara una notificación visible vía `flutter_local_notifications` |
| Ejercicio 03 (deep link al tocar) | 40 | Los pasos descomentados, `onMessageOpenedApp` y `getInitialMessage` navegan a la pantalla correcta según el payload |

## 📦 Producto (30%)

Proyecto **Push Notifications**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `NotificationRepository` envuelve `FirebaseMessaging` — permiso solicitado al iniciar sesión | 25 |
| Notificación en foreground visible vía `flutter_local_notifications`, con el `channelId` correcto en Android | 20 |
| Tocar la notificación navega a `DetailScreen` del elemento correspondiente (`itemId` en el `data` payload) | 25 |
| Arquitectura, animaciones y foto de semanas 10-13 sin romper | 15 |
| `flutter analyze` sin errores y `flutter test` pasando (con un `NotificationRepository` falso, sin Firebase real) | 15 |

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ App funcional en emulador/simulador iOS y/o Android con proyecto de Firebase propio
- ✅ `flutter analyze` sin errores
- ✅ `flutter test` pasando (verificable con Docker:
  `docker compose run --rm flutter flutter test`)
- ✅ Sin `google-services.json`/`GoogleService-Info.plist` reales commiteados

## Escala de Calificación

| Rango | Nivel |
|---|---|
| 90-100% | Sobresaliente |
| 80-89% | Notable |
| 70-79% | Aprobado |
| < 70% | No aprobado (requiere recuperación) |

## Formato de Entrega

- Repositorio del estudiante, carpeta `week-14/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-14): complete push notifications project`
- Fecha límite: fin de la semana 14, antes de iniciar semana 15
