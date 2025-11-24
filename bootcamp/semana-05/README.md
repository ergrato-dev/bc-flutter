# Semana 5: Gestión de Estado

## 🎯 Objetivos de Aprendizaje

- Comprender los diferentes tipos de estado en Flutter
- Dominar setState y estado local
- Implementar Provider para gestión de estado
- Conocer otros patrones de gestión de estado
- Aplicar arquitecturas escalables
- Optimizar el rendimiento de la aplicación

## 📚 Contenido Teórico

### 1. Fundamentos de Estado (2 horas)

#### ¿Qué es el Estado?

- Estado efímero vs Estado de aplicación
- Cuándo usar cada tipo
- Ciclo de vida del estado

#### StatefulWidget vs StatelessWidget

```dart
// StatelessWidget - Sin estado mutable
class MiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Inmutable');
  }
}

// StatefulWidget - Con estado mutable
class MiWidget extends StatefulWidget {
  @override
  _MiWidgetState createState() => _MiWidgetState();
}

class _MiWidgetState extends State<MiWidget> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Text('$contador');
  }
}
```

#### Ciclo de Vida de StatefulWidget

- `initState()`: Inicialización
- `build()`: Construir UI
- `setState()`: Actualizar estado
- `didUpdateWidget()`: Widget actualizado
- `dispose()`: Limpieza

### 2. Estado Local con setState (2 horas)

#### Uso Básico

```dart
void _incrementar() {
  setState(() {
    contador++;
  });
}
```

#### Buenas Prácticas

- Mantener setState lo más pequeño posible
- No hacer operaciones costosas dentro de setState
- Evitar llamadas setState innecesarias

#### Lifting State Up

```dart
// Mover estado al padre cuando varios hijos lo necesitan
class Padre extends StatefulWidget {
  @override
  _PadreState createState() => _PadreState();
}

class _PadreState extends State<Padre> {
  String dato = '';

  void _actualizarDato(String nuevo) {
    setState(() {
      dato = nuevo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HijoA(dato: dato, onCambio: _actualizarDato),
        HijoB(dato: dato),
      ],
    );
  }
}
```

### 3. Provider (3 horas)

#### Instalación

```yaml
# pubspec.yaml
dependencies:
  provider: ^6.1.1
```

#### ChangeNotifier

```dart
class ContadorModel extends ChangeNotifier {
  int _contador = 0;

  int get contador => _contador;

  void incrementar() {
    _contador++;
    notifyListeners();
  }

  void decrementar() {
    _contador--;
    notifyListeners();
  }
}
```

#### Proveer el Estado

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContadorModel(),
      child: MyApp(),
    ),
  );
}

// Múltiples providers
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ContadorModel()),
    ChangeNotifierProvider(create: (_) => CarritoModel()),
  ],
  child: MyApp(),
)
```

#### Consumir el Estado

```dart
// Consumer
Consumer<ContadorModel>(
  builder: (context, contador, child) {
    return Text('${contador.contador}');
  },
)

// Provider.of
final contador = Provider.of<ContadorModel>(context);

// context.watch (Flutter 2.0+)
final contador = context.watch<ContadorModel>();

// context.read (no reconstruye)
context.read<ContadorModel>().incrementar();
```

#### Selector para Optimización

```dart
Selector<CarritoModel, int>(
  selector: (context, carrito) => carrito.cantidadItems,
  builder: (context, cantidad, child) {
    return Text('Items: $cantidad');
  },
)
```

### 4. Otros Patrones de Estado (1 hora)

#### BLoC (Business Logic Component)

```dart
// Básico
class ContadorBloc {
  final _contadorController = StreamController<int>();
  int _contador = 0;

  Stream<int> get contador => _contadorController.stream;

  void incrementar() {
    _contador++;
    _contadorController.sink.add(_contador);
  }

  void dispose() {
    _contadorController.close();
  }
}
```

#### Riverpod

- Evolución de Provider
- Type-safe
- Compile-time safety

#### GetX

- Todo en uno: state, routes, dependencies
- Menos boilerplate
- Performance

#### Comparison

| Patrón   | Curva Aprendizaje | Boilerplate | Recomendado Para   |
| -------- | ----------------- | ----------- | ------------------ |
| setState | Baja              | Bajo        | Apps pequeñas      |
| Provider | Media             | Medio       | Apps medianas      |
| BLoC     | Alta              | Alto        | Apps grandes       |
| Riverpod | Media             | Medio       | Apps modernas      |
| GetX     | Baja              | Bajo        | Prototipado rápido |

## 💻 Ejercicios Prácticos

### Ejercicio 1: setState - Formulario Interactivo

Crea un formulario que:

- Capture nombre, email, edad
- Valide en tiempo real
- Muestre preview de los datos
- Botón submit habilitado solo si es válido

### Ejercicio 2: Provider - Lista de Tareas

Implementa un gestor de tareas con Provider:

- Agregar tarea
- Marcar como completada
- Eliminar tarea
- Filtrar (todas/completadas/pendientes)
- Contador de tareas

### Ejercicio 3: Provider - Tema de App

Crea un sistema de temas:

- Toggle entre tema claro/oscuro
- Guardar preferencia
- Aplicar en toda la app
- Animación de transición

### Ejercicio 4: Multiple Providers

Desarrolla una app con múltiples estados:

- Provider de autenticación
- Provider de datos de usuario
- Provider de preferencias
- Interacción entre providers

### Ejercicio 5: Optimización con Selector

Optimiza una lista grande:

- 1000+ items
- Búsqueda en tiempo real
- Solo reconstruir items necesarios
- Medir performance

## 🔨 Proyecto de la Semana

**App de Gestión de Gastos Personales**

Desarrolla una aplicación completa de finanzas personales usando Provider:

**Características:**

1. **Gestión de Gastos**

   - Agregar gasto (monto, categoría, descripción, fecha)
   - Editar gasto existente
   - Eliminar gasto
   - Lista de todos los gastos

2. **Categorías**

   - Crear categorías personalizadas
   - Asignar color e icono a cada categoría
   - Estadísticas por categoría

3. **Dashboard**

   - Total de gastos del mes
   - Gastos por categoría (gráfico de torta)
   - Tendencia mensual
   - Top 5 gastos más grandes

4. **Filtros y Búsqueda**

   - Filtrar por categoría
   - Filtrar por rango de fechas
   - Buscar por descripción
   - Ordenar por fecha/monto

5. **Configuración**
   - Presupuesto mensual
   - Alertas cuando se exceda
   - Tema claro/oscuro
   - Moneda

**Requisitos técnicos:**

```dart
// Modelos
class Gasto {
  final String id;
  final double monto;
  final String categoria;
  final String descripcion;
  final DateTime fecha;
}

class Categoria {
  final String id;
  final String nombre;
  final IconData icono;
  final Color color;
}

// Providers necesarios
class GastosProvider extends ChangeNotifier {
  List<Gasto> _gastos = [];

  List<Gasto> get gastos => _gastos;

  void agregarGasto(Gasto gasto) { }
  void editarGasto(String id, Gasto gasto) { }
  void eliminarGasto(String id) { }

  double get totalMes { }
  Map<String, double> get gastosPorCategoria { }
  List<Gasto> filtrarPorCategoria(String categoria) { }
}

class CategoriasProvider extends ChangeNotifier {
  List<Categoria> _categorias = [];

  void agregarCategoria(Categoria categoria) { }
  void eliminarCategoria(String id) { }
}

class ConfiguracionProvider extends ChangeNotifier {
  double _presupuestoMensual = 0;
  bool _temaOscuro = false;
  String _moneda = 'COP';

  // Getters y setters
}
```

**Pantallas:**

1. Dashboard (resumen)
2. Lista de gastos
3. Agregar/Editar gasto
4. Categorías
5. Estadísticas
6. Configuración

**Funcionalidades adicionales:**

- Persistencia con SharedPreferences
- Validación de formularios
- Notificaciones cuando se exceda presupuesto
- Export de datos a CSV
- Gráficos básicos (puede usar paquete charts_flutter)

## 📖 Recursos

### Documentación

- [State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Provider Package](https://pub.dev/packages/provider)
- [Simple App State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)

### Videos

- [Provider State Management](https://www.youtube.com/watch?v=d_m5csmrf7I)
- [Flutter State Management Comparison](https://www.youtube.com/watch?v=3tm-R7ymwhc)

### Paquetes

- [provider](https://pub.dev/packages/provider)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [riverpod](https://pub.dev/packages/riverpod)
- [get](https://pub.dev/packages/get)
- [mobx](https://pub.dev/packages/mobx)

## ✅ Checklist de Completitud

- [ ] Ejercicio 1: Formulario completado
- [ ] Ejercicio 2: Lista de tareas completado
- [ ] Ejercicio 3: Sistema de temas completado
- [ ] Ejercicio 4: Multiple providers completado
- [ ] Ejercicio 5: Optimización completado
- [ ] Proyecto: App de gastos completado
- [ ] Providers implementados correctamente
- [ ] Estados sincronizados
- [ ] Performance optimizado
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios prácticos (1-5):** 30%
- **Proyecto de la semana:** 60%
- **Arquitectura y clean code:** 10%

## 📝 Notas Importantes

- No sobrecargar los providers con lógica compleja
- Separar responsabilidades (un provider, una responsabilidad)
- Evitar setState en widgets grandes
- Use `const` constructors cuando sea posible
- Prefer `context.read` para acciones, `context.watch` para UI

## 🔧 Best Practices

```dart
// ✅ Buena práctica
class MiProvider extends ChangeNotifier {
  int _contador = 0;
  int get contador => _contador;

  void incrementar() {
    _contador++;
    notifyListeners();
  }
}

// ❌ Mala práctica
class MiProvider extends ChangeNotifier {
  int contador = 0; // No usar propiedades públicas mutables
}

// ✅ Optimización con Selector
Selector<CarritoModel, int>(
  selector: (_, carrito) => carrito.items.length,
  builder: (_, cantidad, __) => Text('$cantidad'),
)

// ❌ Consumer innecesario
Consumer<CarritoModel>(
  builder: (_, carrito, __) => Text('${carrito.items.length}'),
)
```

## 🎯 Conceptos Clave

- **Single Source of Truth**: Un solo lugar para cada estado
- **Immutability**: Preferir objetos inmutables
- **Separation of Concerns**: Separar lógica de UI
- **Testability**: Código fácil de testear
- **Performance**: Evitar reconstrucciones innecesarias

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 4](../semana-04/README.md) | **Siguiente:** [Semana 6 →](../semana-06/README.md)
