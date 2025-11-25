# 📊 Datos de Ejemplo - TravelApp

## 📁 Archivo de Mock Data

Crea `lib/data/mock_data.dart`:

```dart
import '../models/destination.dart';
import '../models/booking.dart';
import '../models/user.dart';

/// Datos de prueba para la aplicación
///
/// ¿Qué hace? Proporciona datos estáticos para desarrollo
/// ¿Para qué? Evitar dependencia de API durante desarrollo
/// ¿Cómo? Listas de objetos predefinidos
class MockData {
  MockData._();

  // =====================================================
  // DESTINOS
  // =====================================================

  static final List<Destination> destinations = [
    const Destination(
      id: 'dest_001',
      name: 'París',
      country: 'Francia',
      imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      description:
        'La Ciudad de la Luz te espera con su incomparable mezcla de '
        'arte, historia, gastronomía y romance. Desde la icónica Torre '
        'Eiffel hasta los encantadores cafés de Montmartre, París ofrece '
        'una experiencia única que cautiva a millones de visitantes cada año.',
      price: 1200.0,
      rating: 4.8,
      highlights: [
        'Torre Eiffel',
        'Museo del Louvre',
        'Champs-Élysées',
        'Notre-Dame',
        'Montmartre',
      ],
    ),
    const Destination(
      id: 'dest_002',
      name: 'Tokio',
      country: 'Japón',
      imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
      description:
        'Una metrópolis donde lo ultramoderno se encuentra con las '
        'tradiciones ancestrales. Tokio te sorprenderá con sus rascacielos '
        'futuristas, templos serenos, tecnología de vanguardia y una '
        'cultura pop vibrante. La gastronomía local es un viaje en sí misma.',
      price: 1500.0,
      rating: 4.9,
      highlights: [
        'Templo Senso-ji',
        'Shibuya Crossing',
        'Monte Fuji',
        'Akihabara',
        'Jardines del Palacio Imperial',
      ],
    ),
    const Destination(
      id: 'dest_003',
      name: 'Cancún',
      country: 'México',
      imageUrl: 'https://images.unsplash.com/photo-1552074284-5e88ef1aef18',
      description:
        'Playas de arena blanca y aguas cristalinas del Caribe mexicano. '
        'Cancún combina resort de lujo con rica herencia maya. Explora '
        'las ruinas de Tulum, bucea en cenotes sagrados o simplemente '
        'relájate bajo el sol tropical.',
      price: 800.0,
      rating: 4.6,
      highlights: [
        'Zona Hotelera',
        'Ruinas de Tulum',
        'Isla Mujeres',
        'Cenotes',
        'Chichén Itzá',
      ],
    ),
    const Destination(
      id: 'dest_004',
      name: 'Roma',
      country: 'Italia',
      imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
      description:
        'La Ciudad Eterna donde cada calle cuenta una historia de más '
        'de 2,000 años. Desde el majestuoso Coliseo hasta los frescos '
        'de la Capilla Sixtina, Roma es un museo al aire libre que '
        'te transportará en el tiempo.',
      price: 1100.0,
      rating: 4.7,
      highlights: [
        'Coliseo Romano',
        'Vaticano',
        'Fontana di Trevi',
        'Panteón',
        'Piazza Navona',
      ],
    ),
    const Destination(
      id: 'dest_005',
      name: 'Nueva York',
      country: 'Estados Unidos',
      imageUrl: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
      description:
        'La ciudad que nunca duerme te ofrece una energía incomparable. '
        'Desde los espectáculos de Broadway hasta los museos de clase '
        'mundial, pasando por Central Park y la Estatua de la Libertad, '
        'NYC es el epítome de la aventura urbana.',
      price: 1400.0,
      rating: 4.8,
      highlights: [
        'Times Square',
        'Central Park',
        'Estatua de la Libertad',
        'Empire State',
        'Brooklyn Bridge',
      ],
    ),
    const Destination(
      id: 'dest_006',
      name: 'Bali',
      country: 'Indonesia',
      imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
      description:
        'La Isla de los Dioses te recibe con templos antiguos, arrozales '
        'en terrazas y playas paradisíacas. Bali es el destino perfecto '
        'para quien busca espiritualidad, naturaleza y relax en un '
        'entorno tropical espectacular.',
      price: 900.0,
      rating: 4.7,
      highlights: [
        'Templo Tanah Lot',
        'Ubud',
        'Terrazas de Arroz Tegallalang',
        'Seminyak Beach',
        'Mount Batur',
      ],
    ),
    const Destination(
      id: 'dest_007',
      name: 'Barcelona',
      country: 'España',
      imageUrl: 'https://images.unsplash.com/photo-1583422409516-2895a77efded',
      description:
        'Capital del modernismo y la creatividad mediterránea. Barcelona '
        'combina las obras maestras de Gaudí con playas urbanas, tapas '
        'deliciosas y una vida nocturna vibrante. La Rambla te espera '
        'con su bullicio característico.',
      price: 950.0,
      rating: 4.6,
      highlights: [
        'La Sagrada Familia',
        'Park Güell',
        'La Rambla',
        'Barrio Gótico',
        'Playa Barceloneta',
      ],
    ),
    const Destination(
      id: 'dest_008',
      name: 'Dubái',
      country: 'Emiratos Árabes',
      imageUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
      description:
        'La ciudad del futuro donde los sueños se hacen realidad. Dubái '
        'ostenta los récords mundiales en arquitectura, lujo y '
        'entretenimiento. Desde el Burj Khalifa hasta el desierto dorado, '
        'cada experiencia es extraordinaria.',
      price: 1800.0,
      rating: 4.5,
      highlights: [
        'Burj Khalifa',
        'Palm Jumeirah',
        'Dubai Mall',
        'Desert Safari',
        'Burj Al Arab',
      ],
    ),
  ];

  // =====================================================
  // CATEGORÍAS
  // =====================================================

  static final List<Map<String, dynamic>> categories = [
    {'id': 'cat_01', 'name': 'Playas', 'icon': 'beach_access', 'emoji': '🏖️'},
    {'id': 'cat_02', 'name': 'Montañas', 'icon': 'terrain', 'emoji': '⛰️'},
    {'id': 'cat_03', 'name': 'Ciudades', 'icon': 'location_city', 'emoji': '🏙️'},
    {'id': 'cat_04', 'name': 'Aventura', 'icon': 'hiking', 'emoji': '🧗'},
    {'id': 'cat_05', 'name': 'Cultural', 'icon': 'museum', 'emoji': '🏛️'},
    {'id': 'cat_06', 'name': 'Romántico', 'icon': 'favorite', 'emoji': '💕'},
  ];

  // =====================================================
  // RESERVAS
  // =====================================================

  static final List<Booking> bookings = [
    Booking(
      id: 'book_001',
      destination: destinations[0], // París
      startDate: DateTime(2024, 12, 15),
      endDate: DateTime(2024, 12, 22),
      travelers: 2,
      totalPrice: 2640.0,
      status: BookingStatus.confirmed,
    ),
    Booking(
      id: 'book_002',
      destination: destinations[2], // Cancún
      startDate: DateTime(2025, 1, 10),
      endDate: DateTime(2025, 1, 17),
      travelers: 4,
      totalPrice: 3520.0,
      status: BookingStatus.pending,
    ),
    Booking(
      id: 'book_003',
      destination: destinations[5], // Bali
      startDate: DateTime(2024, 10, 5),
      endDate: DateTime(2024, 10, 15),
      travelers: 2,
      totalPrice: 1980.0,
      status: BookingStatus.completed,
    ),
    Booking(
      id: 'book_004',
      destination: destinations[3], // Roma
      startDate: DateTime(2024, 9, 1),
      endDate: DateTime(2024, 9, 5),
      travelers: 1,
      totalPrice: 1100.0,
      status: BookingStatus.cancelled,
    ),
  ];

  // =====================================================
  // USUARIO
  // =====================================================

  static const User currentUser = User(
    id: 'user_001',
    name: 'Juan Pérez',
    email: 'juan.perez@email.com',
    avatarUrl: 'https://i.pravatar.cc/150?u=juan',
    favoriteDestinations: ['dest_001', 'dest_002', 'dest_005'],
  );

  // =====================================================
  // ONBOARDING
  // =====================================================

  static final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Descubre el mundo',
      'description': 'Explora destinos increíbles en todo el planeta. '
          'Desde playas paradisíacas hasta ciudades históricas.',
      'image': 'assets/images/onboarding_1.png',
    },
    {
      'title': 'Planifica tu viaje',
      'description': 'Reserva vuelos, hoteles y actividades en un solo lugar. '
          'Todo lo que necesitas para tu aventura.',
      'image': 'assets/images/onboarding_2.png',
    },
    {
      'title': 'Vive la aventura',
      'description': 'Disfruta de experiencias únicas sin preocupaciones. '
          'Estamos contigo en cada paso del viaje.',
      'image': 'assets/images/onboarding_3.png',
    },
  ];

  // =====================================================
  // DRAWER MENU ITEMS
  // =====================================================

  static final List<Map<String, dynamic>> drawerItems = [
    {'icon': 'person', 'title': 'Mi Cuenta', 'route': '/account'},
    {'icon': 'flight', 'title': 'Mis Viajes', 'route': '/my-trips'},
    {'icon': 'favorite', 'title': 'Favoritos', 'route': '/favorites'},
    {'icon': 'settings', 'title': 'Configuración', 'route': '/settings'},
    {'icon': 'help', 'title': 'Ayuda', 'route': '/help'},
  ];

  // =====================================================
  // REVIEWS
  // =====================================================

  static final List<Map<String, dynamic>> reviews = [
    {
      'id': 'rev_001',
      'destinationId': 'dest_001',
      'userName': 'María García',
      'rating': 5,
      'comment': '¡Increíble experiencia! París superó todas mis expectativas.',
      'date': '2024-10-15',
    },
    {
      'id': 'rev_002',
      'destinationId': 'dest_001',
      'userName': 'Carlos López',
      'rating': 4,
      'comment': 'Muy bonito, aunque algo caro. Vale la pena visitarlo.',
      'date': '2024-10-10',
    },
    {
      'id': 'rev_003',
      'destinationId': 'dest_002',
      'userName': 'Ana Martínez',
      'rating': 5,
      'comment': 'Tokio es fascinante. La cultura y la comida son increíbles.',
      'date': '2024-09-28',
    },
  ];

  // =====================================================
  // NOTIFICACIONES
  // =====================================================

  static final List<Map<String, dynamic>> notifications = [
    {
      'id': 'notif_001',
      'type': 'booking',
      'title': 'Reserva confirmada',
      'message': 'Tu viaje a París ha sido confirmado.',
      'date': '2024-11-01',
      'read': false,
    },
    {
      'id': 'notif_002',
      'type': 'promo',
      'title': '¡Oferta especial!',
      'message': '30% de descuento en destinos del Caribe.',
      'date': '2024-10-28',
      'read': true,
    },
    {
      'id': 'notif_003',
      'type': 'reminder',
      'title': 'Próximo viaje',
      'message': 'Tu viaje a París comienza en 2 semanas.',
      'date': '2024-10-25',
      'read': false,
    },
  ];

  // =====================================================
  // MÉTODOS HELPER
  // =====================================================

  /// Obtener destino por ID
  static Destination? getDestinationById(String id) {
    try {
      return destinations.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Obtener reservas por estado
  static List<Booking> getBookingsByStatus(BookingStatus status) {
    return bookings.where((b) => b.status == status).toList();
  }

  /// Obtener destinos favoritos del usuario
  static List<Destination> getFavoriteDestinations() {
    return destinations
        .where((d) => currentUser.favoriteDestinations.contains(d.id))
        .toList();
  }

  /// Buscar destinos
  static List<Destination> searchDestinations(String query) {
    final lowerQuery = query.toLowerCase();
    return destinations.where((d) {
      return d.name.toLowerCase().contains(lowerQuery) ||
          d.country.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Obtener destinos por categoría (simulado)
  static List<Destination> getDestinationsByCategory(String categoryId) {
    // En una app real, cada destino tendría categorías
    // Aquí devolvemos destinos aleatorios como ejemplo
    switch (categoryId) {
      case 'cat_01': // Playas
        return [destinations[2], destinations[5]]; // Cancún, Bali
      case 'cat_03': // Ciudades
        return [destinations[0], destinations[1], destinations[4]]; // París, Tokio, NYC
      case 'cat_05': // Cultural
        return [destinations[3], destinations[6]]; // Roma, Barcelona
      default:
        return destinations;
    }
  }
}
```

---

## 📝 Modelos de Datos

### Destination Model

```dart
// lib/models/destination.dart

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

  // Factory constructor para JSON (si usas API)
  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      highlights: List<String>.from(json['highlights']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'rating': rating,
      'highlights': highlights,
    };
  }
}
```

### Booking Model

```dart
// lib/models/booking.dart

import 'destination.dart';

enum BookingStatus { pending, confirmed, completed, cancelled }

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

  // Calcular número de noches
  int get nights => endDate.difference(startDate).inDays;

  // Obtener color según estado
  String get statusLabel {
    switch (status) {
      case BookingStatus.pending:
        return 'Pendiente';
      case BookingStatus.confirmed:
        return 'Confirmada';
      case BookingStatus.completed:
        return 'Completada';
      case BookingStatus.cancelled:
        return 'Cancelada';
    }
  }
}
```

### User Model

```dart
// lib/models/user.dart

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

  // Obtener iniciales para avatar
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}
```

---

## 🖼️ Imágenes Placeholder

Si no quieres depender de URLs externas, puedes usar estos servicios:

| Servicio     | URL                                                 | Descripción      |
| ------------ | --------------------------------------------------- | ---------------- |
| Unsplash     | `https://source.unsplash.com/800x600/?travel,paris` | Imágenes reales  |
| Lorem Picsum | `https://picsum.photos/800/600`                     | Fotos aleatorias |
| Placeholder  | `https://via.placeholder.com/800x600`               | Color sólido     |

### URLs de ejemplo por destino

```dart
static const Map<String, String> placeholderImages = {
  'paris': 'https://source.unsplash.com/800x600/?paris,eiffel',
  'tokyo': 'https://source.unsplash.com/800x600/?tokyo,japan',
  'cancun': 'https://source.unsplash.com/800x600/?cancun,beach',
  'rome': 'https://source.unsplash.com/800x600/?rome,colosseum',
  'newyork': 'https://source.unsplash.com/800x600/?newyork,manhattan',
  'bali': 'https://source.unsplash.com/800x600/?bali,temple',
  'barcelona': 'https://source.unsplash.com/800x600/?barcelona,gaudi',
  'dubai': 'https://source.unsplash.com/800x600/?dubai,burj',
};
```

---

## 📊 Estadísticas para Dashboard

```dart
static final Map<String, dynamic> dashboardStats = {
  'totalTrips': 12,
  'countriesVisited': 8,
  'upcomingTrips': 2,
  'savedDestinations': 15,
  'totalSpent': 8500.0,
  'memberSince': '2023',
};
```
