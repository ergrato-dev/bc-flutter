# 💻 Práctica 02: CRUD Completo

## 🎯 Objetivos

- ✅ Implementar operaciones POST, PUT y DELETE
- ✅ Crear formularios para enviar datos
- ✅ Manejar respuestas de creación y actualización
- ✅ Implementar confirmación antes de eliminar

---

## 📋 Descripción

Extenderás la práctica anterior implementando todas las operaciones CRUD (Create, Read, Update, Delete) sobre los posts de JSONPlaceholder.

**Nota:** JSONPlaceholder simula las operaciones pero no persiste los cambios. Las respuestas son simuladas correctamente.

**Tiempo estimado:** 50 minutos

---

## 📝 Implementación

### Paso 1: Extender el servicio con operaciones CRUD

```dart
/**
 * lib/services/post_service.dart (actualizado)
 *
 * PostService - Servicio CRUD completo
 *
 * Operaciones:
 * - GET: Obtener posts (ya implementado)
 * - POST: Crear nuevo post
 * - PUT: Actualizar post existente
 * - DELETE: Eliminar post
 */
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Headers comunes para JSON
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // ==================== READ ====================

  /// Obtener todos los posts
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    }
    throw Exception('Error al obtener posts: ${response.statusCode}');
  }

  /// Obtener un post por ID
  Future<Post> getPostById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/posts/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Post no encontrado');
    }
    throw Exception('Error: ${response.statusCode}');
  }

  // ==================== CREATE ====================

  /**
   * createPost - Crear un nuevo post
   *
   * ¿Qué hace?
   * Envía los datos del post al servidor mediante POST
   *
   * ¿Cómo funciona?
   * 1. Serializa el objeto a JSON
   * 2. Envía petición POST con el body
   * 3. Recibe el objeto creado con su nuevo ID
   *
   * @param title - Título del post
   * @param body - Contenido del post
   * @param userId - ID del usuario autor
   * @returns Post creado con ID asignado
   */
  Future<Post> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/posts'),
      headers: _headers,
      body: jsonEncode({
        'title': title,
        'body': body,
        'userId': userId,
      }),
    );

    // 201 = Created (recurso creado exitosamente)
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Error al crear post: ${response.statusCode}');
  }

  // ==================== UPDATE ====================

  /**
   * updatePost - Actualizar un post existente (PUT)
   *
   * ¿Qué hace?
   * Reemplaza completamente el post con los nuevos datos
   *
   * ¿PUT vs PATCH?
   * - PUT: Reemplaza todo el recurso
   * - PATCH: Actualiza solo campos específicos
   *
   * @param post - Post con todos los datos actualizados
   * @returns Post actualizado
   */
  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/posts/${post.id}'),
      headers: _headers,
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Post no encontrado');
    }
    throw Exception('Error al actualizar: ${response.statusCode}');
  }

  /**
   * patchPost - Actualizar campos específicos (PATCH)
   *
   * ¿Cuándo usar?
   * Cuando solo necesitas cambiar 1 o 2 campos
   *
   * @param id - ID del post
   * @param fields - Map con solo los campos a actualizar
   */
  Future<Post> patchPost(int id, Map<String, dynamic> fields) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: _headers,
      body: jsonEncode(fields),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Error al actualizar: ${response.statusCode}');
  }

  // ==================== DELETE ====================

  /**
   * deletePost - Eliminar un post
   *
   * ¿Qué hace?
   * Elimina el post del servidor
   *
   * ¿Qué retorna?
   * - 200 o 204 indican éxito
   * - No retorna datos (el recurso ya no existe)
   *
   * @param id - ID del post a eliminar
   */
  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/posts/$id'),
    );

    // 200 OK o 204 No Content = Éxito
    if (response.statusCode == 200 || response.statusCode == 204) {
      return; // Éxito
    } else if (response.statusCode == 404) {
      throw Exception('Post no encontrado');
    }
    throw Exception('Error al eliminar: ${response.statusCode}');
  }
}
```

### Paso 2: Actualizar el modelo Post

```dart
/**
 * lib/models/post.dart (actualizado)
 *
 * Agregamos copyWith para facilitar actualizaciones
 */
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// Crear copia con algunos campos modificados
  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
```

### Paso 3: Crear formulario de Post

```dart
/**
 * lib/screens/post_form_screen.dart
 *
 * PostFormScreen - Formulario para crear/editar posts
 *
 * ¿Qué hace?
 * - Modo crear: Formulario vacío para nuevo post
 * - Modo editar: Formulario con datos del post existente
 *
 * ¿Cómo distinguir modos?
 * Si recibe un post, es edición; si no, es creación
 */
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostFormScreen extends StatefulWidget {
  final Post? post; // null = crear, con valor = editar

  const PostFormScreen({super.key, this.post});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _postService = PostService();

  // Controladores de los campos
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late TextEditingController _userIdController;

  bool _isLoading = false;

  // ¿Es modo edición?
  bool get _isEditing => widget.post != null;

  @override
  void initState() {
    super.initState();
    // Inicializar con datos existentes o vacíos
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
    _userIdController = TextEditingController(
      text: widget.post?.userId.toString() ?? '1',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  /**
   * _submitForm - Enviar formulario
   *
   * ¿Cómo funciona?
   * 1. Valida el formulario
   * 2. Si es edición: PUT
   * 3. Si es creación: POST
   * 4. Retorna el post guardado
   */
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      Post savedPost;

      if (_isEditing) {
        // Actualizar post existente
        savedPost = await _postService.updatePost(
          widget.post!.copyWith(
            title: _titleController.text.trim(),
            body: _bodyController.text.trim(),
            userId: int.parse(_userIdController.text),
          ),
        );
        _showSnackBar('Post actualizado correctamente');
      } else {
        // Crear nuevo post
        savedPost = await _postService.createPost(
          title: _titleController.text.trim(),
          body: _bodyController.text.trim(),
          userId: int.parse(_userIdController.text),
        );
        _showSnackBar('Post creado con ID: ${savedPost.id}');
      }

      // Retornar el post guardado
      if (mounted) {
        Navigator.pop(context, savedPost);
      }
    } catch (e) {
      _showSnackBar('Error: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Post' : 'Nuevo Post'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo: User ID
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                  hintText: 'ID del usuario autor',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El User ID es requerido';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Debe ser un número';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Título
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Escribe el título del post',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                maxLength: 100,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es requerido';
                  }
                  if (value.trim().length < 5) {
                    return 'Mínimo 5 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Contenido
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  hintText: 'Escribe el contenido del post',
                  prefixIcon: Icon(Icons.article),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                maxLength: 500,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El contenido es requerido';
                  }
                  if (value.trim().length < 10) {
                    return 'Mínimo 10 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botón Guardar
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _submitForm,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(_isEditing ? Icons.save : Icons.add),
                  label: Text(
                    _isLoading
                        ? 'Guardando...'
                        : _isEditing
                            ? 'Actualizar Post'
                            : 'Crear Post',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Paso 4: Actualizar la pantalla de posts con CRUD

```dart
/**
 * lib/screens/posts_screen.dart (actualizado)
 *
 * Agregamos:
 * - FAB para crear post
 * - Menú en cada card para editar/eliminar
 * - Confirmación antes de eliminar
 */
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import 'post_form_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostService _postService = PostService();

  List<Post> _posts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

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

  /**
   * _createPost - Navegar a crear post
   */
  Future<void> _createPost() async {
    final result = await Navigator.push<Post>(
      context,
      MaterialPageRoute(
        builder: (context) => const PostFormScreen(),
      ),
    );

    if (result != null) {
      // Agregar al inicio de la lista (simulado)
      setState(() {
        _posts = [result, ..._posts];
      });
    }
  }

  /**
   * _editPost - Navegar a editar post
   */
  Future<void> _editPost(Post post) async {
    final result = await Navigator.push<Post>(
      context,
      MaterialPageRoute(
        builder: (context) => PostFormScreen(post: post),
      ),
    );

    if (result != null) {
      // Actualizar en la lista
      setState(() {
        final index = _posts.indexWhere((p) => p.id == result.id);
        if (index != -1) {
          _posts[index] = result;
        }
      });
    }
  }

  /**
   * _deletePost - Eliminar con confirmación
   */
  Future<void> _deletePost(Post post) async {
    // Mostrar diálogo de confirmación
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Post'),
        content: Text('¿Estás seguro de eliminar "${post.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // Eliminar
    try {
      await _postService.deletePost(post.id);

      // Remover de la lista
      setState(() {
        _posts.removeWhere((p) => p.id == post.id);
      });

      _showSnackBar('Post eliminado');
    } catch (e) {
      _showSnackBar('Error: $e', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts (${_posts.length})'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPosts,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createPost,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Post'),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPosts,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

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

  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text('${post.id}', style: const TextStyle(color: Colors.white)),
        ),
        title: Text(
          post.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          post.body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _editPost(post);
                break;
              case 'delete':
                _deletePost(post);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Eliminar'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## ✅ Puntos de Verificación

- [ ] El FAB "Nuevo Post" funciona
- [ ] El formulario valida campos vacíos
- [ ] Crear post retorna ID 101 (simulado)
- [ ] El menú de 3 puntos aparece en cada card
- [ ] Editar abre el formulario con datos
- [ ] Eliminar muestra diálogo de confirmación
- [ ] Los cambios se reflejan en la lista

---

## 🎯 Retos Adicionales

### Reto 1: Deshacer eliminación

Implementa un SnackBar con opción "Deshacer" después de eliminar.

### Reto 2: PATCH

Añade un botón para actualizar solo el título usando PATCH.

### Reto 3: Optimistic Updates

Actualiza la UI inmediatamente antes de la respuesta del servidor.

---

📅 **Anterior:** [← Práctica 01](./practica-01-jsonplaceholder-api.md) | **Siguiente:** [Práctica 03 →](./practica-03-futurebuilder-lista.md)
