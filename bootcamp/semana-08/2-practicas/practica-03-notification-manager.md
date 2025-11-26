# 🔔 Práctica 3: NotificationManager

## 🎯 Objetivo

Implementar un sistema completo de notificaciones locales con notificaciones inmediatas, programadas, y con acciones personalizadas.

---

## ⏱️ Tiempo Estimado

45 minutos

---

## 📋 Requisitos Funcionales

### Funcionalidades Principales

1. **Notificaciones Inmediatas**

   - Mostrar notificación simple
   - Notificación con título y cuerpo
   - Diferentes niveles de importancia

2. **Notificaciones Programadas**

   - Programar para fecha/hora específica
   - Notificaciones periódicas
   - Cancelar notificaciones pendientes

3. **Gestión de Notificaciones**

   - Ver lista de notificaciones pendientes
   - Cancelar notificación individual
   - Cancelar todas las notificaciones

4. **Acciones y Payloads**
   - Manejar tap en notificación
   - Navegar según payload
   - Botones de acción

---

## 🛠️ Tecnologías

```yaml
dependencies:
  flutter_local_notifications: ^16.1.0
  timezone: ^0.9.2
  permission_handler: ^11.1.0
```

---

## 📐 Estructura del Proyecto

```
lib/
├── main.dart
├── services/
│   └── notification_service.dart  # Servicio de notificaciones
├── screens/
│   ├── home_screen.dart           # Pantalla principal
│   ├── schedule_screen.dart       # Programar notificación
│   └── pending_screen.dart        # Ver pendientes
└── models/
    └── scheduled_notification.dart # Modelo de notificación
```

---

## 💻 Código Base

### 1. Servicio de Notificaciones

```dart
/**
 * NotificationService
 *
 * Servicio singleton para gestionar todas las notificaciones locales.
 * Inicializar una sola vez al inicio de la app.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// Callback para manejar tap en notificaciones
typedef NotificationCallback = void Function(String? payload);

class NotificationService {
  // Singleton
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Stream para notificaciones recibidas
  final StreamController<String?> _notificationController =
      StreamController<String?>.broadcast();

  Stream<String?> get notificationStream => _notificationController.stream;

  bool _isInitialized = false;

  /// Inicializa el servicio de notificaciones
  Future<void> initialize({NotificationCallback? onNotificationTap}) async {
    if (_isInitialized) return;

    // Inicializar timezone
    tz_data.initializeTimeZones();

    // Configuración Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        _notificationController.add(response.payload);
        onNotificationTap?.call(response.payload);
      },
    );

    // Crear canales de notificación
    await _createChannels();

    _isInitialized = true;
  }

  /// Crea los canales de notificación para Android
  Future<void> _createChannels() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;

    // Canal general
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'general',
        'General',
        description: 'Notificaciones generales',
        importance: Importance.defaultImportance,
      ),
    );

    // Canal de alta prioridad
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'high_priority',
        'Alta Prioridad',
        description: 'Notificaciones importantes',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
    );

    // Canal de recordatorios
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'reminders',
        'Recordatorios',
        description: 'Recordatorios programados',
        importance: Importance.high,
      ),
    );
  }

  /// Solicita permiso de notificaciones (Android 13+)
  Future<bool> requestPermission() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      return await androidPlugin.requestNotificationsPermission() ?? false;
    }

    return true;
  }

  /// Muestra una notificación inmediata
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.normal,
  }) async {
    final channelId = priority == NotificationPriority.high
        ? 'high_priority'
        : 'general';

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId,
      importance: priority == NotificationPriority.high
          ? Importance.high
          : Importance.defaultImportance,
      priority: priority == NotificationPriority.high
          ? Priority.high
          : Priority.defaultPriority,
    );

    const iosDetails = DarwinNotificationDetails();

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(id, title, body, details, payload: payload);
  }

  /// Muestra una notificación con texto expandible
  Future<void> showBigTextNotification({
    required int id,
    required String title,
    required String body,
    required String bigText,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'general',
      'General',
      styleInformation: BigTextStyleInformation(
        bigText,
        contentTitle: title,
        summaryText: 'Expandir para ver más',
      ),
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await _plugin.show(id, title, body, details, payload: payload);
  }

  /// Programa una notificación para una fecha/hora específica
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    final androidDetails = const AndroidNotificationDetails(
      'reminders',
      'Recordatorios',
      importance: Importance.high,
      priority: Priority.high,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  /// Programa una notificación periódica
  Future<void> schedulePeriodicNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval interval,
    String? payload,
  }) async {
    final androidDetails = const AndroidNotificationDetails(
      'reminders',
      'Recordatorios',
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await _plugin.periodicallyShow(
      id,
      title,
      body,
      interval,
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  /// Cancela una notificación específica
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  /// Cancela todas las notificaciones
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  /// Obtiene las notificaciones pendientes
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }

  /// Obtiene las notificaciones activas (en la bandeja)
  Future<List<ActiveNotification>> getActiveNotifications() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    return await androidPlugin?.getActiveNotifications() ?? [];
  }

  void dispose() {
    _notificationController.close();
  }
}

enum NotificationPriority { normal, high }
```

### 2. Pantalla Principal

```dart
/**
 * HomeScreen
 *
 * Pantalla principal con opciones para enviar y gestionar notificaciones.
 */

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationService _notificationService = NotificationService();
  int _notificationId = 0;

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    await _notificationService.initialize(
      onNotificationTap: (payload) {
        if (payload != null) {
          _showPayloadDialog(payload);
        }
      },
    );

    await _notificationService.requestPermission();
  }

  void _showPayloadDialog(String payload) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notificación recibida'),
        content: Text('Payload: $payload'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendSimpleNotification() async {
    await _notificationService.showNotification(
      id: _notificationId++,
      title: '¡Hola Flutter!',
      body: 'Esta es una notificación simple',
      payload: 'simple_${DateTime.now().millisecondsSinceEpoch}',
    );

    _showSnackBar('Notificación enviada');
  }

  Future<void> _sendHighPriorityNotification() async {
    await _notificationService.showNotification(
      id: _notificationId++,
      title: '¡Urgente!',
      body: 'Esta notificación es de alta prioridad',
      payload: 'high_priority',
      priority: NotificationPriority.high,
    );

    _showSnackBar('Notificación de alta prioridad enviada');
  }

  Future<void> _sendBigTextNotification() async {
    await _notificationService.showBigTextNotification(
      id: _notificationId++,
      title: 'Artículo Nuevo',
      body: 'Toca para expandir...',
      bigText: 'Este es un texto mucho más largo que se muestra cuando '
          'el usuario expande la notificación deslizando hacia abajo. '
          'Puedes incluir mucha más información aquí para dar contexto '
          'adicional sobre el contenido de la notificación. '
          'Esto es especialmente útil para mensajes o correos.',
      payload: 'big_text',
    );

    _showSnackBar('Notificación expandible enviada');
  }

  Future<void> _scheduleNotification() async {
    final scheduledDate = DateTime.now().add(const Duration(seconds: 10));

    await _notificationService.scheduleNotification(
      id: _notificationId++,
      title: 'Recordatorio',
      body: '¡Han pasado 10 segundos!',
      scheduledDate: scheduledDate,
      payload: 'scheduled_10s',
    );

    _showSnackBar('Notificación programada para 10 segundos');
  }

  void _openScheduleScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleScreen(
          notificationService: _notificationService,
        ),
      ),
    );
  }

  void _openPendingScreen() async {
    final pending = await _notificationService.getPendingNotifications();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PendingScreen(
          pendingNotifications: pending,
          notificationService: _notificationService,
          onCancelled: () {
            _showSnackBar('Notificación cancelada');
          },
        ),
      ),
    );
  }

  Future<void> _cancelAll() async {
    await _notificationService.cancelAllNotifications();
    _showSnackBar('Todas las notificaciones canceladas');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _openPendingScreen,
            tooltip: 'Ver pendientes',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Sección: Notificaciones Inmediatas
          _buildSectionHeader('Notificaciones Inmediatas'),

          _buildNotificationButton(
            icon: Icons.notifications,
            label: 'Simple',
            description: 'Notificación básica con título y cuerpo',
            color: Colors.blue,
            onPressed: _sendSimpleNotification,
          ),

          _buildNotificationButton(
            icon: Icons.priority_high,
            label: 'Alta Prioridad',
            description: 'Notificación importante con heads-up',
            color: Colors.red,
            onPressed: _sendHighPriorityNotification,
          ),

          _buildNotificationButton(
            icon: Icons.text_snippet,
            label: 'Texto Expandible',
            description: 'Notificación con texto largo expandible',
            color: Colors.purple,
            onPressed: _sendBigTextNotification,
          ),

          const SizedBox(height: 24),

          // Sección: Notificaciones Programadas
          _buildSectionHeader('Notificaciones Programadas'),

          _buildNotificationButton(
            icon: Icons.timer,
            label: 'En 10 segundos',
            description: 'Programar notificación rápida',
            color: Colors.orange,
            onPressed: _scheduleNotification,
          ),

          _buildNotificationButton(
            icon: Icons.schedule,
            label: 'Programar Personalizada',
            description: 'Elegir fecha y hora específica',
            color: Colors.teal,
            onPressed: _openScheduleScreen,
          ),

          const SizedBox(height: 24),

          // Sección: Gestión
          _buildSectionHeader('Gestión'),

          _buildNotificationButton(
            icon: Icons.clear_all,
            label: 'Cancelar Todas',
            description: 'Eliminar todas las notificaciones pendientes',
            color: Colors.grey,
            onPressed: _cancelAll,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNotificationButton({
    required IconData icon,
    required String label,
    required String description,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(label),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onPressed,
      ),
    );
  }
}
```

### 3. Pantalla de Programación

```dart
/**
 * ScheduleScreen
 *
 * Pantalla para programar una notificación con fecha y hora personalizadas.
 */

import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  final NotificationService notificationService;

  const ScheduleScreen({
    Key? key,
    required this.notificationService,
  }) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(hours: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  DateTime get _scheduledDateTime {
    return DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
  }

  Future<void> _scheduleNotification() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un título')),
      );
      return;
    }

    if (_scheduledDateTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La fecha debe ser en el futuro')),
      );
      return;
    }

    await widget.notificationService.scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: _titleController.text,
      body: _bodyController.text.isEmpty
          ? 'Notificación programada'
          : _bodyController.text,
      scheduledDate: _scheduledDateTime,
      payload: 'scheduled_custom',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Notificación programada para ${_formatDateTime(_scheduledDateTime)}',
        ),
      ),
    );

    Navigator.pop(context);
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programar Notificación'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),

            const SizedBox(height: 16),

            // Cuerpo
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Mensaje (opcional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            // Fecha
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Fecha'),
              subtitle: Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectDate,
            ),

            // Hora
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Hora'),
              subtitle: Text(
                '${_selectedTime.hour.toString().padLeft(2, '0')}:'
                '${_selectedTime.minute.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectTime,
            ),

            const SizedBox(height: 32),

            // Botón de programar
            ElevatedButton.icon(
              onPressed: _scheduleNotification,
              icon: const Icon(Icons.schedule_send),
              label: const Text('Programar Notificación'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 4. Pantalla de Pendientes

```dart
/**
 * PendingScreen
 *
 * Muestra las notificaciones pendientes y permite cancelarlas.
 */

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PendingScreen extends StatefulWidget {
  final List<PendingNotificationRequest> pendingNotifications;
  final NotificationService notificationService;
  final VoidCallback onCancelled;

  const PendingScreen({
    Key? key,
    required this.pendingNotifications,
    required this.notificationService,
    required this.onCancelled,
  }) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late List<PendingNotificationRequest> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(widget.pendingNotifications);
  }

  Future<void> _cancelNotification(PendingNotificationRequest notification) async {
    await widget.notificationService.cancelNotification(notification.id);

    setState(() {
      _notifications.removeWhere((n) => n.id == notification.id);
    });

    widget.onCancelled();
  }

  Future<void> _cancelAll() async {
    await widget.notificationService.cancelAllNotifications();

    setState(() {
      _notifications.clear();
    });

    widget.onCancelled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones Pendientes'),
        actions: [
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _cancelAll,
              tooltip: 'Cancelar todas',
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay notificaciones pendientes',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Dismissible(
                  key: Key(notification.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _cancelNotification(notification),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.schedule),
                    ),
                    title: Text(notification.title ?? 'Sin título'),
                    subtitle: Text(notification.body ?? 'Sin contenido'),
                    trailing: Text(
                      'ID: ${notification.id}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio                  | Puntos | Descripción                                |
| ------------------------- | ------ | ------------------------------------------ |
| Inicialización            | 1.5    | Configura canales y permisos correctamente |
| Notificaciones inmediatas | 2      | Muestra diferentes tipos de notificaciones |
| Programación              | 2      | Programa notificaciones para fecha/hora    |
| Gestión                   | 2      | Lista, cancela individual y masivamente    |
| Payload handling          | 1.5    | Maneja tap y payloads correctamente        |
| Código limpio             | 1      | Documentación y estructura                 |
| **Total**                 | **10** |                                            |

---

## 🎁 Bonus

- [ ] Notificaciones con botones de acción (+1)
- [ ] Notificaciones con imagen (+0.5)
- [ ] Notificaciones periódicas configurables (+0.5)

---

## 🔗 Navegación

| Anterior                                             | Índice                   | Siguiente                                            |
| ---------------------------------------------------- | ------------------------ | ---------------------------------------------------- |
| [LocationTracker](./practica-02-location-tracker.md) | [Prácticas](./README.md) | [SensorDashboard](./practica-04-sensor-dashboard.md) |
