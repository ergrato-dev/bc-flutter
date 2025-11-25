# 🎯 Práctica 01: Tarjeta de Perfil de Usuario

> **Duración estimada:** 45-60 minutos  
> **Nivel:** Principiante  
> **Conceptos:** Container, Column, Row, Text, Image, Icon, Padding, SizedBox

---

## 📋 Objetivo

Crear una tarjeta de perfil de usuario que combine múltiples widgets básicos de Flutter, aplicando los conceptos del **Módulo 01: Widgets Fundamentales**.

---

## 🎨 Diseño a Implementar

```
┌─────────────────────────────────────────────┐
│                                             │
│              ┌─────────┐                    │
│              │  👤     │                    │
│              │  FOTO   │                    │
│              └─────────┘                    │
│                                             │
│            María García López               │
│            @mariagarcia                     │
│                                             │
│     Desarrolladora Flutter apasionada       │
│     por crear experiencias móviles          │
│     increíbles.                             │
│                                             │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐       │
│  │   125   │ │  1.2K   │ │   89    │       │
│  │  Posts  │ │Seguidores│ │Siguiendo│       │
│  └─────────┘ └─────────┘ └─────────┘       │
│                                             │
│  📍 Madrid, España                          │
│  🔗 github.com/mariagarcia                  │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │         Seguir                      │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │         Mensaje                     │   │
│  └─────────────────────────────────────┘   │
│                                             │
└─────────────────────────────────────────────┘
```

---

## 📝 Requisitos

### Funcionales

1. Mostrar avatar circular del usuario
2. Mostrar nombre y username
3. Mostrar biografía (máximo 3 líneas)
4. Mostrar estadísticas (posts, seguidores, siguiendo)
5. Mostrar ubicación y enlace
6. Botones de acción (Seguir, Mensaje)

### Técnicos

1. Usar `Container` con decoración y sombra
2. Usar `CircleAvatar` para la imagen
3. Usar `Column` y `Row` para el layout
4. Usar `Text` con diferentes estilos
5. Usar `Icon` para iconos
6. Usar `ElevatedButton` y `OutlinedButton`
7. Aplicar `Padding` y `SizedBox` para espaciado

---

## 🚀 Paso a Paso

### Paso 1: Crear la Estructura Base

```dart
/**
 * Paso 1: Scaffold con fondo y tarjeta centrada
 *
 * ¿Qué hacemos?
 * Creamos la estructura base con un Scaffold y centramos
 * nuestra tarjeta usando Center y SingleChildScrollView.
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjeta de Perfil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
      ),
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: ProfileCard(),
        ),
      ),
    );
  }
}

// Aquí crearemos nuestra tarjeta
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar en los siguientes pasos
    return const Placeholder(
      fallbackHeight: 400,
    );
  }
}
```

### Paso 2: Crear el Container Principal

```dart
/**
 * Paso 2: Container con decoración
 *
 * ¿Qué hacemos?
 * Creamos un Container decorado que servirá como
 * contenedor principal de toda la tarjeta.
 */

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ancho máximo para que no se estire demasiado
      constraints: const BoxConstraints(maxWidth: 400),

      // Decoración del contenedor
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      // Padding interno
      padding: const EdgeInsets.all(24),

      // Contenido (lo desarrollaremos)
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Contenido aquí'),
        ],
      ),
    );
  }
}
```

### Paso 3: Agregar el Avatar

```dart
/**
 * Paso 3: Avatar circular con borde
 *
 * ¿Qué hacemos?
 * Añadimos un CircleAvatar con imagen de red,
 * envuelto en un Container para el borde decorativo.
 */

// Dentro del Column, reemplazar el Text por:
child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    // Avatar con borde decorativo
    Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue,
          width: 3,
        ),
      ),
      child: const CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
          'https://i.pravatar.cc/200?img=5',
        ),
      ),
    ),

    const SizedBox(height: 16),

    // Nombre
    const Text(
      'María García López',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 4),

    // Username
    Text(
      '@mariagarcia',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      ),
    ),
  ],
),
```

### Paso 4: Agregar la Biografía

```dart
/**
 * Paso 4: Sección de biografía
 *
 * ¿Qué hacemos?
 * Añadimos un texto de biografía centrado con
 * un máximo de líneas y ellipsis.
 */

// Continuar agregando después del username:

const SizedBox(height: 16),

// Biografía
const Padding(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: Text(
    'Desarrolladora Flutter apasionada por crear experiencias móviles increíbles. Amante del código limpio y el buen café ☕',
    textAlign: TextAlign.center,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 14,
      height: 1.4,
    ),
  ),
),

const SizedBox(height: 20),
```

### Paso 5: Agregar las Estadísticas

```dart
/**
 * Paso 5: Sección de estadísticas
 *
 * ¿Qué hacemos?
 * Creamos una fila con tres columnas para mostrar
 * las estadísticas del perfil.
 */

// Widget reutilizable para estadísticas
Widget _buildStatItem(String value, String label) {
  return Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}

// En el Column principal, agregar:
Row(
  children: [
    _buildStatItem('125', 'Posts'),
    Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    ),
    _buildStatItem('1.2K', 'Seguidores'),
    Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    ),
    _buildStatItem('89', 'Siguiendo'),
  ],
),

const SizedBox(height: 20),
```

### Paso 6: Agregar Ubicación y Enlace

```dart
/**
 * Paso 6: Información adicional con iconos
 *
 * ¿Qué hacemos?
 * Añadimos filas con iconos para mostrar
 * la ubicación y el enlace del perfil.
 */

// Widget reutilizable para info con icono
Widget _buildInfoRow(IconData icon, String text, {Color? iconColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 16,
          color: iconColor ?? Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}

// Agregar al Column:
_buildInfoRow(Icons.location_on, 'Madrid, España'),
_buildInfoRow(
  Icons.link,
  'github.com/mariagarcia',
  iconColor: Colors.blue,
),

const SizedBox(height: 24),
```

### Paso 7: Agregar los Botones

```dart
/**
 * Paso 7: Botones de acción
 *
 * ¿Qué hacemos?
 * Añadimos dos botones: uno principal (Seguir)
 * y uno secundario (Mensaje).
 */

// Agregar al Column:

// Botón Seguir
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      // Acción de seguir
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Ahora sigues a María!'),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: const Text(
      'Seguir',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),

const SizedBox(height: 12),

// Botón Mensaje
SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    onPressed: () {
      // Acción de mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Abriendo chat...'),
        ),
      );
    },
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12),
      side: const BorderSide(color: Colors.blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: const Text(
      'Mensaje',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),
```

---

## ✅ Código Completo

```dart
/**
 * Práctica 01: Tarjeta de Perfil de Usuario
 *
 * Esta práctica demuestra el uso de:
 * - Container con decoración
 * - CircleAvatar para imágenes
 * - Column y Row para layouts
 * - Text con diferentes estilos
 * - Icon para iconografía
 * - ElevatedButton y OutlinedButton
 * - Padding y SizedBox para espaciado
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjeta de Perfil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
      ),
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: ProfileCard(),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
                width: 3,
              ),
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/200?img=5',
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Nombre
          const Text(
            'María García López',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          // Username
          Text(
            '@mariagarcia',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 16),

          // Biografía
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Desarrolladora Flutter apasionada por crear experiencias móviles increíbles. Amante del código limpio y el buen café ☕',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Estadísticas
          Row(
            children: [
              _buildStatItem('125', 'Posts'),
              _buildDivider(),
              _buildStatItem('1.2K', 'Seguidores'),
              _buildDivider(),
              _buildStatItem('89', 'Siguiendo'),
            ],
          ),

          const SizedBox(height: 20),

          // Ubicación y enlace
          _buildInfoRow(Icons.location_on, 'Madrid, España'),
          _buildInfoRow(
            Icons.link,
            'github.com/mariagarcia',
            iconColor: Colors.blue,
          ),

          const SizedBox(height: 24),

          // Botón Seguir
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Ahora sigues a María!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Seguir',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Botón Mensaje
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Abriendo chat...'),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Mensaje',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helpers
  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: iconColor ?? Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🏆 Desafíos Adicionales

### Desafío 1: Modo Oscuro

Implementa una versión con tema oscuro de la tarjeta.

### Desafío 2: Datos Dinámicos

Crea un modelo `UserProfile` y pasa los datos como parámetros al widget.

### Desafío 3: Animación

Añade una animación de "like" al presionar el botón Seguir.

### Desafío 4: Verificado

Añade un icono de verificación junto al nombre del usuario.

---

## 📚 Conceptos Aplicados

| Concepto            | Widget/Propiedad                   | Uso en la Práctica         |
| ------------------- | ---------------------------------- | -------------------------- |
| Contenedor decorado | `Container` + `BoxDecoration`      | Tarjeta con sombra         |
| Avatar circular     | `CircleAvatar`                     | Foto de perfil             |
| Layout vertical     | `Column`                           | Estructura principal       |
| Layout horizontal   | `Row`                              | Estadísticas               |
| Espaciado           | `SizedBox`, `Padding`              | Separación entre elementos |
| Texto estilizado    | `Text` + `TextStyle`               | Nombre, bio, stats         |
| Iconos              | `Icon`                             | Ubicación, enlace          |
| Botones             | `ElevatedButton`, `OutlinedButton` | Acciones                   |

---

## 🔗 Referencias

- [Módulo 01: Widgets Fundamentales](../1-teoria/01-widgets-fundamentales.md)
- [Documentación Container](https://api.flutter.dev/flutter/widgets/Container-class.html)
- [Documentación CircleAvatar](https://api.flutter.dev/flutter/material/CircleAvatar-class.html)

---

## ✅ Criterios de Evaluación

- [ ] La tarjeta tiene bordes redondeados y sombra
- [ ] El avatar es circular con borde decorativo
- [ ] El nombre y username están correctamente estilizados
- [ ] La biografía tiene límite de líneas
- [ ] Las estadísticas están en una fila con separadores
- [ ] Los iconos de información son visibles
- [ ] Ambos botones funcionan y muestran feedback
- [ ] El código está bien organizado y comentado
