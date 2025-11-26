# 🔐 Práctica 5: PermissionsManager

## 🎯 Objetivo

Implementar un gestor completo de permisos que solicita, verifica y maneja el estado de múltiples permisos del sistema de forma elegante.

---

## ⏱️ Tiempo Estimado

40 minutos

---

## 📋 Requisitos Funcionales

### Funcionalidades Principales

1. **Verificación de Permisos**
   - Verificar estado de permisos individuales
   - Verificar múltiples permisos a la vez
   - Detectar permisos permanentemente denegados

2. **Solicitud de Permisos**
   - Solicitar permisos individuales
   - Solicitar grupos de permisos
   - Mostrar rationale antes de solicitar

3. **Gestión de Estados**
   - UI reactiva según estado del permiso
   - Guiar al usuario a configuración
   - Manejar cambios de permisos

4. **UX Amigable**
   - Explicar para qué se necesita cada permiso
   - Acciones claras según el estado
   - No bloquear si permiso es opcional

---

## 🛠️ Tecnologías

```yaml
dependencies:
  permission_handler: ^11.1.0
  provider: ^6.1.1
```

---

## 📐 Estructura del Proyecto

```
lib/
├── main.dart
├── providers/
│   └── permissions_provider.dart  # Estado de permisos
├── screens/
│   ├── permissions_screen.dart    # Gestor de permisos
│   └── feature_screen.dart        # Pantalla que requiere permiso
├── widgets/
│   └── permission_tile.dart       # Tile de permiso
└── models/
    └── app_permission.dart        # Modelo de permiso
```

---

## 💻 Código Base

### 1. Modelo de Permiso

```dart
/**
 * AppPermission
 * 
 * Modelo que encapsula información sobre un permiso de la app.
 * Incluye metadatos para UI como nombre, descripción e icono.
 */

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  final Permission permission;
  final String name;
  final String description;
  final IconData icon;
  final bool isRequired;
  
  const AppPermission({
    required this.permission,
    required this.name,
    required this.description,
    required this.icon,
    this.isRequired = false,
  });
  
  /// Permisos de la aplicación definidos estáticamente
  static const List<AppPermission> appPermissions = [
    AppPermission(
      permission: Permission.camera,
      name: 'Cámara',
      description: 'Necesario para tomar fotos y grabar videos',
      icon: Icons.camera_alt,
      isRequired: true,
    ),
    AppPermission(
      permission: Permission.photos,
      name: 'Fotos',
      description: 'Acceder a tu galería de fotos',
      icon: Icons.photo_library,
      isRequired: true,
    ),
    AppPermission(
      permission: Permission.location,
      name: 'Ubicación',
      description: 'Obtener tu ubicación para etiquetar fotos',
      icon: Icons.location_on,
      isRequired: false,
    ),
    AppPermission(
      permission: Permission.notification,
      name: 'Notificaciones',
      description: 'Enviarte recordatorios y actualizaciones',
      icon: Icons.notifications,
      isRequired: false,
    ),
    AppPermission(
      permission: Permission.microphone,
      name: 'Micrófono',
      description: 'Grabar audio en videos',
      icon: Icons.mic,
      isRequired: false,
    ),
    AppPermission(
      permission: Permission.storage,
      name: 'Almacenamiento',
      description: 'Guardar y leer archivos',
      icon: Icons.folder,
      isRequired: false,
    ),
  ];
  
  /// Obtiene los permisos requeridos
  static List<AppPermission> get requiredPermissions =>
      appPermissions.where((p) => p.isRequired).toList();
  
  /// Obtiene los permisos opcionales
  static List<AppPermission> get optionalPermissions =>
      appPermissions.where((p) => !p.isRequired).toList();
}

/// Extensión para obtener información visual del estado
extension PermissionStatusExtension on PermissionStatus {
  String get displayName {
    switch (this) {
      case PermissionStatus.granted:
        return 'Concedido';
      case PermissionStatus.denied:
        return 'Denegado';
      case PermissionStatus.permanentlyDenied:
        return 'Bloqueado';
      case PermissionStatus.restricted:
        return 'Restringido';
      case PermissionStatus.limited:
        return 'Limitado';
      case PermissionStatus.provisional:
        return 'Provisional';
    }
  }
  
  Color get color {
    switch (this) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        return Colors.green;
      case PermissionStatus.denied:
        return Colors.orange;
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        return Colors.red;
    }
  }
  
  IconData get icon {
    switch (this) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        return Icons.check_circle;
      case PermissionStatus.denied:
        return Icons.error;
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        return Icons.block;
    }
  }
}
```

### 2. Provider de Permisos

```dart
/**
 * PermissionsProvider
 * 
 * Gestiona el estado de todos los permisos de la aplicación.
 * Proporciona métodos para verificar, solicitar y monitorear permisos.
 */

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsProvider extends ChangeNotifier {
  // Mapa de estados de permisos
  final Map<Permission, PermissionStatus> _statuses = {};
  
  bool _isLoading = false;
  bool _initialized = false;
  
  // Getters
  bool get isLoading => _isLoading;
  bool get initialized => _initialized;
  
  /// Obtiene el estado de un permiso
  PermissionStatus? getStatus(Permission permission) => _statuses[permission];
  
  /// Verifica si un permiso está concedido
  bool isGranted(Permission permission) =>
      _statuses[permission]?.isGranted ?? false;
  
  /// Verifica si un permiso está permanentemente denegado
  bool isPermanentlyDenied(Permission permission) =>
      _statuses[permission]?.isPermanentlyDenied ?? false;
  
  /// Verifica si todos los permisos requeridos están concedidos
  bool get allRequiredGranted {
    return AppPermission.requiredPermissions.every(
      (p) => _statuses[p.permission]?.isGranted ?? false,
    );
  }
  
  /// Inicializa verificando todos los permisos
  Future<void> initialize() async {
    if (_initialized) return;
    
    _isLoading = true;
    notifyListeners();
    
    await checkAllPermissions();
    
    _isLoading = false;
    _initialized = true;
    notifyListeners();
  }
  
  /// Verifica el estado de todos los permisos
  Future<void> checkAllPermissions() async {
    for (final appPermission in AppPermission.appPermissions) {
      final status = await appPermission.permission.status;
      _statuses[appPermission.permission] = status;
    }
    notifyListeners();
  }
  
  /// Verifica el estado de un permiso específico
  Future<PermissionStatus> checkPermission(Permission permission) async {
    final status = await permission.status;
    _statuses[permission] = status;
    notifyListeners();
    return status;
  }
  
  /// Solicita un permiso específico
  Future<PermissionStatus> requestPermission(Permission permission) async {
    // Si ya está concedido, no solicitar
    if (_statuses[permission]?.isGranted ?? false) {
      return _statuses[permission]!;
    }
    
    // Si está permanentemente denegado, abrir configuración
    if (_statuses[permission]?.isPermanentlyDenied ?? false) {
      await openAppSettings();
      // Re-verificar después de volver de configuración
      return await checkPermission(permission);
    }
    
    // Solicitar el permiso
    final status = await permission.request();
    _statuses[permission] = status;
    notifyListeners();
    
    return status;
  }
  
  /// Solicita múltiples permisos
  Future<Map<Permission, PermissionStatus>> requestMultiple(
    List<Permission> permissions,
  ) async {
    final results = await permissions.request();
    
    results.forEach((permission, status) {
      _statuses[permission] = status;
    });
    
    notifyListeners();
    return results;
  }
  
  /// Solicita todos los permisos requeridos
  Future<bool> requestRequiredPermissions() async {
    final permissions = AppPermission.requiredPermissions
        .map((p) => p.permission)
        .toList();
    
    await requestMultiple(permissions);
    
    return allRequiredGranted;
  }
  
  /// Abre la configuración de la app
  Future<bool> openSettings() async {
    return await openAppSettings();
  }
  
  /// Re-verifica permisos (útil cuando vuelve de configuración)
  Future<void> refresh() async {
    await checkAllPermissions();
  }
}
```

### 3. Tile de Permiso

```dart
/**
 * PermissionTile
 * 
 * Widget que muestra el estado de un permiso y permite solicitar/gestionar.
 */

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PermissionTile extends StatelessWidget {
  final AppPermission appPermission;
  
  const PermissionTile({
    Key? key,
    required this.appPermission,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Consumer<PermissionsProvider>(
      builder: (context, provider, _) {
        final status = provider.getStatus(appPermission.permission);
        
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: status?.color.withOpacity(0.2) ?? Colors.grey[200],
              child: Icon(
                appPermission.icon,
                color: status?.color ?? Colors.grey,
              ),
            ),
            title: Row(
              children: [
                Text(appPermission.name),
                if (appPermission.isRequired) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Requerido',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appPermission.description,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      status?.icon ?? Icons.help,
                      size: 14,
                      color: status?.color ?? Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status?.displayName ?? 'Desconocido',
                      style: TextStyle(
                        color: status?.color ?? Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: _buildAction(context, provider, status),
            isThreeLine: true,
          ),
        );
      },
    );
  }
  
  Widget _buildAction(
    BuildContext context,
    PermissionsProvider provider,
    PermissionStatus? status,
  ) {
    // Permiso concedido - mostrar check
    if (status?.isGranted ?? false) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
    
    // Permanentemente denegado - botón de configuración
    if (status?.isPermanentlyDenied ?? false) {
      return TextButton(
        onPressed: () async {
          await provider.openSettings();
          // Refrescar cuando vuelva
          await provider.refresh();
        },
        child: const Text('Configurar'),
      );
    }
    
    // Denegado o no solicitado - botón de solicitar
    return ElevatedButton(
      onPressed: () => _requestPermission(context, provider),
      child: const Text('Permitir'),
    );
  }
  
  Future<void> _requestPermission(
    BuildContext context,
    PermissionsProvider provider,
  ) async {
    // Mostrar rationale antes de solicitar
    final shouldRequest = await _showRationale(context);
    
    if (!shouldRequest) return;
    
    final status = await provider.requestPermission(appPermission.permission);
    
    // Mostrar feedback según resultado
    if (context.mounted) {
      _showResultSnackBar(context, status);
    }
  }
  
  Future<bool> _showRationale(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permiso: ${appPermission.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              appPermission.icon,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              appPermission.description,
              textAlign: TextAlign.center,
            ),
            if (appPermission.isRequired) ...[
              const SizedBox(height: 16),
              const Text(
                'Este permiso es necesario para el funcionamiento de la app.',
                style: TextStyle(
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Ahora no'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continuar'),
          ),
        ],
      ),
    ) ?? false;
  }
  
  void _showResultSnackBar(BuildContext context, PermissionStatus status) {
    final message = status.isGranted
        ? '${appPermission.name} habilitado'
        : status.isPermanentlyDenied
            ? 'Permiso bloqueado. Ve a Configuración para habilitarlo.'
            : 'Permiso denegado';
    
    final color = status.isGranted ? Colors.green : Colors.orange;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        action: status.isPermanentlyDenied
            ? SnackBarAction(
                label: 'Configurar',
                textColor: Colors.white,
                onPressed: openAppSettings,
              )
            : null,
      ),
    );
  }
}
```

### 4. Pantalla de Permisos

```dart
/**
 * PermissionsScreen
 * 
 * Pantalla que muestra y gestiona todos los permisos de la app.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermissionsScreen extends StatefulWidget {
  final bool showOnlyRequired;
  final VoidCallback? onAllRequiredGranted;
  
  const PermissionsScreen({
    Key? key,
    this.showOnlyRequired = false,
    this.onAllRequiredGranted,
  }) : super(key: key);
  
  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Inicializar permisos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PermissionsProvider>().initialize();
    });
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  /// Detecta cuando la app vuelve al primer plano
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refrescar permisos al volver
      context.read<PermissionsProvider>().refresh();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PermissionsProvider>().refresh();
            },
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: Consumer<PermissionsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          final permissions = widget.showOnlyRequired
              ? AppPermission.requiredPermissions
              : AppPermission.appPermissions;
          
          return Column(
            children: [
              // Header informativo
              _buildHeader(provider),
              
              // Lista de permisos
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: permissions.length,
                  itemBuilder: (context, index) {
                    return PermissionTile(
                      appPermission: permissions[index],
                    );
                  },
                ),
              ),
              
              // Botón de continuar (si aplica)
              if (widget.showOnlyRequired)
                _buildContinueButton(provider),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildHeader(PermissionsProvider provider) {
    final granted = AppPermission.appPermissions
        .where((p) => provider.isGranted(p.permission))
        .length;
    final total = AppPermission.appPermissions.length;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        children: [
          Text(
            '$granted de $total permisos habilitados',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: granted / total,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 8),
          if (!provider.allRequiredGranted)
            const Text(
              'Algunos permisos son necesarios para usar la app',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
  
  Widget _buildContinueButton(PermissionsProvider provider) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: provider.allRequiredGranted
                ? () {
                    widget.onAllRequiredGranted?.call();
                    Navigator.pop(context, true);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              provider.allRequiredGranted
                  ? 'Continuar'
                  : 'Habilita los permisos requeridos',
            ),
          ),
        ),
      ),
    );
  }
}
```

### 5. Pantalla que Requiere Permiso

```dart
/**
 * FeatureScreen
 * 
 * Ejemplo de pantalla que requiere un permiso específico.
 * Verifica el permiso antes de mostrar la funcionalidad.
 */

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CameraFeatureScreen extends StatelessWidget {
  const CameraFeatureScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cámara'),
      ),
      body: Consumer<PermissionsProvider>(
        builder: (context, provider, _) {
          final hasPermission = provider.isGranted(Permission.camera);
          
          if (hasPermission) {
            return _buildCameraView();
          }
          
          return _buildPermissionRequest(context, provider);
        },
      ),
    );
  }
  
  Widget _buildCameraView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt, size: 80, color: Colors.green),
          SizedBox(height: 16),
          Text(
            '¡Permiso concedido!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Aquí iría la vista de la cámara'),
        ],
      ),
    );
  }
  
  Widget _buildPermissionRequest(
    BuildContext context,
    PermissionsProvider provider,
  ) {
    final isPermanentlyDenied = provider.isPermanentlyDenied(Permission.camera);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'Permiso de Cámara Requerido',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              isPermanentlyDenied
                  ? 'Has bloqueado el acceso a la cámara. '
                      'Ve a Configuración para habilitarlo.'
                  : 'Necesitamos acceso a la cámara para tomar fotos.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                if (isPermanentlyDenied) {
                  await openAppSettings();
                  await provider.refresh();
                } else {
                  await provider.requestPermission(Permission.camera);
                }
              },
              icon: Icon(
                isPermanentlyDenied ? Icons.settings : Icons.check,
              ),
              label: Text(
                isPermanentlyDenied ? 'Ir a Configuración' : 'Dar Permiso',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 6. Main con Provider

```dart
/**
 * main.dart
 * 
 * Configuración de la app con PermissionsProvider.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PermissionsProvider(),
      child: MaterialApp(
        title: 'Permissions Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Navegar al gestor de permisos
          Card(
            child: ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Gestionar Permisos'),
              subtitle: const Text('Ver y configurar todos los permisos'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PermissionsScreen(),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Feature que requiere permiso
          Card(
            child: ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Usar Cámara'),
              subtitle: const Text('Requiere permiso de cámara'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CameraFeatureScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Verificación de estado | 2 | Verifica correctamente estado de permisos |
| Solicitud de permisos | 2 | Solicita permisos con rationale |
| Manejo de estados | 2 | UI reactiva según estado |
| Permanently denied | 2 | Guía a configuración correctamente |
| Código limpio | 1 | Provider pattern, documentación |
| UX amigable | 1 | Mensajes claros, acciones obvias |
| **Total** | **10** | |

---

## 🎁 Bonus

- [ ] Verificar permisos al volver de background (+0.5)
- [ ] Agrupar permisos por categoría (+0.5)
- [ ] Animaciones en cambios de estado (+0.5)
- [ ] Tests unitarios del provider (+0.5)

---

## 🔗 Navegación

| Anterior | Índice | Siguiente |
|----------|--------|-----------|
| [SensorDashboard](./practica-04-sensor-dashboard.md) | [Prácticas](./README.md) | [Proyecto](../3-proyecto/README.md) |
