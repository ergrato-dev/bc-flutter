# 🎨 Guía de Diseño de UI - Consola

Esta guía te ayudará a crear una **interfaz de consola atractiva y profesional** para tu sistema de gestión de tareas.

---

## 🌈 Elementos Visuales para Consola

### Emojis Recomendados

Los emojis hacen que la interfaz sea más amigable y visual:

#### Estados de Tareas

```
✅ - Tarea completada
❌ - Tarea pendiente
⏰ - Fecha/tiempo
📝 - Descripción/nota
🔥 - Alta prioridad
📌 - Media prioridad
💤 - Baja prioridad
```

#### Categorías

```
💼 - Trabajo (Work)
🏠 - Personal
📚 - Estudio (Study)
```

#### Acciones del Menú

```
📋 - Ver/Listar
➕ - Agregar/Crear
🗑️  - Eliminar
🔍 - Buscar
📊 - Estadísticas
🏷️  - Filtrar/Categorías
🚪 - Salir
✏️  - Editar
```

#### Mensajes del Sistema

```
✅ - Éxito
❌ - Error
⚠️  - Advertencia
💡 - Información/Tip
📭 - Vacío/Sin datos
```

---

## 📏 Estructuras de Bordes

### Opción 1: Bordes Dobles (Elegante)

```
╔═══════════════════════════════════════╗
║   TÍTULO PRINCIPAL                   ║
╚═══════════════════════════════════════╝
```

```dart
void showHeader() {
  print('\n' + '╔' + '═' * 48 + '╗');
  print('║   📝 SISTEMA DE GESTIÓN DE TAREAS            ║');
  print('╚' + '═' * 48 + '╝');
}
```

### Opción 2: Bordes Simples (Clásico)

```
┌───────────────────────────────────────┐
│   TÍTULO PRINCIPAL                   │
└───────────────────────────────────────┘
```

```dart
void showHeader() {
  print('\n' + '┌' + '─' * 48 + '┐');
  print('│   📝 SISTEMA DE GESTIÓN DE TAREAS            │');
  print('└' + '─' * 48 + '┘');
}
```

### Opción 3: Bordes ASCII (Compatible)

```
+---------------------------------------+
|   TÍTULO PRINCIPAL                   |
+---------------------------------------+
```

```dart
void showHeader() {
  print('\n' + '+' + '-' * 48 + '+');
  print('|   📝 SISTEMA DE GESTIÓN DE TAREAS            |');
  print('+' + '-' * 48 + '+');
}
```

### Opción 4: Separadores Simples (Minimalista)

```
========================================
   TÍTULO PRINCIPAL
========================================
```

```dart
void showHeader() {
  print('\n' + '=' * 50);
  print('   📝 SISTEMA DE GESTIÓN DE TAREAS');
  print('=' * 50);
}
```

---

## 🎯 Diseños de Menú

### Diseño 1: Con Números y Emojis

```
===== MENÚ PRINCIPAL =====
1. 📋 Ver todas las tareas
2. ➕ Agregar nueva tarea
3. ✅ Marcar como completada
4. 🗑️  Eliminar tarea
5. 🔍 Buscar tareas
6. 📊 Ver estadísticas
0. 🚪 Salir
==========================
```

### Diseño 2: Con Bordes y Espaciado

```
┌──────────────────────────┐
│    MENÚ PRINCIPAL       │
├──────────────────────────┤
│ [1] 📋 Ver tareas       │
│ [2] ➕ Nueva tarea      │
│ [3] ✅ Completar        │
│ [4] 🗑️  Eliminar        │
│ [5] 🔍 Buscar           │
│ [6] 📊 Estadísticas     │
│ [0] 🚪 Salir            │
└──────────────────────────┘
```

### Diseño 3: Compacto y Limpio

```
━━━━━━━━━━━━━━━━━━━━━━━━━
    MENÚ PRINCIPAL
━━━━━━━━━━━━━━━━━━━━━━━━━
1📋 Ver  2➕ Nuevo  3✅ OK
4🗑️ Del  5🔍 Buscar 6📊 Stats
0🚪 Salir
━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 📋 Formatos de Listado de Tareas

### Formato 1: Detallado con Bordes

```
╔═══════════════════════════════════════╗
║        LISTA DE TAREAS               ║
╚═══════════════════════════════════════╝

┌─────────────────────────────────────┐
│ [1] ❌ Completar proyecto Dart     │
│     💼 Trabajo | 🔥 Alta           │
│     ⏰ 2025-11-30                   │
│     📝 Sistema de gestión...       │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ [2] ✅ Hacer ejercicio             │
│     🏠 Personal | 💤 Baja          │
│     ⏰ 2025-11-25                   │
│     📝 Rutina 30 minutos           │
└─────────────────────────────────────┘
```

### Formato 2: Compacto con Separadores

```
===== LISTA DE TAREAS =====

🔥 ALTA PRIORIDAD:
  [1] ❌ Completar proyecto Dart
      💼 Trabajo | ⏰ 2025-11-30

📌 MEDIA PRIORIDAD:
  [2] ❌ Estudiar colecciones
      📚 Estudio | ⏰ 2025-11-26

💤 BAJA PRIORIDAD:
  [3] ✅ Hacer ejercicio
      🏠 Personal | ⏰ 2025-11-25

──────────────────────────
Total: 3 | ✅ 1 | ❌ 2
```

### Formato 3: Tabla Compacta

```
ID │ ✓ │ Título               │ Cat │ Pri │ Fecha
───┼───┼──────────────────────┼─────┼─────┼──────────
 1 │ ❌ │ Proyecto Dart       │ 💼  │ 🔥  │ 11-30
 2 │ ❌ │ Estudiar Dart       │ 📚  │ 📌  │ 11-26
 3 │ ✅ │ Ejercicio           │ 🏠  │ 💤  │ 11-25
```

---

## 📊 Diseños de Estadísticas

### Diseño 1: Bloques Visuales

```
╔════════════════════════════════════╗
║         ESTADÍSTICAS              ║
╚════════════════════════════════════╝

┌─────────────────────┐
│  📊 RESUMEN        │
├─────────────────────┤
│  Total:        10  │
│  ✅ Hechas:     6  │
│  ❌ Pendientes: 4  │
│                     │
│  Completitud: 60%  │
└─────────────────────┘

┌─────────────────────┐
│  📂 CATEGORÍAS     │
├─────────────────────┤
│  💼 Trabajo:    4  │
│  🏠 Personal:   3  │
│  📚 Estudio:    3  │
└─────────────────────┘

┌─────────────────────┐
│  🔥 PRIORIDADES    │
├─────────────────────┤
│  Alta:          2  │
│  Media:         5  │
│  Baja:          3  │
└─────────────────────┘
```

### Diseño 2: Barras de Progreso ASCII

```
===== ESTADÍSTICAS =====

📊 Completitud:
✅ [████████████────────] 60% (6/10)

📂 Por Categoría:
💼 Trabajo:   [████████────] 40% (4)
🏠 Personal:  [██████──────] 30% (3)
📚 Estudio:   [██████──────] 30% (3)

🔥 Por Prioridad:
Alta:   [████────────] 20% (2)
Media:  [██████████──] 50% (5)
Baja:   [██████──────] 30% (3)
```

### Diseño 3: Compacto con Emojis

```
═══════════════════════════
    📊 ESTADÍSTICAS
═══════════════════════════

Total: 10 tareas
✅ 6 (60%) | ❌ 4 (40%)

Categorías:
💼 4  🏠 3  📚 3

Prioridades:
🔥 2  📌 5  💤 3
═══════════════════════════
```

---

## 🎨 Paleta de Colores (Opcional)

Si quieres usar colores ANSI en tu consola:

### Códigos de Color ANSI

```dart
class Colors {
  // Colores de texto
  static const reset = '\x1B[0m';
  static const black = '\x1B[30m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
  static const white = '\x1B[37m';

  // Colores de fondo
  static const bgRed = '\x1B[41m';
  static const bgGreen = '\x1B[42m';
  static const bgYellow = '\x1B[43m';
  static const bgBlue = '\x1B[44m';

  // Estilos
  static const bold = '\x1B[1m';
  static const dim = '\x1B[2m';
  static const italic = '\x1B[3m';
  static const underline = '\x1B[4m';
}

// Uso
void printSuccess(String message) {
  print('${Colors.green}✅ $message${Colors.reset}');
}

void printError(String message) {
  print('${Colors.red}❌ $message${Colors.reset}');
}

void printTitle(String title) {
  print('${Colors.bold}${Colors.cyan}$title${Colors.reset}');
}
```

### Aplicación de Colores

```dart
// Prioridades con colores
String getPriorityWithColor(Priority priority) {
  switch (priority) {
    case Priority.High:
      return '${Colors.red}🔥 Alta${Colors.reset}';
    case Priority.Medium:
      return '${Colors.yellow}📌 Media${Colors.reset}';
    case Priority.Low:
      return '${Colors.green}💤 Baja${Colors.reset}';
  }
}

// Estados con colores
String getStatusWithColor(bool isCompleted) {
  if (isCompleted) {
    return '${Colors.green}✅ Completada${Colors.reset}';
  } else {
    return '${Colors.red}❌ Pendiente${Colors.reset}';
  }
}
```

---

## 💡 Mejores Prácticas de UI en Consola

### 1. Consistencia

- Usa el mismo estilo de bordes en toda la app
- Mantén el espaciado uniforme
- Usa los mismos emojis para las mismas acciones

### 2. Legibilidad

- Deja líneas en blanco entre secciones
- No sobrecargues con información
- Alinea texto cuando sea posible

### 3. Feedback Claro

```dart
// ✅ Bueno - Feedback inmediato
print('✅ Tarea "$title" agregada exitosamente');

// ❌ Malo - Sin feedback
// (nada)
```

### 4. Manejo de Errores Amigable

```dart
// ✅ Bueno - Error descriptivo
print('❌ Error: No existe tarea con ID $id');
print('💡 Tip: Usa la opción 1 para ver todas las tareas');

// ❌ Malo - Error técnico
print('Error: null pointer exception');
```

### 5. Navegación Clara

```dart
// ✅ Bueno - Usuario sabe qué hacer
print('\nPresiona Enter para volver al menú...');
stdin.readLineSync();

// ❌ Malo - Usuario confundido
// (vuelve al menú sin avisar)
```

---

## 📐 Ejemplos de Layouts Completos

### Layout 1: Profesional con Bordes

```
╔═══════════════════════════════════════════╗
║   📝 SISTEMA DE GESTIÓN DE TAREAS       ║
╚═══════════════════════════════════════════╝

┌───────────────────────────────────────────┐
│           MENÚ PRINCIPAL                 │
├───────────────────────────────────────────┤
│  [1] 📋 Ver todas las tareas             │
│  [2] ➕ Agregar nueva tarea              │
│  [3] ✅ Marcar como completada           │
│  [4] 🗑️  Eliminar tarea                  │
│  [5] 🔍 Buscar tareas                    │
│  [6] 📊 Ver estadísticas                 │
│  [7] 🏷️  Filtrar por categoría           │
│  [8] 🔥 Ver por prioridad                │
│  [0] 🚪 Salir                            │
└───────────────────────────────────────────┘

Opción: _
```

### Layout 2: Minimalista

```
═════════════════════════════════════
   📝 GESTOR DE TAREAS
═════════════════════════════════════

MENÚ
────────────────────────────────────
1. 📋 Ver todas
2. ➕ Nueva
3. ✅ Completar
4. 🗑️  Eliminar
5. 🔍 Buscar
6. 📊 Stats
0. 🚪 Salir
────────────────────────────────────
›
```

### Layout 3: Moderno con Espacios

```


    📝  SISTEMA DE TAREAS



    ───────────────────────────
         MENÚ PRINCIPAL
    ───────────────────────────

    1  📋  Ver todas las tareas
    2  ➕  Agregar nueva tarea
    3  ✅  Marcar completada
    4  🗑️   Eliminar tarea
    5  🔍  Buscar tareas
    6  📊  Estadísticas
    0  🚪  Salir

    ───────────────────────────

    →
```

---

## 🎯 Checklist de UI

- [ ] Header claro y visible
- [ ] Menú bien organizado con números/opciones
- [ ] Emojis consistentes para cada acción
- [ ] Mensajes de éxito/error claros
- [ ] Separadores visuales entre secciones
- [ ] Feedback inmediato después de cada acción
- [ ] Instrucciones claras para el usuario
- [ ] Espaciado adecuado (no muy denso ni muy espaciado)
- [ ] Formato consistente en toda la aplicación

---

## 💡 Tips Finales

1. **Menos es más**: No sobrecargues con decoraciones
2. **Prueba en diferentes terminales**: Verifica que se vea bien
3. **Usa espaciado estratégico**: Las líneas en blanco guían la vista
4. **Feedback constante**: El usuario siempre debe saber qué pasó
5. **Emojis con moderación**: Mejoran pero no abuses

---

**🎨 Recuerda**: Una buena UI en consola es **clara**, **consistente** y **funcional**. No necesitas ser elaborado, solo efectivo.

---

_Guía de diseño para proyectos CLI en Dart_
