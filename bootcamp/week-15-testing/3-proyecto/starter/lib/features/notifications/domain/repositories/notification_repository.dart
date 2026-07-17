// ============================================
// REPOSITORY (contrato): NotificationRepository
// Envuelve FirebaseMessaging + flutter_local_notifications — el resto de la
// app (AuthCubit, main.dart) depende de esta interfaz, nunca de Firebase
// directamente, para poder simularla en tests. Ver teoría 06.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo (semana 14) — no lo modifiques. Es la
// interfaz que vas a simular en tests esta semana (ver teoría 02).
abstract class NotificationRepository {
  /// Solicita permiso de notificaciones (iOS: diálogo del sistema; Android
  /// 13+: POST_NOTIFICATIONS runtime). En Android 12 o anterior no hay nada
  /// que pedir y devuelve `true` directamente.
  Future<bool> ensurePermission();

  /// Registra el canal de notificaciones (Android) y los listeners de FCM —
  /// llamar una sola vez al arrancar la app, después de `Firebase.initializeApp()`.
  Future<void> initialize();

  /// Emite una ruta (ej. `/items/42`) cada vez que el usuario toca una
  /// notificación cuyo `data` payload apunta a un elemento — tanto si la app
  /// estaba en background como si se abrió desde terminated.
  Stream<String> get onNotificationRoute;
}
