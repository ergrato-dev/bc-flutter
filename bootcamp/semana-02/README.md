# 🎯 Semana 02: POO en Dart y Fundamentos de Flutter

> **Duración**: 8 horas de dedicación semanal  
> **Nivel**: 🟢 Básico-Intermedio  
> **Enfoque**: Programación Orientada a Objetos, Colecciones y Primera App Flutter

---

## 📋 Índice de Contenidos

1. [Objetivos de Aprendizaje](#-objetivos-de-aprendizaje)
2. [Estructura de la Semana](#-estructura-de-la-semana)
3. [Teoría (6 horas)](#-teoría)
4. [Prácticas (3.75 horas)](#-prácticas)
5. [Proyecto Integrador (3-4 horas)](#-proyecto-integrador)
6. [Recursos Complementarios](#-recursos-complementarios)
7. [Glosario Técnico](#-glosario-técnico)
8. [Evaluación](#-evaluación)

---

## 🎯 Objetivos de Aprendizaje

Al completar esta semana, serás capaz de:

- ✅ **POO**: Crear clases con herencia, mixins e interfaces en Dart
- ✅ **Colecciones**: Manipular List, Set y Map con operaciones avanzadas
- ✅ **Flutter**: Configurar entorno y crear tu primera aplicación
- ✅ **Widgets**: Entender y usar widgets básicos de Flutter
- ✅ **Estado**: Diferenciar StatelessWidget y StatefulWidget
- ✅ **Proyecto**: Integrar POO, colecciones y Flutter en una app completa

---

## 📂 Estructura de la Semana

```
semana-02/
├── 0-assets/              # 🎨 Diagramas y recursos visuales (6 SVGs)
├── 1-teoria/              # 📚 Módulos teóricos (6.5 horas)
│   ├── 01-poo-dart.md            (2 horas)
│   ├── 02-colecciones-estructuras.md (2 horas)
│   └── 03-intro-flutter.md       (2.5 horas)
├── 2-practicas/           # 💻 Ejercicios guiados (3.75 horas)
│   ├── practica-01-poo-biblioteca.md     (45 min)
│   ├── practica-02-colecciones-gestor-tareas.md (45 min)
│   ├── practica-03-mixins-habilidades.md (45 min)
│   ├── practica-04-flutter-hola-mundo.md (45 min)
│   └── practica-05-flutter-contador.md   (45 min)
├── 3-proyecto/            # 🔨 Proyecto integrador (3-4 horas)
│   ├── README.md                 (Guía completa)
│   ├── tasks_screen.dart         (Pantalla tareas)
│   ├── notes_screen.dart         (Pantalla notas)
│   └── contacts_screen.dart      (Pantalla contactos)
├── 4-recursos/            # 📖 Material complementario (12 recursos)
│   ├── 01-videos-poo.md
│   ├── 08-documentacion-oficial.md
│   └── README.md
└── 5-glosario/            # 📚 Términos técnicos (50+ definiciones)
    └── README.md
```

---

## 📚 Teoría

### 🎓 Módulos Teóricos (6.5 horas totales)

#### 📘 Módulo 1: POO en Dart (2 horas)
**Archivo**: [`1-teoria/01-poo-dart.md`](1-teoria/01-poo-dart.md)

**Contenido**:
- Clases y objetos
- Constructores (default, named, factory)
- Encapsulamiento (getters/setters)
- Herencia (`extends`, `super`)
- Clases abstractas e interfaces (`implements`)
- Mixins (`with`)
- Sobrescritura (`@override`)

**Recurso Visual**: ![Diagrama POO](0-assets/01-diagrama-poo.svg)

**Glosario Relacionado**: [abstract](#abstract), [class](#class), [constructor](#constructor), [extends](#extends), [mixin](#mixin), [@override](#override), [super](#super)

**Recursos Complementarios**:
- 📹 [Videos POO](4-recursos/01-videos-poo.md) - 9 videos curados (ES/EN)
- 📖 [Documentación Oficial Dart](4-recursos/08-documentacion-oficial.md#dart-language)

---

#### 📗 Módulo 2: Colecciones y Estructuras (2 horas)
**Archivo**: [`1-teoria/02-colecciones-estructuras.md`](1-teoria/02-colecciones-estructuras.md)

**Contenido**:
- **List**: Listas ordenadas con índices
  - Métodos: `add()`, `remove()`, `map()`, `where()`, `fold()`
- **Set**: Conjuntos sin duplicados
  - Operaciones: unión, intersección, diferencia
- **Map**: Pares clave-valor
  - Métodos: `putIfAbsent()`, `update()`, `forEach()`
- Iteración avanzada con `for-in`, `forEach()`, `map()`
- Operadores `..` (cascade) y `?.` (null-aware)

**Recurso Visual**: ![Diagrama Colecciones](0-assets/02-diagrama-colecciones.svg)

**Glosario Relacionado**: [List](#list), [Map](#map), [Set](#set), [dynamic](#dynamic), [null](#null)

**Recursos Complementarios**:
- 📹 [Videos Colecciones](4-recursos/02-videos-colecciones.md)
- 📖 [Documentación Dart Collections](4-recursos/08-documentacion-oficial.md#collections)

---

#### 📙 Módulo 3: Introducción a Flutter (2.5 horas)
**Archivo**: [`1-teoria/03-intro-flutter.md`](1-teoria/03-intro-flutter.md)

**Contenido**:
- Instalación de Flutter SDK
- Configuración de VS Code
- Estructura de proyecto Flutter
- Widgets fundamentales (`StatelessWidget`, `StatefulWidget`)
- Árbol de widgets
- Ciclo de vida de widgets
- Material Design en Flutter
- Hot Reload y Hot Restart

**Recursos Visuales**:
- ![Estructura Flutter](0-assets/03-estructura-flutter.svg)
- ![Widget Tree](0-assets/04-widget-tree.svg)
- ![Ciclo de Vida](0-assets/05-ciclo-vida-widget.svg)

**Glosario Relacionado**: [Flutter](#flutter), [Widget](#widget), [StatelessWidget](#statelesswidget), [StatefulWidget](#statefulwidget), [build()](#build), [setState()](#setstate), [MaterialApp](#materialapp), [Scaffold](#scaffold)

**Recursos Complementarios**:
- 📹 [Videos Flutter Intro](4-recursos/03-videos-flutter-intro.md)
- 📖 [Documentación Oficial Flutter](4-recursos/08-documentacion-oficial.md#flutter)
- 🔧 [Herramientas Desarrollo](4-recursos/09-herramientas-desarrollo.md)

---

## 💻 Prácticas

### 🛠️ Ejercicios Prácticos (3.75 horas totales)

| # | Práctica | Dificultad | Tiempo | Conceptos |
|---|----------|------------|--------|-----------|
| 1 | [Sistema de Biblioteca](2-practicas/practica-01-poo-biblioteca.md) | 🟢 Básico | 45 min | POO, herencia, polimorfismo |
| 2 | [Gestor de Tareas](2-practicas/practica-02-colecciones-gestor-tareas.md) | 🟡 Intermedio | 45 min | List, Map, métodos colecciones |
| 3 | [Sistema de Habilidades](2-practicas/practica-03-mixins-habilidades.md) | 🟡 Intermedio | 45 min | Mixins, interfaces, composición |
| 4 | [Hola Mundo Flutter](2-practicas/practica-04-flutter-hola-mundo.md) | 🟢 Básico | 45 min | StatelessWidget, Material |
| 5 | [Contador Flutter](2-practicas/practica-05-flutter-contador.md) | 🟢 Básico | 45 min | StatefulWidget, setState() |

**Metodología**:
1. Lee el enunciado completo
2. Intenta resolver sin ver la solución (30 min)
3. Compara con la solución propuesta
4. Experimenta con variaciones
5. Documenta tus aprendizajes

---

## 🔨 Proyecto Integrador

### 📱 Agenda Personal Digital

**Archivo Guía**: [`3-proyecto/README.md`](3-proyecto/README.md)

**Descripción**: Aplicación Flutter completa que integra POO, colecciones y widgets para gestionar:
- ✅ **Tareas** con prioridades y fechas
- 📝 **Notas** con categorías y favoritos
- 👤 **Contactos** con agenda alfabética

**Arquitectura**:
```
lib/
├── models/
│   ├── task.dart          # Modelo Task con enums
│   ├── note.dart          # Modelo Note con categorías
│   └── contact.dart       # Modelo Contact
├── services/
│   ├── task_manager.dart  # Lógica de tareas
│   ├── note_manager.dart  # Lógica de notas
│   └── contact_manager.dart # Lógica de contactos
└── screens/
    ├── home_screen.dart        # Pantalla principal
    ├── tasks_screen.dart       # 🔗 Gestión de tareas
    ├── notes_screen.dart       # 🔗 Gestión de notas
    └── contacts_screen.dart    # 🔗 Gestión de contactos
```

**Pantallas Implementadas**:
1. [`tasks_screen.dart`](3-proyecto/tasks_screen.dart) - CRUD tareas con filtros y búsqueda
2. [`notes_screen.dart`](3-proyecto/notes_screen.dart) - Notas con grid y categorías
3. [`contacts_screen.dart`](3-proyecto/contacts_screen.dart) - Agenda alfabética

**Tiempo Estimado**: 3-4 horas

**Conceptos Aplicados**:
- POO: Modelos con constructores y métodos
- Colecciones: List/Map para gestión de datos
- Flutter: StatefulWidget, navegación, formularios
- Estado: setState() para actualización UI

**Recursos de Apoyo**:
- 📖 [Guías de Diseño](3-proyecto/GUIA-DISENO.md)
- 📊 [Ejemplos de Datos](3-proyecto/EJEMPLOS-DATOS.md)
- 📹 [Videos Flutter Widgets](4-recursos/03-videos-flutter-intro.md)

---

## 📖 Recursos Complementarios

### 📚 Biblioteca de Recursos (12 items numerados)

**Índice Completo**: [`4-recursos/README.md`](4-recursos/README.md)

#### 🎥 Videografía (01-03)
- 📹 **[01 - Videos POO](4-recursos/01-videos-poo.md)** - 9 videos curados (Fernando Herrera, The Net Ninja)
- 📹 **[02 - Videos Colecciones](4-recursos/02-videos-colecciones.md)** - Listas, mapas y operaciones
- 📹 **[03 - Videos Flutter Intro](4-recursos/03-videos-flutter-intro.md)** - Primeros pasos en Flutter

#### 📚 eBooks (04-05)
- 📖 **[04 - eBooks Dart Avanzado](4-recursos/04-ebooks-dart-avanzado.md)** - Libros gratuitos Dart
- 📖 **[05 - eBooks Flutter](4-recursos/05-ebooks-flutter.md)** - Recursos Flutter completos

#### 🌐 Webgrafía (06-08)
- 🔗 **[06 - Artículos POO](4-recursos/06-articulos-poo.md)** - Blog posts y tutoriales
- 🔗 **[07 - Artículos Flutter](4-recursos/07-articulos-flutter.md)** - Guías y patrones
- 📖 **[08 - Documentación Oficial](4-recursos/08-documentacion-oficial.md)** - dart.dev, flutter.dev, pub.dev

#### 🔧 Herramientas (09-10)
- 🛠️ **[09 - Herramientas Desarrollo](4-recursos/09-herramientas-desarrollo.md)** - IDEs, extensiones, DevTools
- 🎮 **[10 - Playgrounds Online](4-recursos/10-playgrounds-online.md)** - DartPad, Zapp.run

#### 👥 Comunidades (11-12)
- 💬 **[11 - Comunidades](4-recursos/11-comunidades.md)** - Discord, Reddit, Stack Overflow
- 📺 **[12 - Canales YouTube](4-recursos/12-canales-youtube.md)** - Creadores de contenido Flutter

**Cómo Usar los Recursos**:
1. Prioriza según tu estilo de aprendizaje (🎥 visual, 📖 lectura, 💻 práctica)
2. Combina recursos (ej: video + artículo + práctica)
3. Usa 🟢🟡🔴 para filtrar por nivel
4. Dedica 30 min diarios a recursos complementarios

---

## 📚 Glosario Técnico

### 🔍 Diccionario de Términos (50+ definiciones)

**Acceso Completo**: [`5-glosario/README.md`](5-glosario/README.md)

**Categorías**:
- **POO** (15 términos): abstract, class, constructor, extends, factory, getter, implements, mixin, Object, @override, private, setter, super, this, with
- **Collections** (3 términos): List, Map, Set
- **Flutter** (20 términos): AppBar, build(), BuildContext, Column, Container, Flutter, Hot Reload, immutable, main(), Material, MaterialApp, Navigator, Row, runApp(), Scaffold, setState(), State, StatefulWidget, StatelessWidget, Widget
- **Dart** (12 términos): async/await, const, Dart, dynamic, enum, final, Future, late, null, package, var, void

**Ejemplo de Entrada**:
```markdown
### `StatefulWidget`

**Definición**: Widget que mantiene estado mutable y puede reconstruirse cuando cambia.

**Sintaxis**:
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int counter = 0;
  
  @override
  Widget build(BuildContext context) {
    return Text('$counter');
  }
}

**Casos de Uso**: Contadores, formularios, animaciones, cualquier UI que cambie.

**Ver También**: [StatelessWidget](#statelesswidget), [setState()](#setstate), [State](#state)
```

**Cómo Navegar**:
- Usa Ctrl+F para buscar términos
- Sigue los enlaces [Ver También]
- Prioriza términos marcados como 🔴 Alta prioridad

---

## 🎨 Assets Visuales

### 📊 Diagramas y Recursos Gráficos

**Catálogo Completo**: [`0-assets/README.md`](0-assets/README.md)

| ID | Asset | Dimensiones | Uso |
|----|-------|-------------|-----|
| 01 | [Diagrama POO](0-assets/01-diagrama-poo.svg) | 800x600 | Herencia, mixins, clases abstractas |
| 02 | [Diagrama Colecciones](0-assets/02-diagrama-colecciones.svg) | 850x650 | List, Set, Map con operaciones |
| 03 | [Estructura Flutter](0-assets/03-estructura-flutter.svg) | 900x700 | Arquitectura en capas |
| 04 | [Widget Tree](0-assets/04-widget-tree.svg) | 700x800 | Árbol de widgets ejemplo |
| 05 | [Ciclo de Vida](0-assets/05-ciclo-vida-widget.svg) | 800x900 | Lifecycle StatefulWidget |
| 06 | [Navegación Flutter](0-assets/06-navegacion-flutter.svg) | 800x600 | Push/pop stack |

**Características**:
- 🎨 Tema oscuro (#1e1e1e)
- 🎨 Paleta de colores consistente
- 📱 Optimizados para markdown y web
- 🔗 Referenciados en teoría y prácticas

---

## ✅ Checklist de Completitud

### 📝 Progreso Semanal

**Teoría** (6.5 horas):
- [ ] Módulo 1: POO en Dart (2 horas)
- [ ] Módulo 2: Colecciones (2 horas)
- [ ] Módulo 3: Flutter Intro (2.5 horas)

**Prácticas** (3.75 horas):
- [ ] Práctica 01: Biblioteca POO (45 min)
- [ ] Práctica 02: Gestor Tareas (45 min)
- [ ] Práctica 03: Mixins Habilidades (45 min)
- [ ] Práctica 04: Hola Mundo Flutter (45 min)
- [ ] Práctica 05: Contador Flutter (45 min)

**Proyecto** (3-4 horas):
- [ ] Modelos creados (Task, Note, Contact)
- [ ] Services implementados (3 managers)
- [ ] Pantalla Home funcional
- [ ] Pantalla Tasks con CRUD
- [ ] Pantalla Notes con grid
- [ ] Pantalla Contacts alfabética
- [ ] Navegación entre pantallas
- [ ] Testing manual completo

**Recursos**:
- [ ] He revisado al menos 3 videos (01-03)
- [ ] He consultado documentación oficial (08)
- [ ] He explorado herramientas DevTools (09)
- [ ] He usado el glosario como referencia (5-glosario/)

---

## 🎓 Evaluación

### 📊 Criterios de Evaluación (100 puntos)

- Definición de clases
- Constructores (default, nombrados, factory)
- Propiedades y métodos
- `this` keyword
- Getters y setters

#### Herencia

- Extensión de clases
- `super` keyword
- Override de métodos
- Clases abstractas

#### Encapsulamiento

- Modificadores de acceso (private `_`)
- Propiedades privadas

#### Otros Conceptos

- Interfaces
- Mixins
- Enumeraciones

### 2. Colecciones y Estructuras de Datos (2 horas)

#### Listas (List)

```dart
List<int> numeros = [1, 2, 3];
List<String> nombres = ['Ana', 'Luis'];
```

#### Conjuntos (Set)

```dart
Set<String> frutas = {'manzana', 'pera'};
```

#### Mapas (Map)

```dart
Map<String, int> edades = {'Ana': 25, 'Luis': 30};
```

#### Métodos de Colecciones

- `map()`, `where()`, `reduce()`
- `forEach()`, `any()`, `every()`
- `sort()`, `reversed`

### 3. Introducción a Flutter (3 horas)

#### ¿Qué es Flutter?

- Framework UI de Google
- Desarrollo multiplataforma
- Arquitectura de Flutter
- Widget tree

#### Instalación y Configuración

- Instalación de Flutter SDK
- Configuración de Android Studio/VS Code
- Flutter Doctor
- Creación de emuladores

#### Estructura de un Proyecto Flutter

```
mi_app/
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
├── pubspec.yaml
└── README.md
```

#### Hot Reload y Hot Restart

- Diferencias
- Casos de uso
- Atajos de teclado

## 💻 Ejercicios Prácticos

### Ejercicio 1: POO - Sistema de Biblioteca

Crea clases para modelar:

- Clase `Libro` (título, autor, ISBN, disponible)
- Clase `Usuario` (nombre, ID, libros prestados)
- Clase `Biblioteca` (catálogo, usuarios)
- Métodos: prestar libro, devolver libro, buscar libro

### Ejercicio 2: Colecciones - Gestor de Tareas

Implementa un gestor de tareas usando:

- Lista de tareas
- Métodos: agregar, eliminar, marcar completada
- Filtrar tareas completadas/pendientes
- Contar tareas por estado

### Ejercicio 3: Mixins - Animal Kingdom

Crea una jerarquía de animales usando mixins:

```dart
mixin Nadador {
  void nadar() => print('Nadando');
}

mixin Volador {
  void volar() => print('Volando');
}

class Pato extends Animal with Nadador, Volador {}
```

### Ejercicio 4: Primera App Flutter

Crea tu primera aplicación Flutter:

- App "Hola Mundo"
- Personaliza el título
- Cambia colores del tema
- Agrega un botón que muestre un mensaje

### Ejercicio 5: Contador Flutter

Modifica la app de contador por defecto:

- Agrega botón de decremento
- Agrega botón de reset
- Cambia el diseño y colores
- Muestra un mensaje cuando llegue a 10

## 🔨 Proyecto de la Semana

**App de Perfil Personal**

Desarrolla una aplicación Flutter que muestre tu perfil profesional:

**Características:**

1. Pantalla principal con tu información:
   - Foto de perfil (usar `CircleAvatar`)
   - Nombre completo
   - Título profesional
   - Descripción breve
2. Tarjetas de información:
   - Habilidades técnicas
   - Proyectos realizados
   - Información de contacto
3. Diseño atractivo con:
   - Colores personalizados
   - Iconos relevantes
   - Layout responsivo

**Requisitos técnicos:**

- Usar `StatelessWidget`
- Implementar estructura de clases en Dart
- Código organizado y comentado
- Usar widgets: `Scaffold`, `AppBar`, `Column`, `Row`, `Card`, `Icon`, `Text`

**Estructura de código:**

```dart
// Crear modelo de datos
class Perfil {
  final String nombre;
  final String titulo;
  final List<String> habilidades;
  // ... otros campos
}

// Widget principal
class PerfilApp extends StatelessWidget {
  // ...
}
```

## 📖 Recursos

### Documentación

- [Dart OOP](https://dart.dev/guides/language/language-tour#classes)
- [Flutter Documentation](https://flutter.dev/docs)
- [Widget Catalog](https://flutter.dev/docs/development/ui/widgets)

### Videos

- [Flutter Curso Completo](https://www.youtube.com/watch?v=BQts64CuCvk)
- [Dart OOP Tutorial](https://www.youtube.com/watch?v=AqD97w_ofVw)

### Herramientas

- [DartPad](https://dartpad.dev/)
- [Flutter Install](https://flutter.dev/docs/get-started/install)
- [VS Code Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

## ✅ Checklist de Completitud

- [ ] Flutter SDK instalado correctamente
- [ ] Emulador Android/iOS configurado
- [ ] Ejercicio 1: Sistema de biblioteca completado
- [ ] Ejercicio 2: Gestor de tareas completado
- [ ] Ejercicio 3: Mixins completado
- [ ] Ejercicio 4: Hola Mundo Flutter completado
- [ ] Ejercicio 5: Contador modificado completado
- [ ] Proyecto: App de perfil completado
- [ ] App ejecutada en emulador/dispositivo
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios Dart (1-3):** 30%
- **Ejercicios Flutter (4-5):** 20%
- **Proyecto de la semana:** 40%
- **Configuración de entorno:** 10%

## 📝 Notas Importantes

- Ejecutar `flutter doctor` para verificar la instalación
- Mantener el SDK de Flutter actualizado
- Practicar hot reload para agilizar desarrollo
- Explorar el Widget Inspector en DevTools
- Leer mensajes de error cuidadosamente

## 🔧 Comandos Flutter Útiles

```bash
# Crear nuevo proyecto
flutter create nombre_proyecto

# Ejecutar aplicación
flutter run

# Ver dispositivos disponibles
flutter devices

# Limpiar build
flutter clean

# Obtener paquetes
flutter pub get
```

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 1](../semana-01/README.md) | **Siguiente:** [Semana 3 →](../semana-03/README.md)
