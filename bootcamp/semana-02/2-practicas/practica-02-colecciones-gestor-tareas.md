# 💻 Práctica 2: Colecciones - Gestor de Tareas

**⏱️ Duración:** 45 minutos  
**📊 Dificultad:** ⭐⭐ Media  
**🎯 Conceptos:** List, Map, filtrado, transformación, estadísticas

---

## 🎯 Objetivo

Crear un **gestor de tareas (TODO)** usando colecciones para organizar, filtrar y analizar tareas con diferentes estados y prioridades.

---

## 📚 Conceptos que Aplicaremos

- ✅ List para almacenar tareas
- ✅ Map para representar objetos
- ✅ Métodos where(), map(), fold()
- ✅ Enumeraciones
- ✅ Filtrado y búsqueda
- ✅ Cálculo de estadísticas

---

## 🖼️ Resultado Esperado

```
╔═══════════════════════════════════════════╗
║         GESTOR DE TAREAS - TODO           ║
╚═══════════════════════════════════════════╝

✓ Tarea creada: Estudiar Dart (Prioridad: alta)
✓ Tarea creada: Hacer ejercicio (Prioridad: media)
✓ Tarea creada: Leer libro (Prioridad: baja)
✓ Tarea creada: Proyecto Flutter (Prioridad: urgente)

📋 TODAS LAS TAREAS (4)
═══════════════════════════════════════════
[⏳] 🔴 Proyecto Flutter (urgente)
[⏳] 🟠 Estudiar Dart (alta)
[⏳] 🟡 Hacer ejercicio (media)
[⏳] 🟢 Leer libro (baja)

✓ Tarea completada: Estudiar Dart

📊 ESTADÍSTICAS
═══════════════════════════════════════════
Total de tareas: 4
✓ Completadas: 1 (25.00%)
⏳ Pendientes: 3 (75.00%)

Por prioridad:
  🔴 Urgente: 1
  🟠 Alta: 1
  🟡 Media: 1
  🟢 Baja: 1

⚡ TAREAS URGENTES Y DE ALTA PRIORIDAD
═══════════════════════════════════════════
[⏳] 🔴 Proyecto Flutter
```

---

## 📋 Instrucciones

### Paso 1: Definir Enumeraciones (5 min)

```dart
// Estado de la tarea
enum TaskStatus {
  pending,    // Pendiente
  completed,  // Completada
  cancelled,  // Cancelada
}

// Prioridad de la tarea
enum Priority {
  low,       // Baja
  medium,    // Media
  high,      // Alta
  urgent,    // Urgente
}
```

**Tareas:**
1. Copia las enumeraciones
2. Entiende cada valor
3. Piensa en cómo usarlas

### Paso 2: Clase Helper para Funciones Auxiliares (10 min)

```dart
class TaskHelper {
  // Obtener emoji según estado
  static String getStatusEmoji(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return '⏳';
      case TaskStatus.completed:
        return '✅';
      case TaskStatus.cancelled:
        return '❌';
    }
  }
  
  // Obtener emoji según prioridad
  static String getPriorityEmoji(Priority priority) {
    switch (priority) {
      case Priority.low:
        return '🟢';
      case Priority.medium:
        return '🟡';
      case Priority.high:
        return '🟠';
      case Priority.urgent:
        return '🔴';
    }
  }
  
  // Obtener texto de prioridad
  static String getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.low:
        return 'baja';
      case Priority.medium:
        return 'media';
      case Priority.high:
        return 'alta';
      case Priority.urgent:
        return 'urgente';
    }
  }
  
  // Obtener texto de estado
  static String getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'pendiente';
      case TaskStatus.completed:
        return 'completada';
      case TaskStatus.cancelled:
        return 'cancelada';
    }
  }
}
```

### Paso 3: Clase TaskManager (20 min)

```dart
class TaskManager {
  List<Map<String, dynamic>> tasks;
  
  TaskManager() : tasks = [];
  
  // Crear nueva tarea
  void addTask(String title, String description, Priority priority) {
    var task = {
      'id': tasks.length + 1,
      'title': title,
      'description': description,
      'priority': priority,
      'status': TaskStatus.pending,
      'createdAt': DateTime.now(),
    };
    
    tasks.add(task);
    print('✓ Tarea creada: $title (Prioridad: ${TaskHelper.getPriorityText(priority)})');
  }
  
  // Completar tarea
  void completeTask(int id) {
    var task = tasks.firstWhere(
      (t) => t['id'] == id,
      orElse: () => {},
    );
    
    if (task.isEmpty) {
      print('✗ Tarea no encontrada');
      return;
    }
    
    task['status'] = TaskStatus.completed;
    print('✓ Tarea completada: ${task['title']}');
  }
  
  // Cancelar tarea
  void cancelTask(int id) {
    var task = tasks.firstWhere(
      (t) => t['id'] == id,
      orElse: () => {},
    );
    
    if (task.isEmpty) {
      print('✗ Tarea no encontrada');
      return;
    }
    
    task['status'] = TaskStatus.cancelled;
    print('✓ Tarea cancelada: ${task['title']}');
  }
  
  // Listar todas las tareas
  void listAllTasks() {
    if (tasks.isEmpty) {
      print('No hay tareas');
      return;
    }
    
    print('\n📋 TODAS LAS TAREAS (${tasks.length})');
    print('═' * 43);
    
    // Ordenar por prioridad (urgente primero)
    var sortedTasks = List<Map<String, dynamic>>.from(tasks);
    sortedTasks.sort((a, b) {
      var priorityOrder = {
        Priority.urgent: 0,
        Priority.high: 1,
        Priority.medium: 2,
        Priority.low: 3,
      };
      return priorityOrder[a['priority']]!.compareTo(priorityOrder[b['priority']]!);
    });
    
    for (var task in sortedTasks) {
      _displayTask(task);
    }
  }
  
  // Listar tareas pendientes
  void listPendingTasks() {
    var pending = tasks.where((t) => t['status'] == TaskStatus.pending).toList();
    
    if (pending.isEmpty) {
      print('No hay tareas pendientes');
      return;
    }
    
    print('\n⏳ TAREAS PENDIENTES (${pending.length})');
    print('═' * 43);
    
    for (var task in pending) {
      _displayTask(task);
    }
  }
  
  // Listar tareas completadas
  void listCompletedTasks() {
    var completed = tasks.where((t) => t['status'] == TaskStatus.completed).toList();
    
    if (completed.isEmpty) {
      print('No hay tareas completadas');
      return;
    }
    
    print('\n✅ TAREAS COMPLETADAS (${completed.length})');
    print('═' * 43);
    
    for (var task in completed) {
      _displayTask(task);
    }
  }
  
  // Filtrar por prioridad
  List<Map<String, dynamic>> filterByPriority(Priority priority) {
    return tasks.where((t) => t['priority'] == priority).toList();
  }
  
  // Filtrar tareas urgentes y de alta prioridad
  void listHighPriorityTasks() {
    var highPriority = tasks.where((t) => 
      (t['priority'] == Priority.urgent || t['priority'] == Priority.high) &&
      t['status'] == TaskStatus.pending
    ).toList();
    
    if (highPriority.isEmpty) {
      print('No hay tareas urgentes o de alta prioridad');
      return;
    }
    
    print('\n⚡ TAREAS URGENTES Y DE ALTA PRIORIDAD');
    print('═' * 43);
    
    for (var task in highPriority) {
      _displayTask(task);
    }
  }
  
  // Mostrar estadísticas
  void showStats() {
    if (tasks.isEmpty) {
      print('No hay tareas para analizar');
      return;
    }
    
    var total = tasks.length;
    var completed = tasks.where((t) => t['status'] == TaskStatus.completed).length;
    var pending = tasks.where((t) => t['status'] == TaskStatus.pending).length;
    var cancelled = tasks.where((t) => t['status'] == TaskStatus.cancelled).length;
    
    var completedPercent = (completed / total * 100).toStringAsFixed(2);
    var pendingPercent = (pending / total * 100).toStringAsFixed(2);
    
    print('\n📊 ESTADÍSTICAS');
    print('═' * 43);
    print('Total de tareas: $total');
    print('✓ Completadas: $completed ($completedPercent%)');
    print('⏳ Pendientes: $pending ($pendingPercent%)');
    if (cancelled > 0) {
      print('❌ Canceladas: $cancelled');
    }
    
    // Estadísticas por prioridad
    print('\nPor prioridad:');
    for (var priority in Priority.values) {
      var count = tasks.where((t) => t['priority'] == priority).length;
      if (count > 0) {
        print('  ${TaskHelper.getPriorityEmoji(priority)} ${TaskHelper.getPriorityText(priority).toUpperCase()}: $count');
      }
    }
  }
  
  // Buscar tareas por palabra clave
  List<Map<String, dynamic>> searchTasks(String keyword) {
    var lowerKeyword = keyword.toLowerCase();
    return tasks.where((t) {
      var title = (t['title'] as String).toLowerCase();
      var description = (t['description'] as String).toLowerCase();
      return title.contains(lowerKeyword) || description.contains(lowerKeyword);
    }).toList();
  }
  
  // Método privado para mostrar una tarea
  void _displayTask(Map<String, dynamic> task) {
    var statusEmoji = TaskHelper.getStatusEmoji(task['status']);
    var priorityEmoji = TaskHelper.getPriorityEmoji(task['priority']);
    print('[$statusEmoji] $priorityEmoji ${task['title']} (${TaskHelper.getPriorityText(task['priority'])})');
  }
}
```

### Paso 4: Programa Principal (10 min)

```dart
void main() {
  print('╔═══════════════════════════════════════════╗');
  print('║         GESTOR DE TAREAS - TODO           ║');
  print('╚═══════════════════════════════════════════╝\n');
  
  var manager = TaskManager();
  
  // Crear tareas
  manager.addTask(
    'Estudiar Dart',
    'Repasar POO y colecciones',
    Priority.high,
  );
  
  manager.addTask(
    'Hacer ejercicio',
    'Correr 30 minutos',
    Priority.medium,
  );
  
  manager.addTask(
    'Leer libro',
    'Terminar capítulo 5',
    Priority.low,
  );
  
  manager.addTask(
    'Proyecto Flutter',
    'Implementar pantalla de login',
    Priority.urgent,
  );
  
  manager.addTask(
    'Reunión equipo',
    'Daily standup a las 10am',
    Priority.high,
  );
  
  // Listar todas las tareas
  manager.listAllTasks();
  
  // Completar algunas tareas
  print('');
  manager.completeTask(1);  // Estudiar Dart
  manager.completeTask(5);  // Reunión equipo
  
  // Cancelar una tarea
  manager.cancelTask(3);    // Leer libro
  
  // Mostrar estadísticas
  manager.showStats();
  
  // Listar tareas pendientes
  manager.listPendingTasks();
  
  // Listar tareas completadas
  manager.listCompletedTasks();
  
  // Tareas de alta prioridad
  manager.listHighPriorityTasks();
  
  // Buscar tareas
  print('\n🔍 BÚSQUEDA: "Flutter"');
  print('═' * 43);
  var results = manager.searchTasks('Flutter');
  for (var task in results) {
    print('${task['title']}: ${task['description']}');
  }
}
```

---

## ✅ Checklist de Completación

- [ ] Enumeraciones definidas correctamente
- [ ] Clase `TaskHelper` con métodos estáticos
- [ ] Clase `TaskManager` gestiona lista de tareas
- [ ] Método `addTask()` crea tareas
- [ ] Métodos `completeTask()` y `cancelTask()` funcionan
- [ ] Filtrado por estado implementado
- [ ] Filtrado por prioridad implementado
- [ ] Estadísticas calculadas correctamente
- [ ] Búsqueda por palabra clave funciona
- [ ] Output muestra emojis y formato correcto

---

## 🚀 Desafíos Opcionales

1. **Editar tarea:**
   ```dart
   void editTask(int id, String newTitle, String newDescription) {
     var task = tasks.firstWhere((t) => t['id'] == id, orElse: () => {});
     if (task.isNotEmpty) {
       task['title'] = newTitle;
       task['description'] = newDescription;
       print('✓ Tarea actualizada');
     }
   }
   ```

2. **Tareas con fecha límite:**
   ```dart
   void addTask(String title, String description, Priority priority, {DateTime? dueDate}) {
     var task = {
       // ... campos existentes
       'dueDate': dueDate,
     };
     tasks.add(task);
   }
   
   void listOverdueTasks() {
     var now = DateTime.now();
     var overdue = tasks.where((t) => 
       t['dueDate'] != null && 
       (t['dueDate'] as DateTime).isBefore(now) &&
       t['status'] == TaskStatus.pending
     ).toList();
     
     print('⚠️ TAREAS VENCIDAS');
     for (var task in overdue) {
       _displayTask(task);
     }
   }
   ```

3. **Exportar a texto:**
   ```dart
   String exportToText() {
     var buffer = StringBuffer();
     buffer.writeln('REPORTE DE TAREAS');
     buffer.writeln('=' * 50);
     
     for (var task in tasks) {
       buffer.writeln('${task['title']}');
       buffer.writeln('  Estado: ${TaskHelper.getStatusText(task['status'])}');
       buffer.writeln('  Prioridad: ${TaskHelper.getPriorityText(task['priority'])}');
       buffer.writeln('');
     }
     
     return buffer.toString();
   }
   ```

4. **Filtros combinados:**
   ```dart
   List<Map<String, dynamic>> advancedFilter({
     TaskStatus? status,
     Priority? priority,
     String? keyword,
   }) {
     return tasks.where((task) {
       if (status != null && task['status'] != status) return false;
       if (priority != null && task['priority'] != priority) return false;
       if (keyword != null) {
         var title = (task['title'] as String).toLowerCase();
         if (!title.contains(keyword.toLowerCase())) return false;
       }
       return true;
     }).toList();
   }
   ```

---

## 📚 Recursos Adicionales

- [Dart Collections](https://dart.dev/guides/libraries/library-tour#collections)
- [List Methods](https://api.dart.dev/stable/dart-core/List-class.html)
- [Enumerations](https://dart.dev/guides/language/language-tour#enumerated-types)

---

**💡 Tip:** Este patrón de usar Maps para representar datos es muy común antes de introducir clases completas. En apps reales, usarías clases con fromJson/toJson.

**⏱️ Tiempo:** 45 minutos  
**🎯 Dificultad:** ⭐⭐ Media
