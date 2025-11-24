# Semana 6: Consumo de APIs y HTTP

## 🎯 Objetivos de Aprendizaje

- Realizar peticiones HTTP en Flutter
- Consumir APIs REST
- Parsear y serializar JSON
- Manejar respuestas asíncronas
- Gestionar errores de red
- Implementar caché y optimizaciones

## 📚 Contenido Teórico

### 1. Fundamentos de HTTP (1.5 horas)

#### Protocolo HTTP

- Métodos: GET, POST, PUT, DELETE, PATCH
- Headers y Body
- Status codes (200, 404, 500, etc.)
- REST API concepts

#### Asincronía en Dart

```dart
// Future
Future<String> obtenerDatos() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Datos';
}

// async/await
void cargarDatos() async {
  final datos = await obtenerDatos();
  print(datos);
}

// then/catchError
obtenerDatos()
  .then((datos) => print(datos))
  .catchError((error) => print(error));
```

### 2. HTTP Package (2 horas)

#### Instalación

```yaml
dependencies:
  http: ^1.1.0
```

#### GET Request

```dart
import 'package:http/http.dart' as http;

Future<void> obtenerUsuarios() async {
  final url = Uri.parse('https://api.example.com/users');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Error al cargar datos');
  }
}
```

#### POST Request

```dart
Future<void> crearUsuario(Map<String, dynamic> usuario) async {
  final url = Uri.parse('https://api.example.com/users');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(usuario),
  );

  if (response.statusCode == 201) {
    print('Usuario creado');
  }
}
```

#### PUT y DELETE

```dart
// PUT
Future<void> actualizarUsuario(String id, Map data) async {
  final url = Uri.parse('https://api.example.com/users/$id');
  await http.put(url, body: jsonEncode(data));
}

// DELETE
Future<void> eliminarUsuario(String id) async {
  final url = Uri.parse('https://api.example.com/users/$id');
  await http.delete(url);
}
```

### 3. Modelos y Serialización JSON (2.5 horas)

#### Parsear JSON Manual

```dart
import 'dart:convert';

class Usuario {
  final int id;
  final String nombre;
  final String email;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
  });

  // From JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
    };
  }
}

// Uso
final jsonString = '{"id": 1, "nombre": "Juan", "email": "juan@example.com"}';
final jsonData = jsonDecode(jsonString);
final usuario = Usuario.fromJson(jsonData);

// Lista de objetos
final jsonList = jsonDecode('[{"id": 1, "nombre": "Juan"}, ...]');
final usuarios = (jsonList as List)
    .map((json) => Usuario.fromJson(json))
    .toList();
```

#### json_serializable

```yaml
dependencies:
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.6
  json_serializable: ^6.7.1
```

```dart
import 'package:json_annotation/json_annotation.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  final int id;
  final String nombre;
  final String email;

  Usuario({required this.id, required this.nombre, required this.email});

  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}

// Generar código
// flutter pub run build_runner build
```

### 4. Manejo de Errores y Estados (2 horas)

#### Try-Catch

```dart
Future<List<Usuario>> obtenerUsuarios() async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw HttpException('Error ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('Sin conexión a internet');
  } on HttpException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception('Error desconocido: $e');
  }
}
```

#### Estados de Carga

```dart
enum EstadoCarga { inicial, cargando, exito, error }

class UsuariosProvider extends ChangeNotifier {
  List<Usuario> _usuarios = [];
  EstadoCarga _estado = EstadoCarga.inicial;
  String _mensajeError = '';

  List<Usuario> get usuarios => _usuarios;
  EstadoCarga get estado => _estado;
  String get mensajeError => _mensajeError;

  Future<void> cargarUsuarios() async {
    _estado = EstadoCarga.cargando;
    notifyListeners();

    try {
      _usuarios = await obtenerUsuarios();
      _estado = EstadoCarga.exito;
    } catch (e) {
      _estado = EstadoCarga.error;
      _mensajeError = e.toString();
    }

    notifyListeners();
  }
}
```

#### FutureBuilder

```dart
FutureBuilder<List<Usuario>>(
  future: obtenerUsuarios(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Text('No hay datos');
    }

    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final usuario = snapshot.data![index];
        return ListTile(title: Text(usuario.nombre));
      },
    );
  },
)
```

## 💻 Ejercicios Prácticos

### Ejercicio 1: JSONPlaceholder API

Consume la API https://jsonplaceholder.typicode.com:

- GET todos los posts
- GET un post específico
- POST crear nuevo post
- Mostrar en ListView

### Ejercicio 2: Modelos de Datos

Crea modelos para:

- Post (userId, id, title, body)
- Comentario (postId, id, name, email, body)
- Usuario (id, name, username, email, address)
- Implementa fromJson y toJson

### Ejercicio 3: Lista con FutureBuilder

Desarrolla una pantalla que:

- Cargue posts de la API
- Muestre loading spinner
- Maneje errores con mensajes
- Implemente pull-to-refresh

### Ejercicio 4: CRUD Completo

Implementa todas las operaciones:

- Create: Crear nuevo recurso
- Read: Listar y ver detalle
- Update: Editar recurso existente
- Delete: Eliminar con confirmación

### Ejercicio 5: Búsqueda en Tiempo Real

Crea un buscador que:

- Busque mientras el usuario escribe
- Debounce para evitar muchas peticiones
- Muestre resultados en tiempo real
- Maneje estados de carga

## 🔨 Proyecto de la Semana

**App de Noticias (News Reader)**

Desarrolla una aplicación de noticias consumiendo la API de NewsAPI o similar:

**API Sugerida:** https://newsapi.org/

**Características:**

1. **Pantalla Principal**

   - Top headlines por país
   - Pull to refresh
   - Indicador de carga
   - Lista de noticias con imagen

2. **Categorías**

   - Business, Entertainment, Health, Science, Sports, Technology
   - Tab bar o chips para filtrar
   - Cargar noticias por categoría

3. **Búsqueda**

   - Campo de búsqueda
   - Búsqueda por keyword
   - Historial de búsquedas
   - Debounce de 500ms

4. **Detalle de Noticia**

   - Imagen completa
   - Título y descripción
   - Fuente y autor
   - Fecha de publicación
   - Botón para abrir en navegador
   - Compartir noticia

5. **Favoritos**
   - Guardar noticias favoritas localmente
   - Lista de favoritos
   - Eliminar de favoritos

**Requisitos técnicos:**

```dart
// Modelos
class Noticia {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
  final Source source;

  factory Noticia.fromJson(Map<String, dynamic> json) { }
  Map<String, dynamic> toJson() { }
}

class Source {
  final String? id;
  final String name;
}

// Servicio API
class NoticiasService {
  static const String _apiKey = 'TU_API_KEY';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<Noticia>> obtenerTopHeadlines({
    String country = 'us',
    String? category,
  }) async { }

  Future<List<Noticia>> buscarNoticias(String query) async { }
}

// Provider
class NoticiasProvider extends ChangeNotifier {
  final NoticiasService _service = NoticiasService();

  List<Noticia> _noticias = [];
  EstadoCarga _estado = EstadoCarga.inicial;
  String? _error;

  Future<void> cargarNoticias() async { }
  Future<void> buscar(String query) async { }
}
```

**Pantallas:**

1. Home (top headlines)
2. Categorías
3. Búsqueda
4. Detalle
5. Favoritos

**Funcionalidades adicionales:**

- Caché de imágenes
- Manejo offline (mostrar favoritos)
- Loading skeletons
- Error retry
- Paginación infinita (load more)

## 📖 Recursos

### Documentación

- [HTTP Package](https://pub.dev/packages/http)
- [JSON and Serialization](https://flutter.dev/docs/development/data-and-backend/json)
- [Dio Package](https://pub.dev/packages/dio)

### APIs Gratuitas para Practicar

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/)
- [NewsAPI](https://newsapi.org/)
- [OpenWeather](https://openweathermap.org/api)
- [The Movie DB](https://www.themoviedb.org/documentation/api)
- [REST Countries](https://restcountries.com/)

### Paquetes Útiles

- [http](https://pub.dev/packages/http)
- [dio](https://pub.dev/packages/dio)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [retrofit](https://pub.dev/packages/retrofit)
- [cached_network_image](https://pub.dev/packages/cached_network_image)

## ✅ Checklist de Completitud

- [ ] Ejercicio 1: JSONPlaceholder completado
- [ ] Ejercicio 2: Modelos completados
- [ ] Ejercicio 3: FutureBuilder completado
- [ ] Ejercicio 4: CRUD completado
- [ ] Ejercicio 5: Búsqueda completada
- [ ] Proyecto: App de noticias completado
- [ ] API key configurada
- [ ] Modelos correctamente parseados
- [ ] Manejo de errores implementado
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios prácticos (1-5):** 30%
- **Proyecto de la semana:** 60%
- **Manejo de errores y UX:** 10%

## 📝 Notas Importantes

- Nunca subir API keys al repositorio (usar .env)
- Siempre manejar errores de red
- Implementar timeouts en requests
- Considerar límites de rate en APIs
- Validar respuestas antes de parsear

## 🔧 Tips y Trucos

```dart
// Timeout
final response = await http.get(url).timeout(
  Duration(seconds: 10),
  onTimeout: () => throw TimeoutException('Request timeout'),
);

// Headers personalizados
final headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $token',
};

// Interceptors con Dio
final dio = Dio();
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    print('Request: ${options.path}');
    return handler.next(options);
  },
  onError: (error, handler) {
    print('Error: ${error.message}');
    return handler.next(error);
  },
));

// Debounce para búsqueda
Timer? _debounce;

void onSearchChanged(String query) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  _debounce = Timer(Duration(milliseconds: 500), () {
    // Realizar búsqueda
  });
}
```

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 5](../semana-05/README.md) | **Siguiente:** [Semana 7 →](../semana-07/README.md)
