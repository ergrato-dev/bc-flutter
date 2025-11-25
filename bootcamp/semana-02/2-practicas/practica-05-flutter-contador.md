# 💻 Práctica 5: Contador Interactivo - Mi Primera App con Estado

**⏱️ Duración:** 45 minutos  
**📊 Dificultad:** ⭐⭐ Intermedio  
**🎯 Conceptos:** StatefulWidget, setState(), gestión de estado local, interactividad

---

## 🎯 Objetivo

Crear una **aplicación de contador personalizada** que responda a la interacción del usuario, introduciendo el concepto fundamental de **estado mutable** en Flutter.

---

## 📚 Conceptos que Aplicaremos

- ✅ `StatefulWidget` vs `StatelessWidget`
- ✅ `State` y ciclo de vida
- ✅ `setState()` para actualizar UI
- ✅ Gestión de estado local
- ✅ Interactividad con botones
- ✅ Condicionales en UI
- ✅ Formateo de números
- ✅ Iconos dinámicos

---

## 🖼️ Resultado Esperado

Una app de contador con:
- Contador visible grande
- Botón para incrementar
- Botón para decrementar
- Botón para resetear
- Indicadores visuales (par/impar, positivo/negativo)
- Animaciones y colores dinámicos
- Historial de acciones

---

## 📋 Instrucciones

### Paso 1: Crear Proyecto y Estructura (5 min)

```bash
# Crear nuevo proyecto
flutter create contador_app

# Entrar al proyecto
cd contador_app

# Abrir en VS Code
code .

# Ejecutar app
flutter run
```

Limpia `lib/main.dart` y crea la estructura base:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

// StatefulWidget - tiene estado que puede cambiar
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

// State - contiene la lógica y el estado mutable
class _CounterPageState extends State<CounterPage> {
  // Variable de estado - cuando cambia, la UI se reconstruye
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Interactivo'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Contador: $_counter'),
      ),
    );
  }
}
```

**Tareas:**
1. Crea el proyecto
2. Copia el código base
3. Verifica que compile y ejecute
4. Observa la diferencia entre `StatelessWidget` y `StatefulWidget`

### Paso 2: Implementar Lógica del Contador (10 min)

Agrega métodos para manipular el contador en `_CounterPageState`:

```dart
class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  
  // Método para incrementar
  void _increment() {
    setState(() {
      _counter++;
    });
  }
  
  // Método para decrementar
  void _decrement() {
    setState(() {
      _counter--;
    });
  }
  
  // Método para resetear
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }
  
  // Método auxiliar: verificar si es par
  bool _isEven() => _counter % 2 == 0;
  
  // Método auxiliar: verificar si es positivo
  bool _isPositive() => _counter > 0;
  
  // Método auxiliar: obtener color según valor
  Color _getCounterColor() {
    if (_counter > 0) return Colors.green;
    if (_counter < 0) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Interactivo'),
        centerTitle: true,
        actions: [
          // Botón para resetear en el AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
            tooltip: 'Resetear',
          ),
        ],
      ),
      body: Center(
        child: Text('Contador: $_counter'),
      ),
    );
  }
}
```

**Tareas:**
1. Copia los métodos
2. Entiende qué hace `setState()`
3. Observa los métodos auxiliares
4. Nota que el botón de reset ya funciona en el AppBar

### Paso 3: Diseñar la UI del Contador (15 min)

Reemplaza el `body` con una UI más completa:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: const Text('Contador Interactivo'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _reset,
          tooltip: 'Resetear',
        ),
      ],
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Etiqueta superior
            Text(
              'Valor Actual',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Contador grande
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: _getCounterColor().withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getCounterColor(),
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  '$_counter',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: _getCounterColor(),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Indicadores de estado
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _buildBadge(
                  label: _isEven() ? 'Par' : 'Impar',
                  icon: _isEven() ? Icons.exposure_zero : Icons.exposure_plus_1,
                  color: Colors.blue,
                ),
                _buildBadge(
                  label: _isPositive() 
                      ? 'Positivo' 
                      : _counter < 0 
                          ? 'Negativo' 
                          : 'Cero',
                  icon: _isPositive() 
                      ? Icons.arrow_upward 
                      : _counter < 0 
                          ? Icons.arrow_downward 
                          : Icons.remove,
                  color: _getCounterColor(),
                ),
                _buildBadge(
                  label: 'Abs: ${_counter.abs()}',
                  icon: Icons.numbers,
                  color: Colors.orange,
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón decrementar
                FloatingActionButton.extended(
                  onPressed: _decrement,
                  heroTag: 'decrement',
                  icon: const Icon(Icons.remove),
                  label: const Text('Restar'),
                  backgroundColor: Colors.red,
                ),
                
                const SizedBox(width: 20),
                
                // Botón incrementar
                FloatingActionButton.extended(
                  onPressed: _increment,
                  heroTag: 'increment',
                  icon: const Icon(Icons.add),
                  label: const Text('Sumar'),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Acciones rápidas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQuickButton(
                  label: '+10',
                  onPressed: () {
                    setState(() {
                      _counter += 10;
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildQuickButton(
                  label: '+5',
                  onPressed: () {
                    setState(() {
                      _counter += 5;
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildQuickButton(
                  label: '-5',
                  onPressed: () {
                    setState(() {
                      _counter -= 5;
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildQuickButton(
                  label: '-10',
                  onPressed: () {
                    setState(() {
                      _counter -= 10;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// Widget auxiliar para badges
Widget _buildBadge({
  required String label,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: color.withOpacity(0.5),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

// Widget auxiliar para botones rápidos
Widget _buildQuickButton({
  required String label,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: 60,
    height: 40,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(label),
    ),
  );
}
```

**Tareas:**
1. Copia todo el código
2. Observa cómo cambian los colores según el valor
3. Prueba todos los botones
4. Mira cómo los badges se actualizan automáticamente
5. Experimenta con los botones rápidos

### Paso 4: Agregar Funcionalidades Avanzadas (15 min)

Ahora agrega historial y más funciones. Actualiza `_CounterPageState`:

```dart
class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  List<String> _history = [];
  
  // Método para incrementar (con historial)
  void _increment() {
    setState(() {
      _counter++;
      _addToHistory('Incrementó a $_counter');
    });
  }
  
  // Método para decrementar (con historial)
  void _decrement() {
    setState(() {
      _counter--;
      _addToHistory('Decrementó a $_counter');
    });
  }
  
  // Método para resetear (con historial)
  void _reset() {
    setState(() {
      final oldValue = _counter;
      _counter = 0;
      _addToHistory('Reseteó desde $oldValue a 0');
    });
  }
  
  // Agregar acción al historial
  void _addToHistory(String action) {
    _history.insert(0, action);
    // Mantener solo las últimas 10 acciones
    if (_history.length > 10) {
      _history.removeLast();
    }
  }
  
  // Método auxiliar: verificar si es par
  bool _isEven() => _counter % 2 == 0;
  
  // Método auxiliar: verificar si es positivo
  bool _isPositive() => _counter > 0;
  
  // Método auxiliar: obtener color según valor
  Color _getCounterColor() {
    if (_counter > 0) return Colors.green;
    if (_counter < 0) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Contador Interactivo'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
            tooltip: 'Resetear',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showHistory(context),
            tooltip: 'Ver historial',
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ... (mantén todo el código anterior del body)
              
              // Agrega al final, después de los botones rápidos:
              
              const SizedBox(height: 30),
              
              // Información adicional
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Estadísticas',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Divider(),
                      _buildStatRow('Total acciones:', '${_history.length}'),
                      _buildStatRow('Valor absoluto:', '${_counter.abs()}'),
                      _buildStatRow('Doble:', '${_counter * 2}'),
                      _buildStatRow('Mitad:', '${_counter / 2}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Widget para fila de estadística
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
  
  // Mostrar historial en un diálogo
  void _showHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historial de Acciones'),
        content: SizedBox(
          width: double.maxFinite,
          child: _history.isEmpty
              ? const Text('No hay acciones registradas')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(_history[index]),
                      dense: true,
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _history.clear();
              });
              Navigator.pop(context);
            },
            child: const Text('Limpiar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
  
  // ... (mantén los widgets auxiliares _buildBadge y _buildQuickButton)
}
```

**Tareas:**
1. Agrega el historial de acciones
2. Implementa el diálogo de historial
3. Agrega la tarjeta de estadísticas
4. Prueba todas las funcionalidades
5. Observa cómo se registran las acciones

---

## ✅ Checklist de Completación

- [ ] Proyecto creado y ejecutándose
- [ ] `StatefulWidget` implementado correctamente
- [ ] Contador incrementa con botón +
- [ ] Contador decrementa con botón -
- [ ] Botón reset funciona
- [ ] Colores cambian según valor (positivo/negativo)
- [ ] Badges muestran información correcta (par/impar, etc.)
- [ ] Botones rápidos (+10, +5, -5, -10) funcionan
- [ ] Historial registra acciones
- [ ] Diálogo de historial se muestra correctamente
- [ ] Estadísticas calculan valores correctos
- [ ] UI responsive y fluida

---

## 🚀 Desafíos Opcionales

### 1. Límites del Contador

```dart
class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  final int _maxValue = 100;
  final int _minValue = -100;
  
  void _increment() {
    setState(() {
      if (_counter < _maxValue) {
        _counter++;
        _addToHistory('Incrementó a $_counter');
      } else {
        _showLimitMessage('¡Límite máximo alcanzado!');
      }
    });
  }
  
  void _decrement() {
    setState(() {
      if (_counter > _minValue) {
        _counter--;
        _addToHistory('Decrementó a $_counter');
      } else {
        _showLimitMessage('¡Límite mínimo alcanzado!');
      }
    });
  }
  
  void _showLimitMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
```

### 2. Animación del Contador

```dart
// Al inicio de _CounterPageState
import 'package:flutter/material.dart';

class _CounterPageState extends State<CounterPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }
  
  void _increment() {
    setState(() {
      _counter++;
      _addToHistory('Incrementó a $_counter');
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
      body: Center(
        child: Column(
          children: [
            // Contador con animación
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                // ... (tu Container del contador)
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

### 3. Guardar Contador Persistentemente

```dart
// Agrega al pubspec.yaml:
// dependencies:
//   shared_preferences: ^2.2.2

import 'package:shared_preferences/shared_preferences.dart';

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }
  
  // Cargar contador guardado
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }
  
  // Guardar contador
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }
  
  void _increment() {
    setState(() {
      _counter++;
      _addToHistory('Incrementó a $_counter');
    });
    _saveCounter();
  }
  
  void _decrement() {
    setState(() {
      _counter--;
      _addToHistory('Decrementó a $_counter');
    });
    _saveCounter();
  }
}
```

### 4. Paso Personalizado

```dart
class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  int _step = 1;  // Paso actual
  
  void _showStepDialog() {
    showDialog(
      context: context,
      builder: (context) {
        int tempStep = _step;
        return AlertDialog(
          title: const Text('Configurar Paso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('¿De cuánto en cuánto quieres contar?'),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Paso',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  tempStep = int.tryParse(value) ?? 1;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _step = tempStep;
                });
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
  
  void _increment() {
    setState(() {
      _counter += _step;
      _addToHistory('Incrementó $_step (total: $_counter)');
    });
  }
  
  void _decrement() {
    setState(() {
      _counter -= _step;
      _addToHistory('Decrementó $_step (total: $_counter)');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Interactivo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showStepDialog,
            tooltip: 'Configurar paso',
          ),
          // ... otros botones
        ],
      ),
      // ... resto del código
    );
  }
}
```

### 5. Múltiples Contadores

```dart
class _CounterPageState extends State<CounterPage> {
  List<Counter> _counters = [
    Counter(name: 'Contador 1', value: 0, color: Colors.blue),
    Counter(name: 'Contador 2', value: 0, color: Colors.green),
    Counter(name: 'Contador 3', value: 0, color: Colors.red),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _counters.length,
        itemBuilder: (context, index) {
          final counter = _counters[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(counter.name),
              subtitle: Text('Valor: ${counter.value}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        counter.value--;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        counter.value++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counters.add(
              Counter(
                name: 'Contador ${_counters.length + 1}',
                value: 0,
                color: Colors.primaries[_counters.length % Colors.primaries.length],
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Counter {
  String name;
  int value;
  Color color;
  
  Counter({required this.name, required this.value, required this.color});
}
```

---

## 📸 Verificación Visual

Tu app debe mostrar:
- ✅ Círculo grande con el número del contador
- ✅ Color verde para positivos, rojo para negativos
- ✅ Badges indicando par/impar y signo
- ✅ Botones grandes de +/- funcionales
- ✅ Botones rápidos (+10, +5, -5, -10)
- ✅ Tarjeta de estadísticas
- ✅ Historial en diálogo
- ✅ Todo responde al toque

---

## 📚 Recursos Adicionales

- [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [setState](https://api.flutter.dev/flutter/widgets/State/setState.html)
- [Widget Lifecycle](https://flutter.dev/docs/development/ui/interactive)
- [Material Dialogs](https://material.io/components/dialogs)

---

## 💡 Conceptos Clave

**StatelessWidget:**
- No tiene estado mutable
- Se usa para UI estática
- Más eficiente en performance

**StatefulWidget:**
- Tiene estado que puede cambiar
- Se usa para UI interactiva
- Requiere `setState()` para actualizar

**setState():**
- Notifica a Flutter que el estado cambió
- Provoca que el widget se reconstruya
- SIEMPRE úsalo para cambiar variables de estado

**State Lifecycle:**
1. `initState()` - Inicialización
2. `build()` - Construye UI
3. `setState()` - Actualiza estado
4. `dispose()` - Limpieza

---

**⏱️ Tiempo:** 45 minutos  
**🎯 Dificultad:** ⭐⭐ Intermedio  
**🎨 Enfoque:** Interactividad y estado

**🎉 ¡Excelente!** Has aprendido el concepto más importante de Flutter: la gestión de estado. Esto es la base para crear cualquier app interactiva.
