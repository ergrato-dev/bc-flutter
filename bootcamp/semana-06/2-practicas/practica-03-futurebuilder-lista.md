# 💻 Práctica 03: FutureBuilder Lista

## 🎯 Objetivos

- ✅ Dominar FutureBuilder para datos asíncronos
- ✅ Manejar estados: loading, error, success, empty
- ✅ Implementar pull-to-refresh correctamente
- ✅ Crear widgets reutilizables para cada estado

---

## 📋 Descripción

Aprenderás a usar `FutureBuilder` para manejar datos asíncronos de forma declarativa, creando widgets específicos para cada estado de la carga.

**Tiempo estimado:** 45 minutos

---

## 📖 Teoría: FutureBuilder

### ¿Qué es FutureBuilder?

`FutureBuilder` es un widget que construye su UI basándose en el estado de un `Future`.

```dart
FutureBuilder<T>(
  future: myFuture,           // El Future a observar
  builder: (context, snapshot) {
    // snapshot.connectionState → Estado de conexión
    // snapshot.hasData → ¿Tiene datos?
    // snapshot.hasError → ¿Tiene error?
    // snapshot.data → Los datos (si existen)
    // snapshot.error → El error (si existe)
  },
)
```

### Estados de ConnectionState

| Estado | Significado |
|--------|-------------|
| `none` | No hay Future asignado |
| `waiting` | Future en progreso |
| `active` | Future activo (para Streams) |
| `done` | Future completado |

---

## 📝 Implementación

### Paso 1: Crear widgets de estado reutilizables

```dart
/**
 * lib/widgets/state_widgets.dart
 * 
 * Widgets reutilizables para estados de carga
 * 
 * ¿Por qué separarlos?
 * - Consistencia visual en toda la app
 * - Fácil mantenimiento
 * - DRY (Don't Repeat Yourself)
 */
import 'package:flutter/material.dart';

/**
 * LoadingWidget - Estado de carga
 */
class LoadingWidget extends StatelessWidget {
  final String message;

  const LoadingWidget({
    super.key,
    this.message = 'Cargando...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

/**
 * ErrorWidget - Estado de error
 */
class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorDisplayWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Algo salió mal',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/**
 * EmptyWidget - Estado vacío (sin datos)
 */
class EmptyWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  const EmptyWidget({
    super.key,
    this.title = 'No hay datos',
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
```

### Paso 2: Pantalla con FutureBuilder básico

```dart
/**
 * lib/screens/users_futurebuilder_screen.dart
 * 
 * Ejemplo básico de FutureBuilder
 */
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../widgets/state_widgets.dart';

class UsersFutureBuilderScreen extends StatelessWidget {
  const UsersFutureBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios (FutureBuilder)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      /**
       * FutureBuilder básico
       * 
       * ¿Cómo funciona?
       * 1. Ejecuta el Future al construir el widget
       * 2. Muestra loading mientras espera
       * 3. Muestra error si falla
       * 4. Muestra datos si tiene éxito
       * 
       * ⚠️ PROBLEMA: Se ejecuta en cada rebuild
       */
      body: FutureBuilder<List<User>>(
        future: UserService().getUsers(), // ⚠️ Crea nuevo Future cada vez
        builder: (context, snapshot) {
          // Estado: Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Cargando usuarios...');
          }

          // Estado: Error
          if (snapshot.hasError) {
            return ErrorDisplayWidget(
              message: snapshot.error.toString(),
            );
          }

          // Estado: Sin datos
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyWidget(
              title: 'No hay usuarios',
              subtitle: 'No se encontraron usuarios en el sistema',
              icon: Icons.people_outline,
            );
          }

          // Estado: Éxito
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(child: Text(user.name[0])),
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}
```

### Paso 3: FutureBuilder con refresh (correcto)

```dart
/**
 * lib/screens/users_refresh_screen.dart
 * 
 * FutureBuilder con pull-to-refresh
 * 
 * ¿El problema del FutureBuilder básico?
 * - El Future se ejecuta en cada rebuild
 * - No se puede refrescar manualmente
 * 
 * ¿La solución?
 * - Usar StatefulWidget
 * - Guardar el Future en una variable
 * - Recrear el Future solo cuando necesitamos refrescar
 */
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../widgets/state_widgets.dart';

class UsersRefreshScreen extends StatefulWidget {
  const UsersRefreshScreen({super.key});

  @override
  State<UsersRefreshScreen> createState() => _UsersRefreshScreenState();
}

class _UsersRefreshScreenState extends State<UsersRefreshScreen> {
  final UserService _userService = UserService();
  
  // ✅ Guardar el Future en una variable
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _userService.getUsers();
  }

  /**
   * _refreshUsers - Recargar usuarios
   * 
   * ¿Cómo funciona?
   * 1. Crea un nuevo Future
   * 2. setState para reconstruir FutureBuilder
   * 3. FutureBuilder usa el nuevo Future
   */
  Future<void> _refreshUsers() async {
    setState(() {
      _usersFuture = _userService.getUsers();
    });
    // Esperar a que termine para el RefreshIndicator
    await _usersFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshUsers,
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture, // ✅ Usar la variable
        builder: (context, snapshot) {
          // Estado: Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Cargando usuarios...');
          }

          // Estado: Error
          if (snapshot.hasError) {
            return ErrorDisplayWidget(
              message: snapshot.error.toString(),
              onRetry: _refreshUsers,
            );
          }

          // Estado: Sin datos
          final users = snapshot.data;
          if (users == null || users.isEmpty) {
            return EmptyWidget(
              title: 'No hay usuarios',
              subtitle: 'Toca el botón para cargar',
              icon: Icons.people_outline,
              action: ElevatedButton.icon(
                onPressed: _refreshUsers,
                icon: const Icon(Icons.refresh),
                label: const Text('Cargar usuarios'),
              ),
            );
          }

          // Estado: Éxito con RefreshIndicator
          return RefreshIndicator(
            onRefresh: _refreshUsers,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: users.length,
              itemBuilder: (context, index) => _buildUserCard(users[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(User user) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Text(
              '@${user.username}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showUserDetail(user),
      ),
    );
  }

  void _showUserDetail(User user) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              user.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.email, user.email),
            _buildDetailRow(Icons.person, '@${user.username}'),
            _buildDetailRow(Icons.phone, user.phone ?? 'No disponible'),
            _buildDetailRow(Icons.language, user.website ?? 'No disponible'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
```

### Paso 4: Modelo de Usuario

```dart
/**
 * lib/models/user.dart
 */
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String? phone;
  final String? website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.phone,
    this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    if (phone != null) 'phone': phone,
    if (website != null) 'website': website,
  };
}
```

### Paso 5: Servicio de usuarios

```dart
/**
 * lib/services/user_service.dart
 */
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> getUsers() async {
    // Simular delay para ver el loading
    await Future.delayed(const Duration(seconds: 1));
    
    final response = await http.get(Uri.parse('$_baseUrl/users'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => User.fromJson(json)).toList();
    }
    throw Exception('Error al cargar usuarios: ${response.statusCode}');
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$id'));
    
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Usuario no encontrado');
    }
    throw Exception('Error: ${response.statusCode}');
  }
}
```

---

## 🔄 Patrón AsyncValue (Bonus)

```dart
/**
 * AsyncValue - Patrón para manejar estados async
 * 
 * Similar a lo que usa Riverpod
 */
sealed class AsyncValue<T> {
  const AsyncValue();
  
  factory AsyncValue.loading() = AsyncLoading<T>;
  factory AsyncValue.data(T data) = AsyncData<T>;
  factory AsyncValue.error(Object error) = AsyncError<T>;
  
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(Object error) error,
  });
}

class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading();
  
  @override
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(Object error) error,
  }) => loading();
}

class AsyncData<T> extends AsyncValue<T> {
  final T value;
  const AsyncData(this.value);
  
  @override
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(Object error) error,
  }) => data(value);
}

class AsyncError<T> extends AsyncValue<T> {
  final Object err;
  const AsyncError(this.err);
  
  @override
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(Object error) error,
  }) => error(err);
}

// Uso
AsyncValue<List<User>> _usersState = const AsyncLoading();

Widget build(BuildContext context) {
  return _usersState.when(
    loading: () => const LoadingWidget(),
    data: (users) => UsersList(users: users),
    error: (e) => ErrorWidget(message: e.toString()),
  );
}
```

---

## ✅ Puntos de Verificación

- [ ] Loading se muestra mientras carga
- [ ] Error se muestra con mensaje y botón reintentar
- [ ] Lista se muestra correctamente con datos
- [ ] Pull-to-refresh funciona
- [ ] El botón de refresh en AppBar funciona
- [ ] No hay llamadas duplicadas a la API

---

## 🎯 Retos Adicionales

### Reto 1: Shimmer Loading
Reemplaza el CircularProgressIndicator por un efecto shimmer.

### Reto 2: Paginación
Implementa carga infinita (load more al llegar al final).

### Reto 3: Cache
Muestra datos en cache mientras se actualiza.

---

📅 **Anterior:** [← Práctica 02](./practica-02-crud-completo.md) | **Siguiente:** [Práctica 04 →](./practica-04-dio-interceptores.md)
