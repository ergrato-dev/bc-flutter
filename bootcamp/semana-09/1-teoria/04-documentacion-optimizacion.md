# 📖 Módulo 4: Documentación y Optimización

## 📋 Contenido

1. [Documentación de Código](#-documentación-de-código)
2. [Dartdoc](#-dartdoc)
3. [README y Guías](#-readme-y-guías)
4. [Optimización de Rendimiento](#-optimización-de-rendimiento)
5. [DevTools y Profiling](#-devtools-y-profiling)
6. [Buenas Prácticas](#-buenas-prácticas)

---

## 🎯 Objetivos

- Escribir documentación efectiva con Dartdoc
- Crear READMEs profesionales
- Identificar y resolver problemas de rendimiento
- Usar Flutter DevTools para profiling
- Aplicar técnicas de optimización

---

## 📝 Documentación de Código

### ¿Por qué documentar?

La documentación es esencial para:
- **Mantenibilidad**: Facilitar el trabajo futuro
- **Colaboración**: Permitir que otros entiendan el código
- **Onboarding**: Reducir tiempo de aprendizaje
- **Debugging**: Entender la intención original

### Tipos de Documentación

```dart
// ═══════════════════════════════════════════════════════════════
// 1. COMENTARIOS DE LÍNEA
// ═══════════════════════════════════════════════════════════════

// Explicación breve de una línea
final userId = _extractUserId(token); // Obtiene el ID del JWT

// ═══════════════════════════════════════════════════════════════
// 2. COMENTARIOS DE DOCUMENTACIÓN (///)
// ═══════════════════════════════════════════════════════════════

/// Representa un usuario en el sistema.
/// 
/// El [User] contiene información básica del perfil
/// y credenciales de autenticación.
class User {
  /// Identificador único del usuario.
  final String id;
  
  /// Nombre completo del usuario.
  final String name;
  
  /// Correo electrónico (usado para login).
  final String email;
  
  /// Crea un nuevo usuario con los datos proporcionados.
  /// 
  /// El [id] debe ser un UUID válido.
  /// El [email] será validado automáticamente.
  User({
    required this.id,
    required this.name,
    required this.email,
  });
}

// ═══════════════════════════════════════════════════════════════
// 3. COMENTARIOS DE BLOQUE (/* */)
// ═══════════════════════════════════════════════════════════════

/*
 * Este bloque de código implementa el algoritmo de
 * sincronización offline. El proceso es:
 * 1. Cargar datos locales
 * 2. Comparar con servidor
 * 3. Resolver conflictos
 * 4. Actualizar ambos lados
 */
```

### QUÉ, PARA QUÉ, CÓMO

```dart
/// **QUÉ**: Servicio de autenticación
/// 
/// Maneja todas las operaciones relacionadas con la autenticación
/// de usuarios: login, logout, registro y refresh de tokens.
/// 
/// **PARA QUÉ**: Centralizar la lógica de auth
/// 
/// Proporciona una interfaz única para toda la aplicación,
/// facilitando el mantenimiento y testing.
/// 
/// **CÓMO**: JWT + Secure Storage
/// 
/// 1. El usuario envía credenciales
/// 2. El servidor retorna access + refresh token
/// 3. Los tokens se almacenan en secure storage
/// 4. El access token se incluye en cada request
/// 5. Al expirar, se usa refresh token para renovar
/// 
/// Ejemplo de uso:
/// ```dart
/// final authService = AuthService();
/// 
/// // Login
/// final result = await authService.login(
///   email: 'user@example.com',
///   password: 'secure123',
/// );
/// 
/// // Verificar estado
/// if (authService.isAuthenticated) {
///   print('Usuario autenticado');
/// }
/// 
/// // Logout
/// await authService.logout();
/// ```
class AuthService {
  // ...
}
```

---

## 📚 Dartdoc

### Sintaxis Dartdoc

```dart
/// Calcula el precio total con impuestos y descuentos.
/// 
/// Este método aplica la siguiente fórmula:
/// ```
/// total = (subtotal - discount) * (1 + taxRate)
/// ```
/// 
/// ## Parámetros
/// 
/// * [subtotal] - Suma de precios de los productos
/// * [taxRate] - Tasa de impuesto (0.0 a 1.0)
/// * [discount] - Descuento a aplicar (opcional)
/// 
/// ## Retorna
/// 
/// El precio total calculado como [double].
/// 
/// ## Excepciones
/// 
/// Lanza [ArgumentError] si:
/// * [subtotal] es negativo
/// * [taxRate] está fuera del rango válido
/// 
/// ## Ejemplo
/// 
/// ```dart
/// final total = calculateTotal(
///   subtotal: 100.0,
///   taxRate: 0.21,
///   discount: 10.0,
/// );
/// print(total); // 108.9
/// ```
/// 
/// ## Ver también
/// 
/// * [applyDiscount] para descuentos personalizados
/// * [getTaxRate] para obtener la tasa según región
double calculateTotal({
  required double subtotal,
  required double taxRate,
  double discount = 0,
}) {
  if (subtotal < 0) {
    throw ArgumentError('subtotal no puede ser negativo');
  }
  if (taxRate < 0 || taxRate > 1) {
    throw ArgumentError('taxRate debe estar entre 0 y 1');
  }
  
  return (subtotal - discount) * (1 + taxRate);
}
```

### Referencias en Dartdoc

```dart
/// Usa [User] para representar usuarios autenticados.
/// 
/// Ver también:
/// * [AuthService] - Servicio de autenticación
/// * [UserRepository.getById] - Obtener usuario por ID
/// * <https://api.example.com/docs> - API Documentation
/// 
/// Para más información sobre el modelo de datos,
/// consulta el [README](../README.md).
class UserProfile {
  /// El [User] asociado a este perfil.
  final User user;
  
  /// Construye un [UserProfile] a partir de un [User].
  UserProfile(this.user);
}
```

### Generar Documentación

```bash
# Generar documentación HTML
dart doc .

# Ver documentación generada
open doc/api/index.html

# En proyecto Flutter
flutter pub run dartdoc
```

### Configuración dartdoc_options.yaml

```yaml
# dartdoc_options.yaml
dartdoc:
  name: 'Mi App'
  description: 'Documentación de la aplicación'
  categories:
    "Core":
      markdown: doc/categories/core.md
    "Features":
      markdown: doc/categories/features.md
  categoryOrder: ["Core", "Features"]
  exclude:
    - "generated/**"
  include:
    - "lib/**"
  showUndocumentedCategories: true
  linkToSource:
    root: '.'
    uriTemplate: 'https://github.com/user/repo/blob/main/%f%#L%l%'
```

---

## 📄 README y Guías

### Estructura de README

```markdown
# 📱 Nombre del Proyecto

> Breve descripción del proyecto en una línea.

![Flutter Version](https://img.shields.io/badge/flutter-%3E%3D3.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Tests](https://github.com/user/repo/workflows/tests/badge.svg)

## 📋 Índice

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Uso](#-uso)
- [Arquitectura](#-arquitectura)
- [Tests](#-tests)
- [Contribuir](#-contribuir)
- [Licencia](#-licencia)

## ✨ Características

- ✅ Feature 1
- ✅ Feature 2
- ✅ Feature 3
- 🚧 Feature en desarrollo

## 📦 Requisitos

- Flutter >= 3.0.0
- Dart >= 3.0.0
- Android SDK >= 21
- iOS >= 12.0

## 🚀 Instalación

### Clonar repositorio

```bash
git clone https://github.com/user/repo.git
cd repo
```

### Instalar dependencias

```bash
flutter pub get
```

### Configurar variables de entorno

```bash
cp .env.example .env
# Editar .env con tus valores
```

### Ejecutar la aplicación

```bash
# Desarrollo
flutter run

# Release
flutter run --release
```

## 📖 Uso

### Ejemplo básico

```dart
import 'package:mi_app/mi_app.dart';

void main() {
  final service = MyService();
  final result = service.doSomething();
}
```

## 🏗️ Arquitectura

```
lib/
├── core/           # Utilidades y configuración
├── data/           # Capa de datos
├── domain/         # Lógica de negocio
└── presentation/   # UI y estado
```

Ver [ARCHITECTURE.md](docs/ARCHITECTURE.md) para más detalles.

## 🧪 Tests

```bash
# Ejecutar todos los tests
flutter test

# Con cobertura
flutter test --coverage

# Tests específicos
flutter test test/unit/
```

## 🤝 Contribuir

1. Fork el proyecto
2. Crear branch (`git checkout -b feature/nueva-feature`)
3. Commit cambios (`git commit -m 'Add nueva feature'`)
4. Push al branch (`git push origin feature/nueva-feature`)
5. Abrir Pull Request

Ver [CONTRIBUTING.md](CONTRIBUTING.md) para guidelines.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver [LICENSE](LICENSE).

## 👥 Autores

- **Nombre** - *Trabajo inicial* - [@usuario](https://github.com/usuario)

## 🙏 Agradecimientos

- Flutter team
- Comunidad open source
```

### Documentación de API

```markdown
# API Reference

## AuthService

### Métodos

#### `login()`

Autentica un usuario con email y contraseña.

**Firma:**
```dart
Future<Either<Failure, User>> login({
  required String email,
  required String password,
});
```

**Parámetros:**
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| email | String | Email del usuario |
| password | String | Contraseña |

**Retorna:**
- `Right(User)` - Usuario autenticado
- `Left(Failure)` - Error de autenticación

**Ejemplo:**
```dart
final result = await authService.login(
  email: 'user@example.com',
  password: 'password123',
);

result.fold(
  (failure) => print('Error: ${failure.message}'),
  (user) => print('Bienvenido ${user.name}'),
);
```
```

---

## ⚡ Optimización de Rendimiento

### Problemas Comunes

```dart
// ═══════════════════════════════════════════════════════════════
// ❌ ANTI-PATRÓN: Rebuilds innecesarios
// ═══════════════════════════════════════════════════════════════

class BadExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        // ❌ Crea nuevo TextStyle en cada build
        return Text(
          'Item $index',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ✅ CORRECTO: Constantes y cache
// ═══════════════════════════════════════════════════════════════

class GoodExample extends StatelessWidget {
  // ✅ TextStyle constante
  static const _itemStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        return Text(
          'Item $index',
          style: _itemStyle, // ✅ Reutiliza
        );
      },
    );
  }
}
```

### const Constructor

```dart
// ═══════════════════════════════════════════════════════════════
// ❌ Sin const - se reconstruye en cada build
// ═══════════════════════════════════════════════════════════════

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $counter'),
        // ❌ Se reconstruye aunque no cambie
        ExpensiveWidget(),
        ElevatedButton(
          onPressed: () => setState(() => counter++),
          child: Text('Increment'),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ✅ Con const - Flutter reutiliza la instancia
// ═══════════════════════════════════════════════════════════════

class ParentWidgetOptimized extends StatefulWidget {
  @override
  _ParentWidgetOptimizedState createState() => _ParentWidgetOptimizedState();
}

class _ParentWidgetOptimizedState extends State<ParentWidgetOptimized> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $counter'),
        // ✅ Marcado como const - no se reconstruye
        const ExpensiveWidget(),
        ElevatedButton(
          onPressed: () => setState(() => counter++),
          child: const Text('Increment'), // ✅ Texto const
        ),
      ],
    );
  }
}

// Para que funcione, el widget debe soportar const
class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Operación costosa
    return Container(
      // ...
    );
  }
}
```

### ListView Optimization

```dart
// ═══════════════════════════════════════════════════════════════
// ❌ Lista completa en memoria
// ═══════════════════════════════════════════════════════════════

Widget buildBadList() {
  return SingleChildScrollView(
    child: Column(
      children: List.generate(
        10000,
        (index) => ListTile(title: Text('Item $index')),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// ✅ ListView.builder - lazy loading
// ═══════════════════════════════════════════════════════════════

Widget buildGoodList() {
  return ListView.builder(
    itemCount: 10000,
    // ✅ itemExtent fijo mejora rendimiento
    itemExtent: 56.0,
    // ✅ addAutomaticKeepAlives: false para listas muy largas
    addAutomaticKeepAlives: false,
    itemBuilder: (context, index) {
      return ListTile(title: Text('Item $index'));
    },
  );
}

// ═══════════════════════════════════════════════════════════════
// ✅ ListView.separated para dividers
// ═══════════════════════════════════════════════════════════════

Widget buildSeparatedList() {
  return ListView.separated(
    itemCount: 100,
    separatorBuilder: (context, index) => const Divider(),
    itemBuilder: (context, index) {
      return ListTile(title: Text('Item $index'));
    },
  );
}
```

### Image Optimization

```dart
// ═══════════════════════════════════════════════════════════════
// OPTIMIZACIÓN DE IMÁGENES
// ═══════════════════════════════════════════════════════════════

class OptimizedImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ Especificar dimensiones exactas
        Image.network(
          'https://example.com/image.jpg',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          // ✅ Usar cacheWidth/cacheHeight
          cacheWidth: 400, // 2x para retina
          cacheHeight: 400,
        ),

        // ✅ Placeholder mientras carga
        Image.network(
          'https://example.com/large-image.jpg',
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!
                  : null,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),

        // ✅ Usar cached_network_image para cache
        // CachedNetworkImage(
        //   imageUrl: 'https://example.com/image.jpg',
        //   placeholder: (context, url) => CircularProgressIndicator(),
        //   errorWidget: (context, url, error) => Icon(Icons.error),
        // ),
      ],
    );
  }
}
```

### RepaintBoundary

```dart
/// RepaintBoundary aísla partes del árbol de widgets
/// para evitar repintados innecesarios.
class RepaintBoundaryExample extends StatefulWidget {
  @override
  _RepaintBoundaryExampleState createState() => _RepaintBoundaryExampleState();
}

class _RepaintBoundaryExampleState extends State<RepaintBoundaryExample> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Este slider cambia frecuentemente
        Slider(
          value: _sliderValue,
          onChanged: (value) => setState(() => _sliderValue = value),
        ),
        
        // ✅ RepaintBoundary evita que esta sección costosa
        // se repinte cuando cambia el slider
        RepaintBoundary(
          child: ExpensiveAnimatedWidget(),
        ),
        
        // ✅ Otro RepaintBoundary para contenido estático
        RepaintBoundary(
          child: StaticContent(),
        ),
      ],
    );
  }
}
```

### Avoid Expensive Operations in build()

```dart
// ═══════════════════════════════════════════════════════════════
// ❌ Operaciones costosas en build
// ═══════════════════════════════════════════════════════════════

class BadWidget extends StatelessWidget {
  final List<Item> items;
  
  const BadWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    // ❌ Ordenar en cada build
    final sortedItems = List.of(items)
      ..sort((a, b) => a.name.compareTo(b.name));
    
    // ❌ Crear formato en cada build
    final formatter = NumberFormat.currency(locale: 'es_ES');
    
    return ListView.builder(
      itemCount: sortedItems.length,
      itemBuilder: (context, index) {
        final item = sortedItems[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(formatter.format(item.price)),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ✅ Precalcular y cachear
// ═══════════════════════════════════════════════════════════════

class GoodWidget extends StatefulWidget {
  final List<Item> items;
  
  const GoodWidget({required this.items});

  @override
  _GoodWidgetState createState() => _GoodWidgetState();
}

class _GoodWidgetState extends State<GoodWidget> {
  // ✅ Formato creado una vez
  static final _formatter = NumberFormat.currency(locale: 'es_ES');
  
  // ✅ Lista ordenada cacheada
  late List<Item> _sortedItems;

  @override
  void initState() {
    super.initState();
    _sortItems();
  }

  @override
  void didUpdateWidget(GoodWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _sortItems();
    }
  }

  void _sortItems() {
    _sortedItems = List.of(widget.items)
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _sortedItems.length,
      itemBuilder: (context, index) {
        final item = _sortedItems[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(_formatter.format(item.price)),
        );
      },
    );
  }
}
```

---

## 🔧 DevTools y Profiling

### Flutter DevTools

```bash
# Abrir DevTools
flutter pub global activate devtools
flutter pub global run devtools

# O desde VS Code: F5 -> View -> Command Palette -> "Flutter: Open DevTools"
```

### Performance Overlay

```dart
MaterialApp(
  showPerformanceOverlay: true, // Activa overlay de rendimiento
  checkerboardRasterCacheImages: true, // Checker para imágenes cacheadas
  checkerboardOffscreenLayers: true, // Checker para capas offscreen
  home: MyApp(),
);
```

### Timeline View

- **UI Thread**: Construcción de widgets
- **Raster Thread**: Pintura en pantalla
- **Objetivo**: < 16ms por frame (60 fps)

### Widget Inspector

```dart
// Marcar widgets para inspección
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      debugPrint('Constraints: $constraints');
      return Container(
        // Usar debugPaintSizeEnabled para ver límites
        // flutter run --debug --dart-define=flutter.inspector.structuredErrors=true
      );
    },
  );
}
```

### Memory Profiling

```dart
// Detectar memory leaks
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  StreamSubscription? _subscription;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _subscription = myStream.listen((data) {
      // ...
    });
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      // ...
    });
  }

  @override
  void dispose() {
    // ✅ CRÍTICO: Cancelar subscriptions y timers
    _subscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
```

---

## 📋 Buenas Prácticas

### Código Limpio

```dart
// ═══════════════════════════════════════════════════════════════
// PRINCIPIOS DART/FLUTTER
// ═══════════════════════════════════════════════════════════════

// 1. Preferir final para variables que no cambian
final name = 'Juan'; // ✅
var name = 'Juan';   // ❌ Si no va a cambiar

// 2. Usar const donde sea posible
const defaultPadding = EdgeInsets.all(16); // ✅

// 3. Colecciones tipadas
final List<String> names = []; // ✅
final names = <String>[];      // ✅ También válido

// 4. Null safety
String? nullableName;
final displayName = nullableName ?? 'Anonymous'; // ✅
final length = nullableName?.length ?? 0;        // ✅

// 5. Cascade notation
final button = ElevatedButton(onPressed: () {}, child: Text(''))
  ..style = ButtonStyle()
  ..enabled = true;

// 6. Collection if/for
final items = [
  'Always',
  if (showOptional) 'Optional',
  for (var i = 0; i < 3; i++) 'Item $i',
];

// 7. Extension methods para funcionalidad adicional
extension StringX on String {
  String get capitalized => 
    isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}

// 8. Named parameters para claridad
void createUser({
  required String name,
  required String email,
  int? age,
}) {}

// Llamada clara:
createUser(name: 'Juan', email: 'juan@email.com');
```

### Widget Composition

```dart
// ═══════════════════════════════════════════════════════════════
// ❌ Widget monolítico
// ═══════════════════════════════════════════════════════════════

class MonolithicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 200 líneas de código aquí...
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ✅ Widgets compuestos
// ═══════════════════════════════════════════════════════════════

class ComposedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _CustomAppBar(),
      body: const _PageContent(),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Title'),
      actions: const [
        _SearchButton(),
        _MoreButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PageContent extends StatelessWidget {
  const _PageContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _HeaderSection(),
        _ListSection(),
        _FooterSection(),
      ],
    );
  }
}
```

### State Management Guidelines

```dart
// ═══════════════════════════════════════════════════════════════
// CUÁNDO USAR QUÉ
// ═══════════════════════════════════════════════════════════════

// setState: Estado local simple
// - Toggle de UI
// - Form inputs
// - Animaciones locales

// Provider/Riverpod: Estado compartido simple
// - Theme
// - User session
// - Settings

// BLoC: Lógica de negocio compleja
// - Features completas
// - Flujos async complejos
// - Testing exhaustivo necesario

// ═══════════════════════════════════════════════════════════════
// EJEMPLO: Decidir por complejidad
// ═══════════════════════════════════════════════════════════════

// Simple toggle -> setState
class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () => setState(() => _isFavorite = !_isFavorite),
    );
  }
}

// Estado compartido -> Provider
class ThemeNotifier extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  void toggle() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// Lógica compleja -> BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final SecureStorage _storage;

  AuthBloc(this._authRepository, this._storage) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _authRepository.login(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) async {
        await _storage.saveToken(user.token);
        emit(Authenticated(user));
      },
    );
  }
}
```

### Checklist de Calidad

```markdown
## Pre-Commit Checklist

### Código
- [ ] Nombres descriptivos en inglés
- [ ] Documentación (qué, para qué, cómo)
- [ ] Sin código comentado
- [ ] Sin prints de debug
- [ ] Manejo de errores

### Performance
- [ ] const donde sea posible
- [ ] ListView.builder para listas
- [ ] dispose() limpia recursos
- [ ] Imágenes optimizadas

### Testing
- [ ] Tests unitarios para lógica
- [ ] Tests de widgets para UI
- [ ] Cobertura > 80%

### Documentación
- [ ] README actualizado
- [ ] Dartdoc en APIs públicas
- [ ] CHANGELOG actualizado
```

---

## 📖 Recursos

### Herramientas

- [Dart Analyzer](https://dart.dev/tools/dart-analyze)
- [Flutter DevTools](https://flutter.dev/docs/development/tools/devtools/overview)
- [dart_code_metrics](https://pub.dev/packages/dart_code_metrics)

### Guías

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Performance](https://docs.flutter.dev/perf)
- [Dartdoc Reference](https://dart.dev/tools/dartdoc)

---

> **Duración estimada:** 1 hora
