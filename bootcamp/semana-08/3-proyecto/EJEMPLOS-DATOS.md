# 📦 Ejemplos de Datos - TravelDiary

## 📋 Índice

1. [Modelos Completos](#-modelos-completos)
2. [Datos de Ejemplo](#-datos-de-ejemplo)
3. [Mocks para Testing](#-mocks-para-testing)
4. [Configuración de Firebase](#-configuración-de-firebase)

---

## 📦 Modelos Completos

### DiaryEntry Model

```dart
/**
 * DiaryEntry
 * 
 * Modelo principal que representa una entrada del diario.
 * Incluye métodos de serialización para SQLite y JSON.
 */

import 'dart:convert';

class DiaryEntry {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final Location? location;
  final List<Photo> photos;
  final String? tripId;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const DiaryEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.location,
    this.photos = const [],
    this.tripId,
    required this.createdAt,
    required this.updatedAt,
  });
  
  /// Crea una entrada vacía con valores por defecto
  factory DiaryEntry.empty() {
    final now = DateTime.now();
    return DiaryEntry(
      id: '',
      title: '',
      description: '',
      date: now,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  /// Crea una copia con los campos modificados
  DiaryEntry copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    Location? location,
    List<Photo>? photos,
    String? tripId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      location: location ?? this.location,
      photos: photos ?? this.photos,
      tripId: tripId ?? this.tripId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  /// Serializa a mapa para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location?.toJson(),
      'photos': jsonEncode(photos.map((p) => p.toMap()).toList()),
      'tripId': tripId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  /// Deserializa desde mapa de SQLite
  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
      location: map['location'] != null 
          ? Location.fromJson(map['location'] as String)
          : null,
      photos: (jsonDecode(map['photos'] as String) as List)
          .map((p) => Photo.fromMap(p as Map<String, dynamic>))
          .toList(),
      tripId: map['tripId'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
  
  /// Serializa a JSON
  String toJson() => jsonEncode(toMap());
  
  /// Deserializa desde JSON
  factory DiaryEntry.fromJson(String source) =>
      DiaryEntry.fromMap(jsonDecode(source) as Map<String, dynamic>);
  
  @override
  String toString() {
    return 'DiaryEntry(id: $id, title: $title, date: $date)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiaryEntry && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}
```

### Photo Model

```dart
/**
 * Photo
 * 
 * Modelo que representa una foto asociada a una entrada.
 */

class Photo {
  final String id;
  final String localPath;
  final DateTime takenAt;
  final Location? location;
  
  const Photo({
    required this.id,
    required this.localPath,
    required this.takenAt,
    this.location,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'localPath': localPath,
      'takenAt': takenAt.toIso8601String(),
      'location': location?.toJson(),
    };
  }
  
  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'] as String,
      localPath: map['localPath'] as String,
      takenAt: DateTime.parse(map['takenAt'] as String),
      location: map['location'] != null
          ? Location.fromJson(map['location'] as String)
          : null,
    );
  }
  
  Photo copyWith({
    String? id,
    String? localPath,
    DateTime? takenAt,
    Location? location,
  }) {
    return Photo(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      takenAt: takenAt ?? this.takenAt,
      location: location ?? this.location,
    );
  }
}
```

### Location Model

```dart
/**
 * Location
 * 
 * Modelo que representa una ubicación geográfica.
 */

import 'dart:convert';

class Location {
  final double latitude;
  final double longitude;
  final String? placeName;
  final String? address;
  final double? altitude;
  
  const Location({
    required this.latitude,
    required this.longitude,
    this.placeName,
    this.address,
    this.altitude,
  });
  
  /// Ubicación por defecto (Madrid, España)
  factory Location.defaultLocation() {
    return const Location(
      latitude: 40.4168,
      longitude: -3.7038,
      placeName: 'Madrid',
      address: 'Madrid, España',
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'placeName': placeName,
      'address': address,
      'altitude': altitude,
    };
  }
  
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      placeName: map['placeName'] as String?,
      address: map['address'] as String?,
      altitude: (map['altitude'] as num?)?.toDouble(),
    );
  }
  
  String toJson() => jsonEncode(toMap());
  
  factory Location.fromJson(String source) =>
      Location.fromMap(jsonDecode(source) as Map<String, dynamic>);
  
  /// Calcula la distancia a otra ubicación (en metros)
  double distanceTo(Location other) {
    // Fórmula de Haversine simplificada
    const double earthRadius = 6371000; // metros
    final lat1 = latitude * 3.14159 / 180;
    final lat2 = other.latitude * 3.14159 / 180;
    final dLat = (other.latitude - latitude) * 3.14159 / 180;
    final dLon = (other.longitude - longitude) * 3.14159 / 180;
    
    final a = (dLat / 2).sin() * (dLat / 2).sin() +
        lat1.cos() * lat2.cos() * (dLon / 2).sin() * (dLon / 2).sin();
    final c = 2 * a.sqrt().asin();
    
    return earthRadius * c;
  }
  
  @override
  String toString() {
    return placeName ?? '$latitude, $longitude';
  }
}

// Extensión para sin/cos/asin/sqrt
extension on double {
  double sin() => import('dart:math').sin(this);
  double cos() => import('dart:math').cos(this);
  double asin() => import('dart:math').asin(this);
  double sqrt() => import('dart:math').sqrt(this);
}
```

### Trip Model

```dart
/**
 * Trip
 * 
 * Modelo que agrupa varias entradas en un viaje.
 */

class Trip {
  final String id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final String? coverPhotoPath;
  final List<String> entryIds;
  final DateTime createdAt;
  
  const Trip({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    this.endDate,
    this.coverPhotoPath,
    this.entryIds = const [],
    required this.createdAt,
  });
  
  /// Duración del viaje en días
  int get durationDays {
    final end = endDate ?? DateTime.now();
    return end.difference(startDate).inDays + 1;
  }
  
  /// Verifica si el viaje está en curso
  bool get isOngoing => endDate == null;
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'coverPhotoPath': coverPhotoPath,
      'entryIds': entryIds.join(','),
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: map['endDate'] != null 
          ? DateTime.parse(map['endDate'] as String)
          : null,
      coverPhotoPath: map['coverPhotoPath'] as String?,
      entryIds: (map['entryIds'] as String).split(','),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
  
  Trip copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? coverPhotoPath,
    List<String>? entryIds,
    DateTime? createdAt,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      coverPhotoPath: coverPhotoPath ?? this.coverPhotoPath,
      entryIds: entryIds ?? this.entryIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
```

---

## 📝 Datos de Ejemplo

### Entradas de Ejemplo

```dart
/**
 * Datos de ejemplo para desarrollo y testing.
 * Simula un viaje por España con varias entradas.
 */

class MockData {
  static List<DiaryEntry> get sampleEntries => [
    DiaryEntry(
      id: 'entry_001',
      title: 'Llegada a Barcelona',
      description: '''
¡Por fin llegamos a Barcelona! El vuelo fue tranquilo y el 
aeropuerto muy bien organizado. Tomamos el Aerobus hasta 
Plaza Catalunya y de ahí caminamos al hotel.

Primera impresión: la ciudad es increíble. Las Ramblas están
llenas de vida incluso a las 10 de la noche. Mañana empezamos
a explorar en serio.
''',
      date: DateTime(2024, 1, 15, 18, 30),
      location: const Location(
        latitude: 41.3851,
        longitude: 2.1734,
        placeName: 'Barcelona',
        address: 'Las Ramblas, Barcelona, España',
      ),
      photos: [
        Photo(
          id: 'photo_001',
          localPath: '/data/photos/barcelona_arrival.jpg',
          takenAt: DateTime(2024, 1, 15, 18, 45),
          location: const Location(
            latitude: 41.3801,
            longitude: 2.1736,
          ),
        ),
      ],
      tripId: 'trip_spain_2024',
      createdAt: DateTime(2024, 1, 15, 21, 0),
      updatedAt: DateTime(2024, 1, 15, 21, 0),
    ),
    
    DiaryEntry(
      id: 'entry_002',
      title: 'La Sagrada Familia',
      description: '''
Hoy visitamos la obra maestra de Gaudí. Las fotos no le hacen
justicia - hay que verla en persona para entender por qué es
tan especial.

Los interiores son aún más impresionantes que el exterior.
La forma en que la luz entra por los vitrales crea un ambiente
mágico. Cada columna parece un árbol que se ramifica hacia
el techo.

Tip: Comprar entradas online con antelación. Nosotros casi
nos quedamos sin poder entrar.
''',
      date: DateTime(2024, 1, 16, 10, 0),
      location: const Location(
        latitude: 41.4036,
        longitude: 2.1744,
        placeName: 'Sagrada Familia',
        address: 'C/ de Mallorca, 401, Barcelona',
      ),
      photos: [
        Photo(
          id: 'photo_002',
          localPath: '/data/photos/sagrada_familia_1.jpg',
          takenAt: DateTime(2024, 1, 16, 10, 30),
        ),
        Photo(
          id: 'photo_003',
          localPath: '/data/photos/sagrada_familia_2.jpg',
          takenAt: DateTime(2024, 1, 16, 11, 15),
        ),
        Photo(
          id: 'photo_004',
          localPath: '/data/photos/sagrada_familia_interior.jpg',
          takenAt: DateTime(2024, 1, 16, 11, 45),
        ),
      ],
      tripId: 'trip_spain_2024',
      createdAt: DateTime(2024, 1, 16, 14, 0),
      updatedAt: DateTime(2024, 1, 16, 14, 0),
    ),
    
    DiaryEntry(
      id: 'entry_003',
      title: 'Paella en la Barceloneta',
      description: '''
Almuerzo en un restaurante frente al mar. Pedimos una paella
para compartir y un par de cervezas bien frías.

El paseo marítimo es perfecto para digerir después de comer.
Mucha gente paseando, patinando y disfrutando del sol de
enero (que aquí es bastante agradable).
''',
      date: DateTime(2024, 1, 16, 14, 30),
      location: const Location(
        latitude: 41.3807,
        longitude: 2.1899,
        placeName: 'La Barceloneta',
        address: 'Passeig Marítim de la Barceloneta',
      ),
      photos: [
        Photo(
          id: 'photo_005',
          localPath: '/data/photos/paella.jpg',
          takenAt: DateTime(2024, 1, 16, 14, 45),
        ),
        Photo(
          id: 'photo_006',
          localPath: '/data/photos/barceloneta_beach.jpg',
          takenAt: DateTime(2024, 1, 16, 16, 0),
        ),
      ],
      tripId: 'trip_spain_2024',
      createdAt: DateTime(2024, 1, 16, 18, 0),
      updatedAt: DateTime(2024, 1, 16, 18, 0),
    ),
    
    DiaryEntry(
      id: 'entry_004',
      title: 'Park Güell al atardecer',
      description: '''
Subimos al Park Güell para ver el atardecer sobre Barcelona.
Otro lugar mágico de Gaudí. Los mosaicos de colores, las
formas onduladas, todo parece sacado de un cuento.

Desde la terraza principal se ve toda la ciudad con el mar
de fondo. Esperamos hasta que el sol se puso y las luces
de la ciudad empezaron a encenderse.
''',
      date: DateTime(2024, 1, 17, 17, 0),
      location: const Location(
        latitude: 41.4145,
        longitude: 2.1527,
        placeName: 'Park Güell',
        address: 'C. d\'Olot, s/n, Barcelona',
      ),
      photos: [
        Photo(
          id: 'photo_007',
          localPath: '/data/photos/park_guell_1.jpg',
          takenAt: DateTime(2024, 1, 17, 17, 30),
        ),
        Photo(
          id: 'photo_008',
          localPath: '/data/photos/park_guell_sunset.jpg',
          takenAt: DateTime(2024, 1, 17, 18, 15),
        ),
      ],
      tripId: 'trip_spain_2024',
      createdAt: DateTime(2024, 1, 17, 20, 0),
      updatedAt: DateTime(2024, 1, 17, 20, 0),
    ),
    
    DiaryEntry(
      id: 'entry_005',
      title: 'Tren a Madrid',
      description: '''
Hoy dejamos Barcelona para ir a Madrid en AVE. El tren es
super cómodo y rápido (2h30 para 600km).

Llegamos a Atocha y lo primero que vimos fue el jardín
tropical dentro de la estación. Muy bonito pero extraño
ver palmeras dentro de un edificio.

Mañana: Museo del Prado.
''',
      date: DateTime(2024, 1, 18, 11, 0),
      location: const Location(
        latitude: 40.4065,
        longitude: -3.6903,
        placeName: 'Estación de Atocha',
        address: 'Plaza del Emperador Carlos V, Madrid',
      ),
      photos: [
        Photo(
          id: 'photo_009',
          localPath: '/data/photos/atocha_garden.jpg',
          takenAt: DateTime(2024, 1, 18, 13, 30),
        ),
      ],
      tripId: 'trip_spain_2024',
      createdAt: DateTime(2024, 1, 18, 15, 0),
      updatedAt: DateTime(2024, 1, 18, 15, 0),
    ),
  ];
  
  static List<Trip> get sampleTrips => [
    Trip(
      id: 'trip_spain_2024',
      name: 'España 2024',
      description: 'Viaje por Barcelona y Madrid',
      startDate: DateTime(2024, 1, 15),
      endDate: DateTime(2024, 1, 22),
      entryIds: [
        'entry_001',
        'entry_002',
        'entry_003',
        'entry_004',
        'entry_005',
      ],
      createdAt: DateTime(2024, 1, 10),
    ),
  ];
  
  /// Ubicaciones para el mapa
  static List<Location> get sampleLocations => [
    const Location(
      latitude: 41.3851,
      longitude: 2.1734,
      placeName: 'Barcelona Centro',
    ),
    const Location(
      latitude: 41.4036,
      longitude: 2.1744,
      placeName: 'Sagrada Familia',
    ),
    const Location(
      latitude: 41.3807,
      longitude: 2.1899,
      placeName: 'La Barceloneta',
    ),
    const Location(
      latitude: 41.4145,
      longitude: 2.1527,
      placeName: 'Park Güell',
    ),
    const Location(
      latitude: 40.4065,
      longitude: -3.6903,
      placeName: 'Madrid Atocha',
    ),
  ];
}
```

---

## 🧪 Mocks para Testing

### Mock Services

```dart
/**
 * Mock de servicios para testing unitario.
 */

// Mock Location Service
class MockLocationService implements LocationService {
  @override
  Future<Location?> getCurrentLocation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Location(
      latitude: 41.3851,
      longitude: 2.1734,
      placeName: 'Barcelona',
      address: 'Barcelona, España',
    );
  }
  
  @override
  Stream<Location> get locationStream => Stream.periodic(
    const Duration(seconds: 5),
    (_) => Location(
      latitude: 41.3851 + (Random().nextDouble() - 0.5) * 0.001,
      longitude: 2.1734 + (Random().nextDouble() - 0.5) * 0.001,
    ),
  );
}

// Mock Camera Service
class MockCameraService implements CameraService {
  @override
  Future<String?> takePhoto() async {
    await Future.delayed(const Duration(seconds: 1));
    return '/mock/photos/photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }
  
  @override
  Future<String?> pickFromGallery() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return '/mock/photos/gallery_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }
}

// Mock Notification Service
class MockNotificationService implements NotificationService {
  final List<Map<String, dynamic>> _scheduledNotifications = [];
  
  @override
  Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    _scheduledNotifications.add({
      'id': id,
      'title': title,
      'body': body,
      'scheduledDate': scheduledDate,
    });
  }
  
  @override
  Future<void> cancelReminder(int id) async {
    _scheduledNotifications.removeWhere((n) => n['id'] == id);
  }
  
  List<Map<String, dynamic>> get scheduledNotifications => 
      _scheduledNotifications;
}

// Mock Diary Repository
class MockDiaryRepository implements DiaryRepository {
  final List<DiaryEntry> _entries = List.from(MockData.sampleEntries);
  
  @override
  Future<List<DiaryEntry>> getAllEntries() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_entries);
  }
  
  @override
  Future<DiaryEntry?> getEntryById(String id) async {
    try {
      return _entries.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
  
  @override
  Future<String> createEntry(DiaryEntry entry) async {
    final newEntry = entry.copyWith(
      id: 'entry_${DateTime.now().millisecondsSinceEpoch}',
    );
    _entries.add(newEntry);
    return newEntry.id;
  }
  
  @override
  Future<void> updateEntry(DiaryEntry entry) async {
    final index = _entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      _entries[index] = entry.copyWith(updatedAt: DateTime.now());
    }
  }
  
  @override
  Future<void> deleteEntry(String id) async {
    _entries.removeWhere((e) => e.id == id);
  }
}
```

### Test Fixtures

```dart
/**
 * Fixtures para testing.
 */

class TestFixtures {
  /// Genera una entrada con datos aleatorios
  static DiaryEntry randomEntry() {
    final now = DateTime.now();
    final id = 'test_${now.millisecondsSinceEpoch}';
    
    return DiaryEntry(
      id: id,
      title: 'Entrada de prueba $id',
      description: 'Descripción de prueba para la entrada $id',
      date: now.subtract(Duration(days: Random().nextInt(30))),
      location: randomLocation(),
      photos: List.generate(
        Random().nextInt(4) + 1,
        (_) => randomPhoto(),
      ),
      createdAt: now,
      updatedAt: now,
    );
  }
  
  /// Genera una ubicación aleatoria en España
  static Location randomLocation() {
    final locations = [
      const Location(latitude: 41.3851, longitude: 2.1734, placeName: 'Barcelona'),
      const Location(latitude: 40.4168, longitude: -3.7038, placeName: 'Madrid'),
      const Location(latitude: 37.3891, longitude: -5.9845, placeName: 'Sevilla'),
      const Location(latitude: 39.4699, longitude: -0.3763, placeName: 'Valencia'),
      const Location(latitude: 43.2630, longitude: -2.9350, placeName: 'Bilbao'),
    ];
    return locations[Random().nextInt(locations.length)];
  }
  
  /// Genera una foto de prueba
  static Photo randomPhoto() {
    final now = DateTime.now();
    return Photo(
      id: 'photo_${now.millisecondsSinceEpoch}_${Random().nextInt(1000)}',
      localPath: '/test/photos/test_${Random().nextInt(100)}.jpg',
      takenAt: now,
    );
  }
  
  /// Lista de entradas para paginación
  static List<DiaryEntry> entriesForPagination(int count) {
    return List.generate(count, (_) => randomEntry());
  }
}
```

---

## 🔥 Configuración de Firebase (Opcional)

### Configuración de Notificaciones Push

```dart
/**
 * Configuración de Firebase Messaging para notificaciones push.
 * Solo necesario si se implementa el bonus de sincronización en la nube.
 */

// firebase_options.dart (generado por flutterfire configure)
// NO incluir en repositorio público

// Inicialización en main.dart
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Configurar FCM
  final messaging = FirebaseMessaging.instance;
  
  // Solicitar permisos
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  
  // Obtener token
  final token = await messaging.getToken();
  print('FCM Token: $token');
  
  // Manejar mensajes en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Mensaje recibido: ${message.notification?.title}');
    // Mostrar notificación local
  });
  
  // Manejar tap en notificación
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notificación abierta: ${message.data}');
    // Navegar a la entrada correspondiente
  });
}
```

### Estructura Firestore (Opcional)

```
users/
  {userId}/
    profile/
      name: string
      email: string
      createdAt: timestamp
    entries/
      {entryId}/
        title: string
        description: string
        date: timestamp
        location: geopoint
        photos: array<string>
        tripId: string?
        createdAt: timestamp
        updatedAt: timestamp
    trips/
      {tripId}/
        name: string
        startDate: timestamp
        endDate: timestamp?
        entryIds: array<string>
```

---

## 🔗 Navegación

| Anterior | Índice | Siguiente |
|----------|--------|-----------|
| [GUIA-DISENO.md](./GUIA-DISENO.md) | [Proyecto](./README.md) | [Recursos](../4-recursos/README.md) |
