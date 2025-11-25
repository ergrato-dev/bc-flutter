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

## 📚 Contenido Teórico

### 1. Programación Orientada a Objetos en Dart (3 horas)

#### Clases y Objetos

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
