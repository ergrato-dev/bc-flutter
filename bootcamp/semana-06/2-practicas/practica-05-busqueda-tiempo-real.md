# 💻 Práctica 05: Búsqueda en Tiempo Real

## 🎯 Objetivos

- ✅ Implementar búsqueda mientras el usuario escribe
- ✅ Usar debounce para optimizar peticiones
- ✅ Cancelar peticiones anteriores
- ✅ Manejar estados de búsqueda
- ✅ Mostrar historial de búsquedas

---

## 📋 Descripción

Crearás una funcionalidad de búsqueda en tiempo real que busca mientras el usuario escribe, optimizando las peticiones con debounce y cancelación de requests anteriores.

**Tiempo estimado:** 55 minutos

---

## 📖 Conceptos Clave

### ¿Qué es Debounce?

**Debounce** es una técnica que retrasa la ejecución de una función hasta que haya pasado un tiempo sin nuevas llamadas.

```
Sin debounce (cada letra = petición):
H → buscar("H")
He → buscar("He")
Hel → buscar("Hel")
Hell → buscar("Hell")
Hello → buscar("Hello")
= 5 peticiones

Con debounce (500ms):
H-e-l-l-o → [espera 500ms] → buscar("Hello")
= 1 petición
```

### ¿Por qué Cancelar Peticiones?

Si el usuario cambia el query antes de recibir respuesta, la respuesta anterior ya no es relevante y debe descartarse.

---

## 📝 Implementación

### Paso 1: Crear el servicio de búsqueda

```dart
/**
 * lib/services/search_service.dart
 * 
 * SearchService - Servicio de búsqueda con cancelación
 * 
 * ¿Qué hace?
 * - Busca posts por título
 * - Soporta cancelación de peticiones
 * - Guarda historial de búsquedas
 */
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';

class SearchService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  
  // Token de cancelación actual
  CancelToken? _cancelToken;
  
  // Key para historial en SharedPreferences
  static const String _historyKey = 'search_history';
  static const int _maxHistoryItems = 10;

  /**
   * searchPosts - Buscar posts por query
   * 
   * ¿Cómo funciona?
   * 1. Cancela petición anterior si existe
   * 2. Crea nuevo token de cancelación
   * 3. Realiza la búsqueda
   * 4. Filtra resultados localmente (la API no tiene búsqueda real)
   * 
   * @param query - Término de búsqueda
   * @returns Lista de posts que coinciden
   */
  Future<List<Post>> searchPosts(String query) async {
    // Cancelar petición anterior
    _cancelToken?.cancel('Nueva búsqueda iniciada');
    
    // Crear nuevo token
    _cancelToken = CancelToken();
    
    try {
      // Obtener todos los posts
      final response = await _dio.get(
        '/posts',
        cancelToken: _cancelToken,
      );
      
      // Parsear respuesta
      final List<Post> allPosts = (response.data as List)
          .map((json) => Post.fromJson(json))
          .toList();
      
      // Filtrar por query (simulando búsqueda del servidor)
      final queryLower = query.toLowerCase();
      return allPosts.where((post) {
        return post.title.toLowerCase().contains(queryLower) ||
               post.body.toLowerCase().contains(queryLower);
      }).toList();
      
    } on DioException catch (e) {
      // Si fue cancelada, no es un error real
      if (CancelToken.isCancel(e)) {
        return []; // Retornar lista vacía
      }
      rethrow;
    }
  }
  
  /// Cancelar búsqueda en progreso
  void cancelSearch() {
    _cancelToken?.cancel('Búsqueda cancelada por el usuario');
    _cancelToken = null;
  }
  
  // ==================== Historial ====================
  
  /// Guardar término en historial
  Future<void> addToHistory(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();
    
    // Remover si ya existe (para moverlo al inicio)
    history.remove(query);
    
    // Agregar al inicio
    history.insert(0, query);
    
    // Limitar tamaño
    if (history.length > _maxHistoryItems) {
      history.removeLast();
    }
    
    await prefs.setStringList(_historyKey, history);
  }
  
  /// Obtener historial de búsquedas
  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historyKey) ?? [];
  }
  
  /// Eliminar término del historial
  Future<void> removeFromHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();
    history.remove(query);
    await prefs.setStringList(_historyKey, history);
  }
  
  /// Limpiar historial
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
```

### Paso 2: Crear el Debouncer

```dart
/**
 * lib/utils/debouncer.dart
 * 
 * Debouncer - Utilidad para debounce
 * 
 * ¿Qué hace?
 * Retrasa la ejecución de una función hasta que
 * haya pasado un tiempo sin nuevas llamadas
 */
import 'dart:async';

class Debouncer {
  final Duration duration;
  Timer? _timer;
  
  Debouncer({this.duration = const Duration(milliseconds: 500)});
  
  /**
   * run - Ejecutar función con debounce
   * 
   * ¿Cómo funciona?
   * 1. Cancela el timer anterior si existe
   * 2. Crea nuevo timer
   * 3. Cuando el timer termina, ejecuta la acción
   */
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
  
  /// Cancelar timer pendiente
  void cancel() {
    _timer?.cancel();
  }
  
  /// Ejecutar inmediatamente (sin esperar)
  void runImmediately(VoidCallback action) {
    _timer?.cancel();
    action();
  }
  
  /// Liberar recursos
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
```

### Paso 3: Crear la pantalla de búsqueda

```dart
/**
 * lib/screens/search_screen.dart
 * 
 * SearchScreen - Pantalla de búsqueda en tiempo real
 * 
 * ¿Qué hace?
 * - Campo de búsqueda con debounce
 * - Muestra resultados mientras escribe
 * - Historial de búsquedas recientes
 * - Cancela peticiones anteriores
 */
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/search_service.dart';
import '../utils/debouncer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchService _searchService = SearchService();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  // Debouncer para la búsqueda
  final Debouncer _debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );
  
  // Estados
  List<Post> _results = [];
  List<String> _history = [];
  bool _isSearching = false;
  String? _error;
  String _currentQuery = '';
  bool _showHistory = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    
    // Listener para cambios en el campo de búsqueda
    _searchController.addListener(_onSearchChanged);
    
    // Listener para el focus
    _focusNode.addListener(() {
      setState(() {
        _showHistory = _focusNode.hasFocus && _currentQuery.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    _debouncer.dispose();
    _searchService.cancelSearch();
    super.dispose();
  }

  /// Cargar historial al iniciar
  Future<void> _loadHistory() async {
    final history = await _searchService.getSearchHistory();
    setState(() {
      _history = history;
    });
  }

  /**
   * _onSearchChanged - Se ejecuta cuando cambia el texto
   * 
   * ¿Cómo funciona?
   * 1. Actualiza el query actual
   * 2. Si está vacío, muestra historial
   * 3. Si tiene texto, aplica debounce y busca
   */
  void _onSearchChanged() {
    final query = _searchController.text.trim();
    
    setState(() {
      _currentQuery = query;
      _showHistory = query.isEmpty && _focusNode.hasFocus;
    });
    
    if (query.isEmpty) {
      _debouncer.cancel();
      _searchService.cancelSearch();
      setState(() {
        _results = [];
        _isSearching = false;
        _error = null;
      });
      return;
    }
    
    // Aplicar debounce
    _debouncer.run(() => _performSearch(query));
  }

  /**
   * _performSearch - Realizar la búsqueda
   */
  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;
    
    setState(() {
      _isSearching = true;
      _error = null;
    });
    
    try {
      final results = await _searchService.searchPosts(query);
      
      // Verificar que el query sigue siendo el mismo
      if (_currentQuery == query) {
        setState(() {
          _results = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (_currentQuery == query) {
        setState(() {
          _error = e.toString();
          _isSearching = false;
        });
      }
    }
  }

  /**
   * _submitSearch - Se ejecuta al presionar Enter o buscar
   */
  Future<void> _submitSearch(String query) async {
    if (query.trim().isEmpty) return;
    
    // Guardar en historial
    await _searchService.addToHistory(query);
    await _loadHistory();
    
    // Buscar inmediatamente
    _debouncer.runImmediately(() => _performSearch(query));
    
    // Quitar focus del teclado
    _focusNode.unfocus();
  }

  /**
   * _selectFromHistory - Buscar desde historial
   */
  void _selectFromHistory(String query) {
    _searchController.text = query;
    _submitSearch(query);
  }

  /// Limpiar búsqueda
  void _clearSearch() {
    _searchController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Posts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Campo de búsqueda
          _buildSearchField(),
          
          // Contenido
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Buscar posts...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _currentQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: _submitSearch,
      ),
    );
  }

  Widget _buildContent() {
    // Mostrar historial
    if (_showHistory && _history.isNotEmpty) {
      return _buildHistory();
    }
    
    // Mostrar loading
    if (_isSearching) {
      return _buildLoading();
    }
    
    // Mostrar error
    if (_error != null) {
      return _buildError();
    }
    
    // Mostrar resultados vacíos
    if (_currentQuery.isNotEmpty && _results.isEmpty) {
      return _buildNoResults();
    }
    
    // Mostrar resultados
    if (_results.isNotEmpty) {
      return _buildResults();
    }
    
    // Estado inicial
    return _buildInitialState();
  }

  Widget _buildHistory() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Búsquedas recientes',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              TextButton(
                onPressed: () async {
                  await _searchService.clearHistory();
                  await _loadHistory();
                },
                child: const Text('Limpiar'),
              ),
            ],
          ),
        ),
        ..._history.map((query) => ListTile(
          leading: const Icon(Icons.history, color: Colors.grey),
          title: Text(query),
          trailing: IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () async {
              await _searchService.removeFromHistory(query);
              await _loadHistory();
            },
          ),
          onTap: () => _selectFromHistory(query),
        )),
      ],
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Buscando "$_currentQuery"...',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            const Text('Error en la búsqueda'),
            const SizedBox(height: 8),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _performSearch(_currentQuery),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No se encontraron resultados para',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            '"$_currentQuery"',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '${_results.length} resultado${_results.length != 1 ? 's' : ''} para "$_currentQuery"',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: _results.length,
            itemBuilder: (context, index) {
              final post = _results[index];
              return _buildPostCard(post);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            '${post.id}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        title: Text(
          _highlightQuery(post.title),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          post.body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          // Navegar al detalle del post
        },
      ),
    );
  }

  /// Resaltar el query en el texto (simplificado)
  String _highlightQuery(String text) {
    // En una implementación real, usarías RichText para resaltar
    return text;
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Busca posts por título o contenido',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
```

---

## ✅ Puntos de Verificación

- [ ] La búsqueda se activa después de 500ms sin escribir
- [ ] Se muestra loading mientras busca
- [ ] No se hacen peticiones innecesarias
- [ ] El historial se guarda correctamente
- [ ] Se pueden eliminar items del historial
- [ ] Limpiar el campo cancela la búsqueda

---

## 🎯 Retos Adicionales

### Reto 1: Resaltar coincidencias
Usa `RichText` para resaltar el texto que coincide con el query.

### Reto 2: Sugerencias
Muestra sugerencias basadas en el historial mientras escribe.

### Reto 3: Filtros
Agrega filtros para buscar solo por título o solo por contenido.

---

📅 **Anterior:** [← Práctica 04](./practica-04-dio-interceptores.md)
