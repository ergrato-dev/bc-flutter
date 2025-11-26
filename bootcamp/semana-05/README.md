# 🔄 Semana 05: Gestión de Estado en Flutter

---

## 📋 Información General

| Aspecto            | Detalle                   |
| ------------------ | ------------------------- |
| **Semana**         | 05 de 10                  |
| **Tema**           | Gestión de Estado         |
| **Dedicación**     | 8 horas                   |
| **Nivel**          | Intermedio                |
| **Prerrequisitos** | Semanas 01-04 completadas |

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana, serás capaz de:

- [ ] Diferenciar entre **estado efímero** y **estado de aplicación**
- [ ] Implementar **setState()** correctamente y conocer sus limitaciones
- [ ] Dominar el **ciclo de vida** de StatefulWidget
- [ ] Usar **Provider** con ChangeNotifier para estado global
- [ ] Optimizar rendimiento con **Consumer** y **Selector**
- [ ] Conocer **BLoC/Cubit** como alternativa
- [ ] Conocer **Riverpod** como solución moderna
- [ ] Escribir **tests** para lógica de estado
- [ ] Aplicar **arquitectura** separando lógica de presentación

---

## 📚 Contenido de la Semana

### 📖 Teoría (3 módulos)

| #   | Módulo                                                            | Contenido                                         | Tiempo |
| --- | ----------------------------------------------------------------- | ------------------------------------------------- | ------ |
| 01  | [Estado Local y setState](./1-teoria/01-estado-local-setstate.md) | StatefulWidget, setState, ciclo de vida           | 50 min |
| 02  | [Provider](./1-teoria/02-provider.md)                             | ChangeNotifier, Consumer, Selector, MultiProvider | 60 min |
| 03  | [Estado Avanzado](./1-teoria/03-estado-avanzado.md)               | BLoC/Cubit intro, Riverpod intro, comparación     | 40 min |

**Tiempo estimado teoría:** 2.5 horas

---

### 💻 Prácticas (5 ejercicios)

| #   | Práctica                                                                  | Descripción                  | Nivel  | Pts |
| --- | ------------------------------------------------------------------------- | ---------------------------- | ------ | --- |
| 01  | [Estado Local](./2-practicas/practica-01-estado-local.md)                 | Lista de tareas con setState | ⭐     | 5   |
| 02  | [Provider Cart](./2-practicas/practica-02-provider-cart.md)               | Carrito con ChangeNotifier   | ⭐⭐   | 6   |
| 03  | [Selector Performance](./2-practicas/practica-03-selector-performance.md) | Optimización con Selector    | ⭐⭐   | 6   |
| 04  | [BLoC/Cubit](./2-practicas/practica-04-bloc-cubit.md)                     | Carrito con Cubit            | ⭐⭐⭐ | 6   |
| 05  | [Riverpod + Tests](./2-practicas/practica-05-riverpod-advanced.md)        | Riverpod con pruebas         | ⭐⭐⭐ | 7   |

**Tiempo estimado prácticas:** 2.5 horas

---

### 🔨 Proyecto Integrador: ShopApp

| Aspecto         | Detalle                                      |
| --------------- | -------------------------------------------- |
| **Nombre**      | ShopApp - Tienda con Estado                  |
| **Descripción** | App de tienda con gestión de estado completa |
| **Puntos**      | 50 pts (50% de la nota)                      |
| **Tiempo**      | 3 horas                                      |

**Documentación del Proyecto:**

- 📋 [README - Especificación completa](./3-proyecto/README.md)

**Características principales:**

- Catálogo de productos (mock data)
- Carrito de compras global (Provider)
- Contador en AppBar con Selector
- Favoritos (opcional)
- Persistencia local (opcional)

---

## 🗂️ Estructura de la Semana

```
semana-05/
├── README.md                    # 📍 Este documento
├── RUBRICA-EVALUACION.md        # 📊 Criterios de evaluación
├── 0-assets/                    # 🎨 Diagramas SVG
├── 1-teoria/                    # 📖 Módulos teóricos
│   ├── README.md
│   ├── 01-estado-local-setstate.md
│   ├── 02-provider.md
│   └── 03-estado-avanzado.md
├── 2-practicas/                 # 💻 Ejercicios prácticos
│   ├── README.md
│   ├── practica-01-estado-local.md
│   ├── practica-02-provider-cart.md
│   ├── practica-03-selector-performance.md
│   ├── practica-04-bloc-cubit.md
│   └── practica-05-riverpod-advanced.md
├── 3-proyecto/                  # 🔨 Proyecto integrador
│   └── README.md
├── 4-recursos/                  # 📚 Material de apoyo (12 docs)
│   ├── README.md
│   ├── 01-videos-setstate.md
│   ├── 02-videos-provider.md
│   ├── ... (12 archivos)
│   └── 12-canales-youtube.md
└── 5-glosario/                  # 📖 Términos técnicos
    └── README.md
```

---

## ⏱️ Distribución del Tiempo (8 horas)

| Actividad                | Horas   | Porcentaje |
| ------------------------ | ------- | ---------- |
| Teoría (3 módulos)       | 2.5 h   | 31%        |
| Prácticas (5 ejercicios) | 2.5 h   | 31%        |
| Proyecto ShopApp         | 3 h     | 38%        |
| **TOTAL**                | **8 h** | **100%**   |

---

## 📊 Sistema de Evaluación

| Componente         | Puntos      | Porcentaje |
| ------------------ | ----------- | ---------- |
| Evaluación Teórica | 20 pts      | 20%        |
| Prácticas (5)      | 30 pts      | 30%        |
| Proyecto ShopApp   | 50 pts      | 50%        |
| **TOTAL**          | **100 pts** | **100%**   |

### Escala de Calificación

| Rango  | Calificación    |
| ------ | --------------- |
| 90-100 | ⭐ Excelente    |
| 80-89  | ✅ Muy Bueno    |
| 70-79  | 👍 Bueno        |
| 60-69  | ⚠️ Suficiente   |
| 0-59   | ❌ Insuficiente |

📋 [Ver Rúbrica Detallada](./RUBRICA-EVALUACION.md)

---

## 🛣️ Ruta de Aprendizaje Sugerida

### Día 1-2: Fundamentos (3 horas)

```
1. 📖 Leer: 01-estado-local-setstate.md (50 min)
2. 💻 Hacer: practica-01 - Estado local (30 min)
3. 📖 Leer: 02-provider.md (60 min)
4. 💻 Hacer: practica-02 - Provider cart (60 min)
```

### Día 3-4: Optimización y Alternativas (2.5 horas)

```
1. 💻 Hacer: practica-03 - Selector (45 min)
2. 📖 Leer: 03-estado-avanzado.md (40 min)
3. 💻 Hacer: practica-04 - BLoC/Cubit (45 min)
4. 💻 Hacer: practica-05 - Riverpod (30 min)
```

### Día 5-7: Proyecto Integrador (2.5 horas)

```
1. 📋 Revisar: Especificación ShopApp (15 min)
2. 🔨 Desarrollar: Implementación del proyecto (2+ horas)
```

---

## 🔑 Conceptos Clave

### setState (Estado Local)

```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() => _count++);
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_count');
  }
}
```

### Provider (Estado Global)

```dart
// Modelo
class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => List.unmodifiable(_items);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

// Uso
final count = context.select<CartModel, int>((c) => c.items.length);
```

### Comparación Rápida

| Solución | Uso             | Complejidad |
| -------- | --------------- | ----------- |
| setState | Local           | Baja        |
| Provider | Global          | Media       |
| BLoC     | Global/Complejo | Alta        |
| Riverpod | Global/Moderno  | Media       |

---

## ✅ Checklist de Completitud

### Teoría

- [ ] Módulo 01: Estado Local y setState
- [ ] Módulo 02: Provider
- [ ] Módulo 03: Estado Avanzado

### Prácticas

- [ ] Práctica 01: Estado Local (5 pts)
- [ ] Práctica 02: Provider Cart (6 pts)
- [ ] Práctica 03: Selector Performance (6 pts)
- [ ] Práctica 04: BLoC/Cubit (6 pts)
- [ ] Práctica 05: Riverpod + Tests (7 pts)

### Proyecto

- [ ] Catálogo de productos
- [ ] Carrito con Provider
- [ ] Contador en AppBar (Selector)
- [ ] Tests básicos
- [ ] Código documentado

---

## 📚 Recursos de Apoyo

- 📖 [Documentación Oficial](./4-recursos/08-documentacion-oficial.md)
- 📹 [Videos Provider](./4-recursos/02-videos-provider.md)
- 📹 [Videos BLoC/Riverpod](./4-recursos/03-videos-bloc-riverpod.md)
- 🔧 [Herramientas](./4-recursos/09-herramientas-desarrollo.md)
- 📚 [Ver Todos los Recursos](./4-recursos/README.md)
- 📖 [Glosario de Términos](./5-glosario/README.md)

---

## 🔗 Navegación del Bootcamp

| ⬅️ Anterior                                     | 🏠 Inicio                              | ➡️ Siguiente                                     |
| ----------------------------------------------- | -------------------------------------- | ------------------------------------------------ |
| [Semana 04: Navegación](../semana-04/README.md) | [Índice del Bootcamp](../../README.md) | [Semana 06: APIs y HTTP](../semana-06/README.md) |

---

## 💡 Tips para esta Semana

1. **Empieza simple**: setState para estado local, Provider para global
2. **Selector es tu amigo**: Evita rebuilds innecesarios
3. **notifyListeners()**: No olvides llamarlo al cambiar estado
4. **Separa lógica**: Providers sin UI, UI sin lógica de negocio
5. **Testea tu estado**: La lógica separada es fácil de testear
6. **DevTools**: Usa el Widget Inspector para ver rebuilds

---

## ❓ FAQ

### ¿Cuándo usar setState vs Provider?

- **setState**: Estado que solo importa a un widget (animación, form local)
- **Provider**: Estado compartido entre múltiples widgets/pantallas

### ¿Provider, BLoC o Riverpod?

- **Provider**: Simple, oficial, buena curva de aprendizaje
- **BLoC**: Más boilerplate pero excelente para apps grandes
- **Riverpod**: Moderno, sin context, muy testable

### ¿Por qué mi UI no se actualiza?

Verifica que estés llamando `notifyListeners()` después de cambiar el estado.

---

_Semana 05 - Gestión de Estado en Flutter_  
_Bootcamp Flutter - 8 horas de dedicación_  
_¡Domina el estado y crea apps reactivas! 🚀_

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
