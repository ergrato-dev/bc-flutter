# 💡 Ejemplos de Tareas para Tu Proyecto

Este archivo contiene ejemplos de tareas que puedes agregar para probar tu sistema. **Personaliza las tareas** según tus intereses y necesidades.

---

## 📝 Ejemplo 1: Estudiante de Programación

```dart
// Tareas de Estudio
manager.addTask(
  title: 'Completar curso de Dart',
  description: 'Terminar módulos 5-8 del curso en línea',
  category: Category.Study,
  priority: Priority.High,
  dueDate: DateTime(2025, 12, 1),
);

manager.addTask(
  title: 'Repasar POO en Dart',
  description: 'Clases, herencia, interfaces y mixins',
  category: Category.Study,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 11, 28),
);

manager.addTask(
  title: 'Practicar colecciones',
  description: 'Ejercicios de List, Set y Map del bootcamp',
  category: Category.Study,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 11, 27),
);

manager.addTask(
  title: 'Leer documentación de Flutter',
  description: 'Preparación para la Semana 2 del bootcamp',
  category: Category.Study,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 3),
);

// Tareas de Trabajo (Proyectos)
manager.addTask(
  title: 'Completar proyecto de Dart',
  description: 'Sistema de gestión de tareas para el bootcamp',
  category: Category.Work,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 30),
);

manager.addTask(
  title: 'Code review del proyecto anterior',
  description: 'Revisar y refactorizar código de la práctica 3',
  category: Category.Work,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 11, 26),
);

// Tareas Personales
manager.addTask(
  title: 'Actualizar portfolio',
  description: 'Agregar proyectos recientes de Dart',
  category: Category.Personal,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 5),
);

manager.addTask(
  title: 'Hacer ejercicio',
  description: 'Rutina de 30 minutos de cardio',
  category: Category.Personal,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 11, 25),
);
```

---

## 💼 Ejemplo 2: Desarrollador en Empresa

```dart
// Tareas de Trabajo
manager.addTask(
  title: 'Fix bug en módulo de autenticación',
  description: 'Usuarios no pueden recuperar contraseña - Issue #342',
  category: Category.Work,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 26),
);

manager.addTask(
  title: 'Implementar feature de notificaciones',
  description: 'Push notifications para eventos importantes',
  category: Category.Work,
  priority: Priority.High,
  dueDate: DateTime(2025, 12, 2),
);

manager.addTask(
  title: 'Code review PR #156',
  description: 'Revisar cambios en módulo de pagos',
  category: Category.Work,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 11, 27),
);

manager.addTask(
  title: 'Actualizar dependencias del proyecto',
  description: 'Migrar a últimas versiones estables',
  category: Category.Work,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 10),
);

manager.addTask(
  title: 'Documentar API REST',
  description: 'Swagger docs para nuevos endpoints',
  category: Category.Work,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 11, 29),
);

// Tareas de Estudio (Mejora profesional)
manager.addTask(
  title: 'Aprender Flutter animations',
  description: 'Ver curso de animaciones avanzadas',
  category: Category.Study,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 15),
);

manager.addTask(
  title: 'Certificación AWS',
  description: 'Estudiar para examen de Cloud Practitioner',
  category: Category.Study,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 12, 20),
);

// Tareas Personales
manager.addTask(
  title: 'Preparar presentación para meetup',
  description: 'Charla sobre Dart null safety',
  category: Category.Personal,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 28),
);
```

---

## 🎓 Ejemplo 3: Balance Vida-Trabajo-Estudio

```dart
// Tareas de Alta Prioridad
manager.addTask(
  title: 'Entregar proyecto final bootcamp',
  description: 'Sistema de tareas completamente funcional',
  category: Category.Study,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 30),
);

manager.addTask(
  title: 'Presentación para cliente',
  description: 'Demo de nueva funcionalidad del proyecto',
  category: Category.Work,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 27),
);

manager.addTask(
  title: 'Cita médica',
  description: 'Chequeo médico general programado',
  category: Category.Personal,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 26),
);

// Tareas de Media Prioridad
manager.addTask(
  title: 'Refactorizar módulo de reportes',
  description: 'Mejorar performance y legibilidad del código',
  category: Category.Work,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 12, 5),
);

manager.addTask(
  title: 'Estudiar Firebase para Flutter',
  description: 'Authentication, Firestore y Cloud Functions',
  category: Category.Study,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 12, 8),
);

manager.addTask(
  title: 'Organizar cumpleaños familiar',
  description: 'Reservar restaurante y coordinar invitados',
  category: Category.Personal,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 12, 3),
);

// Tareas de Baja Prioridad
manager.addTask(
  title: 'Limpiar código legacy',
  description: 'Eliminar funciones deprecadas del proyecto',
  category: Category.Work,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 15),
);

manager.addTask(
  title: 'Ver tutoriales de UI/UX',
  description: 'Mejorar habilidades de diseño de interfaces',
  category: Category.Study,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 20),
);

manager.addTask(
  title: 'Leer libro pendiente',
  description: 'Terminar "Clean Code" de Robert Martin',
  category: Category.Personal,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 25),
);

manager.addTask(
  title: 'Ordenar escritorio de trabajo',
  description: 'Organizar cables y optimizar espacio',
  category: Category.Personal,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 10),
);
```

---

## 🎯 Tareas Específicas por Categoría

### 💼 Trabajo

```dart
// Desarrollo
'Implementar login con biometría'
'Optimizar queries de base de datos'
'Crear tests unitarios para módulo X'
'Configurar CI/CD pipeline'
'Migrar proyecto a null safety'

// Reuniones y Coordinación
'Daily standup con el equipo'
'Planning meeting sprint 12'
'1-on-1 con manager'
'Demo para stakeholders'

// Documentación
'Actualizar README del proyecto'
'Escribir guía de deployment'
'Documentar arquitectura del sistema'
```

### 📚 Estudio

```dart
// Bootcamp/Cursos
'Ver módulo 3 de Flutter avanzado'
'Hacer ejercicios de async/await'
'Completar quiz de Dart Collections'
'Proyecto final de curso'

// Lectura
'Leer capítulo 5 de "Effective Dart"'
'Artículo sobre state management'
'Documentación oficial de Flutter'

// Práctica
'Resolver 5 ejercicios de LeetCode'
'Crear mini-proyecto de práctica'
'Contribuir a proyecto open source'
```

### 🏠 Personal

```dart
// Salud
'Hacer ejercicio 30 minutos'
'Cita con el dentista'
'Comprar medicamentos'
'Dormir 8 horas'

// Hogar
'Pagar servicios del mes'
'Comprar despensa semanal'
'Reparar ventana de la cocina'
'Limpiar y organizar habitación'

// Social
'Llamar a mamá'
'Cumpleaños de amigo'
'Planear salida fin de semana'
'Responder mensajes pendientes'

// Finanzas
'Revisar gastos del mes'
'Actualizar presupuesto'
'Pagar tarjeta de crédito'
```

---

## 📅 Ejemplo de Distribución Temporal

### Esta Semana (Prioridad Alta)

```dart
// Lunes
manager.addTask(
  title: 'Planning meeting',
  description: 'Definir tareas del sprint',
  category: Category.Work,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 25),
);

// Miércoles
manager.addTask(
  title: 'Entregar proyecto Dart',
  description: 'Sistema de gestión de tareas',
  category: Category.Study,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 27),
);

// Viernes
manager.addTask(
  title: 'Code review viernes',
  description: 'Revisar PRs pendientes del equipo',
  category: Category.Work,
  priority: Priority.High,
  dueDate: DateTime(2025, 11, 29),
);
```

### Próxima Semana (Prioridad Media)

```dart
manager.addTask(
  title: 'Iniciar Semana 2 Flutter',
  description: 'Primer proyecto Flutter del bootcamp',
  category: Category.Study,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 12, 2),
);

manager.addTask(
  title: 'Implementar nueva feature',
  description: 'Dashboard de estadísticas',
  category: Category.Work,
  priority: Priority.Medium,
  dueDate: DateTime(2025, 12, 5),
);
```

### Mes Próximo (Prioridad Baja)

```dart
manager.addTask(
  title: 'Refactoring general',
  description: 'Mejorar arquitectura del proyecto',
  category: Category.Work,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 20),
);

manager.addTask(
  title: 'Aprender GraphQL',
  description: 'Curso completo de GraphQL con Flutter',
  category: Category.Study,
  priority: Priority.Low,
  dueDate: DateTime(2025, 12, 30),
);
```

---

## 💡 Tips para Crear Buenas Tareas

### ✅ Características de una Buena Tarea:

1. **Título claro y conciso** - Resume la acción en 3-7 palabras
2. **Descripción específica** - Detalles suficientes para saber qué hacer
3. **Categoría adecuada** - Work, Personal o Study según corresponda
4. **Prioridad realista** - No todo puede ser Alta prioridad
5. **Fecha alcanzable** - Considera tu tiempo disponible

### ❌ Evita:

- Títulos vagos: "Hacer cosas" → ✅ "Implementar login OAuth"
- Sin descripción: Solo título → ✅ Siempre agrega contexto
- Tareas enormes: "Terminar proyecto" → ✅ Divide en subtareas
- Fechas irreales: Todo para mañana → ✅ Distribuye en el tiempo

---

## 🎨 Personalización

Recuerda que estas son **solo ejemplos**. Tu sistema debe reflejar:

- Tus proyectos actuales
- Tus metas de aprendizaje
- Tus responsabilidades personales
- Tu estilo de organización

**¡Haz que el sistema sea tuyo!** 🚀

---

## 📊 Sugerencia de Distribución

Para un balance saludable, intenta mantener:

- **40% Trabajo** - Proyectos y responsabilidades laborales
- **30% Estudio** - Aprendizaje continuo y mejora
- **30% Personal** - Salud, familia, hobbies

Ajusta según tu situación personal actual.

---

**💡 Tip Final:** Empieza con 5-10 tareas reales que tengas que hacer esta semana. No llenes el sistema con tareas inventadas solo por llenar.
