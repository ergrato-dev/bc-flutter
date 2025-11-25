# 🔨 Proyecto Integrador: TravelApp

## 📋 Información General

| Campo               | Valor                   |
| ------------------- | ----------------------- |
| **Semana**          | 04 - Navegación y Rutas |
| **Dificultad**      | ⭐⭐⭐ Avanzado         |
| **Tiempo estimado** | 3-4 horas               |
| **Evaluación**      | 50% de la nota semanal  |

---

## 🎯 Descripción del Proyecto

Desarrollarás **TravelApp**, una aplicación de viajes completa que combina todos los patrones de navegación aprendidos:

- **Navegación básica** con Navigator
- **Rutas nombradas** centralizadas
- **Paso de datos** entre pantallas
- **Bottom Navigation** con múltiples tabs
- **Drawer** para menú lateral
- **Navegación anidada** en cada sección

---

## 🏗️ Arquitectura de Navegación

```
TravelApp/
├── SplashScreen (inicial)
├── OnboardingScreen (primera vez)
├── AuthFlow/
│   ├── LoginScreen
│   └── RegisterScreen
└── MainScreen (home)/
    ├── Drawer Menu
    │   ├── Mi Cuenta
    │   ├── Mis Viajes
    │   ├── Favoritos
    │   ├── Configuración
    │   └── Cerrar Sesión
    └── BottomNavigation/
        ├── Tab: Explorar
        │   ├── DestinationListScreen
        │   ├── DestinationDetailScreen
        │   └── BookingScreen
        ├── Tab: Buscar
        │   ├── SearchScreen
        │   └── SearchResultsScreen
        ├── Tab: Reservas
        │   ├── BookingsListScreen
        │   └── BookingDetailScreen
        └── Tab: Perfil
            ├── ProfileScreen
            └── EditProfileScreen
```

---

## 📱 Pantallas Requeridas

### 1. Flujo de Autenticación

| Pantalla           | Descripción               |
| ------------------ | ------------------------- |
| `SplashScreen`     | Logo y carga inicial      |
| `OnboardingScreen` | 3 páginas de introducción |
| `LoginScreen`      | Formulario de login       |
| `RegisterScreen`   | Formulario de registro    |

### 2. Pantalla Principal

| Pantalla     | Descripción                       |
| ------------ | --------------------------------- |
| `MainScreen` | Contenedor con Drawer y BottomNav |

### 3. Tab Explorar

| Pantalla                  | Descripción                  |
| ------------------------- | ---------------------------- |
| `ExploreTab`              | Lista de destinos destacados |
| `DestinationDetailScreen` | Detalle del destino          |
| `BookingScreen`           | Formulario de reserva        |

### 4. Tab Buscar

| Pantalla              | Descripción          |
| --------------------- | -------------------- |
| `SearchTab`           | Búsqueda con filtros |
| `SearchResultsScreen` | Resultados filtrados |

### 5. Tab Reservas

| Pantalla              | Descripción        |
| --------------------- | ------------------ |
| `BookingsTab`         | Lista de reservas  |
| `BookingDetailScreen` | Detalle de reserva |

### 6. Tab Perfil

| Pantalla            | Descripción             |
| ------------------- | ----------------------- |
| `ProfileTab`        | Información del usuario |
| `EditProfileScreen` | Editar datos            |

---

## 📦 Modelos de Datos

```dart
// Modelo: Destino
class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final String description;
  final double price;
  final double rating;
  final List<String> highlights;

  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.highlights,
  });
}

// Modelo: Reserva
class Booking {
  final String id;
  final Destination destination;
  final DateTime startDate;
  final DateTime endDate;
  final int travelers;
  final double totalPrice;
  final BookingStatus status;

  const Booking({
    required this.id,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.travelers,
    required this.totalPrice,
    required this.status,
  });
}

enum BookingStatus { pending, confirmed, completed, cancelled }

// Modelo: Usuario
class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final List<String> favoriteDestinations;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.favoriteDestinations = const [],
  });
}
```

---

## 🛣️ Configuración de Rutas

```dart
// lib/config/app_routes.dart

class AppRoutes {
  AppRoutes._();

  // Auth Flow
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';

  // Main Flow
  static const String main = '/main';
  static const String destinationDetail = '/destination';
  static const String booking = '/booking';
  static const String bookingDetail = '/booking-detail';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String favorites = '/favorites';
  static const String myTrips = '/my-trips';
}
```

---

## ✅ Requisitos Funcionales

### Navegación Básica

- [ ] Transiciones fluidas entre pantallas
- [ ] Botón back funcional en todas las pantallas
- [ ] Paso de datos con argumentos
- [ ] Retorno de datos al pop

### Rutas Nombradas

- [ ] Todas las rutas definidas en `AppRoutes`
- [ ] `onGenerateRoute` para rutas con argumentos
- [ ] `onUnknownRoute` para rutas no encontradas

### Bottom Navigation

- [ ] 4 tabs funcionando correctamente
- [ ] Estado preservado con `IndexedStack`
- [ ] Badge en tab de reservas (si hay pendientes)

### Drawer

- [ ] Header con info del usuario
- [ ] Navegación a secciones secundarias
- [ ] Opción de cerrar sesión con confirmación

### Navegación Anidada

- [ ] Cada tab con su propio Navigator
- [ ] Back button maneja navegación interna primero
- [ ] Double tap en tab vuelve al inicio

---

## 📁 Estructura de Archivos

```
lib/
├── main.dart
├── app.dart
├── config/
│   ├── app_routes.dart
│   └── app_theme.dart
├── models/
│   ├── destination.dart
│   ├── booking.dart
│   └── user.dart
├── data/
│   └── mock_data.dart
├── screens/
│   ├── auth/
│   │   ├── splash_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── main/
│   │   ├── main_screen.dart
│   │   └── app_drawer.dart
│   ├── explore/
│   │   ├── explore_tab.dart
│   │   └── destination_detail_screen.dart
│   ├── search/
│   │   ├── search_tab.dart
│   │   └── search_results_screen.dart
│   ├── bookings/
│   │   ├── bookings_tab.dart
│   │   ├── booking_screen.dart
│   │   └── booking_detail_screen.dart
│   └── profile/
│       ├── profile_tab.dart
│       └── edit_profile_screen.dart
└── widgets/
    ├── destination_card.dart
    ├── booking_card.dart
    └── custom_bottom_nav.dart
```

---

## 🎨 Diseño Visual

### Paleta de Colores

| Color      | Código    | Uso                       |
| ---------- | --------- | ------------------------- |
| Primary    | `#2196F3` | Botones, AppBar, acciones |
| Secondary  | `#FF9800` | Precios, destacados       |
| Background | `#F5F5F5` | Fondo general             |
| Surface    | `#FFFFFF` | Cards, contenedores       |
| Error      | `#F44336` | Errores, cancelaciones    |

### Tipografía

- **Títulos**: Poppins Bold
- **Subtítulos**: Poppins SemiBold
- **Cuerpo**: Roboto Regular
- **Precios**: Roboto Bold

---

## 📊 Criterios de Evaluación

| Criterio                | Puntos |
| ----------------------- | ------ |
| **Navegación Básica**   | 10     |
| Transiciones correctas  | 3      |
| Paso de datos           | 4      |
| Retorno de datos        | 3      |
| **Rutas Nombradas**     | 10     |
| AppRoutes completo      | 4      |
| onGenerateRoute         | 3      |
| onUnknownRoute          | 3      |
| **Bottom Navigation**   | 10     |
| 4 tabs funcionales      | 4      |
| Estado preservado       | 3      |
| Badges                  | 3      |
| **Drawer**              | 10     |
| Header usuario          | 3      |
| Navegación lateral      | 4      |
| Logout con confirmación | 3      |
| **Navegación Anidada**  | 10     |
| Navigator por tab       | 4      |
| Back button correcto    | 3      |
| Double tap reset        | 3      |
| **TOTAL**               | **50** |

---

## 📖 Recursos de Apoyo

- [GUIA-DISENO.md](./GUIA-DISENO.md) - Guía visual detallada
- [EJEMPLOS-DATOS.md](./EJEMPLOS-DATOS.md) - Datos de prueba
- Módulos teóricos de la semana
- Prácticas 01-05 como referencia

---

## 🚀 Entrega

### Formato

- Repositorio Git con commits descriptivos
- README con instrucciones de ejecución
- Screenshots de las pantallas principales

### Fecha Límite

- Domingo de la semana 04, 23:59 hrs

### Bonus (hasta +5 puntos)

- Animaciones de transición personalizadas (+2)
- Deep linking implementado (+2)
- Tests de navegación (+1)

---

## 💡 Consejos

1. **Empieza por las rutas**: Define `AppRoutes` primero
2. **Estructura modular**: Separa bien las carpetas
3. **Prueba constantemente**: Verifica navegación en cada paso
4. **Maneja errores**: Implementa pantalla 404
5. **Documenta**: Comenta decisiones de diseño
