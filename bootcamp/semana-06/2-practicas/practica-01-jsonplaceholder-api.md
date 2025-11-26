# 💻 Práctica 01: JSONPlaceholder API

## 🎯 Objetivos

- ✅ Configurar el paquete http en Flutter
- ✅ Realizar peticiones GET a una API real
- ✅ Crear modelos de datos con fromJson
- ✅ Mostrar datos en una lista

---

## 📋 Descripción

En esta práctica consumirás la API gratuita JSONPlaceholder para obtener y mostrar una lista de posts con sus detalles.

**API:** https://jsonplaceholder.typicode.com

**Tiempo estimado:** 40 minutos

---

## 🔧 Configuración Inicial

### Paso 1: Agregar dependencia

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

```bash
flutter pub get
```

### Paso 2: Crear estructura de proyecto

```
lib/
├── main.dart
├── models/
│   └── post.dart
├── services/
│   └── post_service.dart
└── screens/
    └── posts_screen.dart
```

---

## 📝 Implementación

### Paso 3: Crear el modelo Post

```dart
/**
 * lib/models/post.dart
 * 
 * Post - Modelo de publicación
 * 
 * ¿Qué hace?
 * Representa un post de la API JSONPlaceholder
 * 
 * ¿Estructura de la API?
 * {
 *   "userId": 1,
 *   "id": 1,
 *   "title": "sunt aut facere...",
 *   "body": "quia et suscipit..."
 * }
 */
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /**
   * fromJson - Deserializar JSON a objeto Post
   * 
   * ¿Cómo funciona?
   * 1. Recibe el Map del JSON decodificado
   * 2. Extrae cada campo por su key
   * 3. Crea y retorna la instancia de Post
   */
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  /**
   * toJson - Serializar objeto a Map
   * 
   * ¿Para qué?
   * Enviar datos al servidor (POST, PUT)
   */
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() => 'Post(id: $id, title: $title)';
}
```

### Paso 4: Crear el servicio de API

```dart
/**
 * lib/services/post_service.dart
 * 
 * PostService - Servicio para consumir la API de posts
 * 
 * ¿Qué hace?
 * Centraliza todas las operaciones HTTP relacionadas con posts
 * 
 * ¿Por qué un servicio separado?
 * - Separación de responsabilidades
 * - Fácil de testear
 * - Reutilizable en toda la app
 */
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  // URL base de la API
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /**
   * getPosts - Obtener todos los posts
   * 
   * ¿Cómo funciona?
   * 1. Realiza GET a /posts
   * 2. Verifica el código de estado
   * 3. Decodifica el JSON
   * 4. Convierte cada elemento a Post
   * 5. Retorna la lista
   */
  Future<List<Post>> getPosts() async {
    try {
      // Construir URI
      final uri = Uri.parse('$_baseUrl/posts');
      
      // Realizar petición GET
      final response = await http.get(uri);
      
      // Verificar respuesta exitosa
      if (response.statusCode == 200) {
        // Decodificar JSON (lista de objetos)
        final List<dynamic> jsonData = jsonDecode(response.body);
        
        // Convertir cada JSON a objeto Post
        return jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /**
   * getPostById - Obtener un post específico
   * 
   * @param id - ID del post a obtener
   */
  Future<Post> getPostById(int id) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts/$id');
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Post.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Post no encontrado');
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /**
   * getPostsByUser - Obtener posts de un usuario
   * 
   * @param userId - ID del usuario
   * 
   * ¿Cómo filtrar?
   * Usando query parameters: /posts?userId=1
   */
  Future<List<Post>> getPostsByUser(int userId) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts').replace(
        queryParameters: {'userId': userId.toString()},
      );
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
```

### Paso 5: Crear la pantalla de posts

```dart
/**
 * lib/screens/posts_screen.dart
 * 
 * PostsScreen - Pantalla que muestra la lista de posts
 * 
 * ¿Qué hace?
 * - Carga posts al iniciar
 * - Muestra loading mientras carga
 * - Muestra error si falla
 * - Lista los posts en cards
 */
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  // Servicio de API
  final PostService _postService = PostService();
  
  // Estados
  List<Post> _posts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  /**
   * _loadPosts - Cargar posts desde la API
   * 
   * ¿Cómo maneja los estados?
   * 1. Inicia con isLoading = true
   * 2. Intenta cargar los datos
   * 3. Si éxito: guarda posts, isLoading = false
   * 4. Si error: guarda mensaje, isLoading = false
   */
  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final posts = await _postService.getPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Botón para recargar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPosts,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  /**
   * _buildBody - Construir contenido según estado
   * 
   * Estados posibles:
   * - Loading: CircularProgressIndicator
   * - Error: Mensaje + botón reintentar
   * - Éxito: Lista de posts
   */
  Widget _buildBody() {
    // Estado: Cargando
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando posts...'),
          ],
        ),
      );
    }

    // Estado: Error
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error al cargar',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadPosts,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    // Estado: Lista vacía
    if (_posts.isEmpty) {
      return const Center(
        child: Text('No hay posts disponibles'),
      );
    }

    // Estado: Éxito - Mostrar lista
    return RefreshIndicator(
      onRefresh: _loadPosts,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return _buildPostCard(post);
        },
      ),
    );
  }

  /**
   * _buildPostCard - Card individual de post
   */
  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            '${post.id}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          post.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          post.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          'User ${post.userId}',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        onTap: () => _showPostDetail(post),
      ),
    );
  }

  /**
   * _showPostDetail - Mostrar detalle del post
   */
  void _showPostDetail(Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              // Handle
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
              // Título
              Text(
                post.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              // Metadata
              Row(
                children: [
                  Chip(
                    avatar: const Icon(Icons.tag, size: 16),
                    label: Text('Post #${post.id}'),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    avatar: const Icon(Icons.person, size: 16),
                    label: Text('User ${post.userId}'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              // Contenido
              Text(
                post.body,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Paso 6: Actualizar main.dart

```dart
/**
 * lib/main.dart
 */
import 'package:flutter/material.dart';
import 'screens/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSONPlaceholder Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PostsScreen(),
    );
  }
}
```

---

## ✅ Puntos de Verificación

Antes de continuar, verifica:

- [ ] La app compila sin errores
- [ ] Se muestra el loading al iniciar
- [ ] Se cargan los 100 posts de la API
- [ ] Cada post muestra título, body y usuario
- [ ] El pull-to-refresh funciona
- [ ] Al tocar un post se muestra el detalle
- [ ] El botón de refrescar en el AppBar funciona

---

## 🎯 Retos Adicionales

### Reto 1: Agregar búsqueda
Implementa un `SearchBar` que filtre los posts por título.

### Reto 2: Limitar resultados
Modifica el servicio para cargar solo los primeros 20 posts usando query params.

### Reto 3: Modelo de Usuario
Crea el modelo `User` y consume el endpoint `/users` para mostrar el nombre del autor.

---

## 📚 Recursos

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/)
- [http Package](https://pub.dev/packages/http)
- [Flutter JSON](https://docs.flutter.dev/data-and-backend/serialization/json)

---

📅 **Siguiente:** [Práctica 02 - CRUD Completo →](./practica-02-crud-completo.md)
