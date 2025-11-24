# Semana 2: Introducción a Dart II y Fundamentos de Flutter

## 🎯 Objetivos de Aprendizaje

- Dominar la programación orientada a objetos en Dart
- Comprender las colecciones y estructuras de datos
- Configurar el entorno de desarrollo Flutter
- Crear la primera aplicación Flutter
- Entender la estructura de un proyecto Flutter

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
