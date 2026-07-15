# 🤖 Instrucciones para GitHub Copilot / Claude

## 📋 Contexto del Bootcamp

Este es un **Bootcamp de Flutter Zero to Hero** estructurado para llevar a desarrolladores con **conocimientos básicos de programación orientada a objetos** — sin experiencia previa en Dart — hasta el desarrollo de aplicaciones móviles nativas listas para producción en App Store y Google Play.

### 📊 Datos del Bootcamp

- **Duración**: 19 semanas (~4.75 meses)
- **Dedicación semanal**: 16 horas (2 sesiones de 8h)
- **Total de horas**: 304 horas
- **Nivel de entrada**: Programación básica (POO), sin Dart previo
- **Nivel de salida**: Desarrollador Flutter Junior
- **Enfoque**: Flutter moderno (canal stable), Dart con null safety, progresión Provider → Riverpod → Bloc
- **Stack**: Dart, Flutter, go_router, Provider, Riverpod, flutter_bloc, Dio, Firebase Auth/FCM, Docker

---

## 🎯 Objetivos de Aprendizaje

Al finalizar el bootcamp, los estudiantes serán capaces de:

- ✅ Dominar Dart moderno: null safety, async/await, Futures/Streams, POO, mixins
- ✅ Construir interfaces con el sistema de widgets de Flutter y layouts responsivos
- ✅ Implementar navegación compleja con go_router
- ✅ Gestionar estado con la progresión Provider → Riverpod → Bloc/Cubit
- ✅ Consumir APIs REST de forma robusta con Dio
- ✅ Manejar formularios con validación
- ✅ Implementar persistencia local y autenticación completa
- ✅ Diseñar apps con Clean Architecture
- ✅ Crear animaciones implícitas y explícitas, y widgets con CustomPainter
- ✅ Acceder a APIs nativas (cámara, geolocalización, permisos) vía platform channels
- ✅ Escribir tests automatizados (unit, widget, integration, golden)
- ✅ Optimizar performance de apps Flutter con DevTools
- ✅ Publicar en App Store y Google Play
- ✅ Implementar CI/CD y actualizaciones OTA

---

## 📚 Estructura del Bootcamp

### Distribución por Fases

#### **Lenguaje — Dart (Semana 1)** - 16 horas

- Variables, tipos, null safety (`?`, `!`, `late`, `??`, `??=`)
- Funciones, colecciones (List/Set/Map), control de flujo
- POO en Dart: clases, herencia, interfaces implícitas, mixins, extension methods
- Programación asíncrona: `Future`, `async`/`await`, `Stream`, generadores

#### **Fundamentos Flutter (Semanas 2-3)** - 32 horas

- Entorno Flutter (SDK local + Docker para analyze/test/build)
- Widget tree, StatelessWidget vs StatefulWidget, ciclo de vida
- Layout: Row, Column, Flex, Expanded/Flexible, Stack
- Material 3 y Cupertino, theming básico
- Navegación declarativa con go_router: rutas, rutas anidadas, deep links

#### **Estado y Datos (Semanas 4-10)** - 112 horas

- Estado local: `setState`, `InheritedWidget`, `ChangeNotifier` + Provider
- Riverpod (estándar del curso desde semana 5): providers, `AsyncNotifier`, code generation
- Networking con Dio, manejo de errores, estado async con Riverpod
- Formularios complejos con validación
- Persistencia local: SharedPreferences, Hive/Isar, sqflite
- Autenticación completa: Firebase Auth / JWT, `flutter_secure_storage`
- Clean Architecture en Flutter + Bloc/Cubit (cierre de la progresión de estado)

#### **Avanzado (Semanas 11-16)** - 96 horas

- Animaciones implícitas (`AnimatedContainer`, `Hero`) y explícitas (`AnimationController`, `CustomPainter`)
- APIs nativas: cámara, ubicación, permisos, platform channels
- Push Notifications con Firebase Cloud Messaging
- Testing: `flutter_test`, `mocktail`, `integration_test`, golden tests
- Performance: Flutter DevTools, `const`, control de rebuilds, profiling

#### **Producción (Semanas 17-19)** - 48 horas

- Build y release: APK/AAB/IPA, firma, flavors
- Publicación en App Store Connect y Google Play Console
- CI/CD con GitHub Actions + Fastlane, actualizaciones OTA (Shorebird)
- Proyecto final integrador (semana 19)

---

## 🗂️ Estructura de Carpetas

Cada semana sigue esta estructura estándar:

```
bootcamp/week-XX-tema_principal/
├── README.md                 # Descripción y objetivos de la semana
├── rubrica-evaluacion.md     # Criterios de evaluación detallados
├── 0-assets/                 # Imágenes, diagramas y recursos visuales
├── 1-teoria/                 # Material teórico (archivos .md)
├── 2-practicas/              # Ejercicios guiados paso a paso
├── 3-proyecto/               # Proyecto semanal integrador
│   ├── README.md             # Instrucciones del proyecto
│   ├── starter/               # Código inicial para el estudiante
│   └── solution/               # ⚠️ OCULTA - Solo para instructores (.gitignore)
├── 4-recursos/               # Recursos adicionales
│   ├── ebooks-free/          # Libros electrónicos gratuitos
│   ├── videografia/          # Videos y tutoriales recomendados
│   └── webgrafia/            # Enlaces y documentación
└── 5-glosario/               # Términos clave de la semana (A-Z)
    └── README.md
```

`week-19-proyecto_final/` es la excepción: solo tiene `README.md`, `rubrica-evaluacion.md`, `3-proyecto/` y `5-glosario/` (sin `1-teoria/`, `2-practicas/`, `0-assets/` ni `4-recursos/`), porque es semana de consolidación pura.

### 📁 Carpetas Raíz

- **`assets/`**: Recursos visuales globales (logos, headers, etc.)
- **`scripts/`**: Scripts de automatización y utilidades
- **`bootcamp/`**: Contenido semanal del bootcamp
- **`docs/`**: Plan de estudios, versiones del stack, configuración Docker

---

## 🎓 Componentes de Cada Semana

### 1. **Teoría** (1-teoria/)

- Archivos markdown con explicaciones conceptuales
- Ejemplos de código con comentarios educativos en español
- Diagramas SVG cuando sea necesario (nunca ASCII art)
- Referencias a documentación oficial de Dart y Flutter
- **Extensión objetivo: ~150 líneas por archivo** (no superar 200 líneas — dividir en archivos temáticos si es necesario)

### 2. **Prácticas** (2-practicas/)

- Ejercicios guiados paso a paso
- Incremento progresivo de dificultad
- Código comentado y explicado
- Casos de uso del mundo real en contexto móvil

#### 📋 Formato de Ejercicios

Los ejercicios son **tutoriales guiados**, NO tareas con TODOs. El estudiante aprende descomentando código:

**README.md del ejercicio:**

```markdown
### Paso 1: Crear una ListView básica

Explicación del concepto con ejemplo:

\`\`\`dart
// Ejemplo explicativo
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => Text(items[index].name),
)
\`\`\`

**Abre `starter/lib/main.dart`** y descomenta la sección correspondiente.
```

**starter/lib/main.dart:**

```dart
// ============================================
// PASO 1: ListView básica
// ============================================
debugPrint('--- Paso 1: ListView básica ---');

// Este widget renderiza una lista eficiente
// Descomenta las siguientes líneas:
// ListView.builder(
//   itemCount: items.length,
//   itemBuilder: (context, index) => Text(items[index].name),
// )
```

> ⚠️ **IMPORTANTE**: Los ejercicios NO tienen carpeta `solution/`. El estudiante aprende descomentando el código y verificando que funcione correctamente.

#### ❌ NO usar este formato en ejercicios:

```dart
// ❌ INCORRECTO - Este formato es para PROYECTOS, no ejercicios
Widget buildItem(Item item) {
  // TODO: Implementar renderizado
  return const SizedBox.shrink();
}
```

#### ✅ Usar este formato en ejercicios:

```dart
// ✅ CORRECTO - Código comentado para descomentar
// Descomenta las siguientes líneas:
// Widget buildItem(Item item) {
//   return ListTile(title: Text(item.name));
// }
```

### 3. **Proyecto** (3-proyecto/)

- Proyecto integrador que consolida lo aprendido en la semana
- README.md con instrucciones claras
- Código inicial en `starter/`
- Carpeta `solution/` oculta (en `.gitignore`) solo para instructores
- Criterios de evaluación específicos
- **Política de Dominios Únicos**: Cada aprendiz trabaja sobre un dominio diferente

#### 🏛️ Política de Dominios Únicos (Anticopia)

**Cada aprendiz recibe un dominio único asignado por el instructor:**

- 📖 Biblioteca
- 💊 Farmacia
- 🏋️ Gimnasio
- 🏫 Escuela
- 🏬 Tienda de mascotas
- 🍽️ Restaurante
- 🏦 Banco
- 🚕 Agencia de taxis
- 🏥 Hospital
- 🎥 Cine
- 🏞️ Hotel
- ✈️ Agencia de viajes
- 🏎️ Concesionario de autos
- 👗 Tienda de ropa
- 🛠️ Taller mecánico
- Y otros dominios únicos según cantidad de aprendices

**Objetivo:**

- Prevenir copia entre estudiantes
- Fomentar implementaciones originales
- Aplicar conceptos generales a contextos específicos
- Desarrollar capacidad de abstracción y adaptación

**El instructor debe:**

1. Asignar un dominio único a cada aprendiz al inicio del bootcamp
2. Mantener un registro de dominios asignados
3. No repetir dominios en el mismo grupo
4. Validar que las implementaciones sean coherentes con el dominio

#### 📋 Formato de Proyecto (con TODOs)

A diferencia de los ejercicios, el proyecto SÍ usa TODOs para que el estudiante implemente desde cero. **Las instrucciones del proyecto deben ser genéricas y adaptables a cualquier dominio.**

**starter/lib/screens/home_screen.dart:**

```dart
// ============================================
// SCREEN: HomeScreen
// Lista de elementos del dominio con pull-to-refresh
// ============================================

// NOTA PARA EL APRENDIZ:
// Adapta esta pantalla a tu dominio asignado.
// Ejemplos:
// - Biblioteca: lista de libros
// - Farmacia: lista de medicamentos
// - Gimnasio: lista de miembros

class Item {
  final String id;
  final String name;
  // TODO: Agregar propiedades específicas de tu dominio
  // Ejemplo (Biblioteca): final String author; final String isbn;
  // Ejemplo (Farmacia): final double price; final int stock;

  const Item({required this.id, required this.name});
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implementar provider Riverpod para obtener elementos
    // TODO: Implementar función de renderizado de cada item
    return const Placeholder(); // TODO: Renderizar ListView con los elementos
  }
}
```

**El README.md del proyecto debe incluir:**

```markdown
## 📱 Proyecto Semanal: [Título Genérico]

### 🎯 Objetivo

Implementar [concepto aprendido] aplicado a tu dominio asignado.

### 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio]

### ✅ Requisitos Funcionales (Adaptables a tu dominio)

1. Crear pantalla para listar elementos
2. Implementar búsqueda/filtrado
3. Agregar navegación al detalle
4. etc.

### 💡 Ejemplos de Adaptación por Dominio

- **Biblioteca**: Gestionar libros, autores, préstamos
- **Farmacia**: Gestionar medicamentos, ventas, inventario
- **Gimnasio**: Gestionar miembros, rutinas, asistencias
- **Restaurante**: Gestionar platillos, mesas, pedidos

### 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Código adaptado a tu dominio
3. README con descripción de tu implementación
```

El estudiante debe:

1. Leer las instrucciones en README.md
2. Adaptar los conceptos genéricos a su dominio específico
3. Completar cada TODO con implementación contextualizada
4. Usar lo aprendido en teoría y prácticas guiadas

### 4. **Recursos** (4-recursos/)

- **ebooks-free/**: Libros gratuitos relevantes
- **videografia/**: Videos tutoriales complementarios
- **webgrafia/**: Enlaces a documentación oficial y artículos

### 5. **Glosario** (5-glosario/)

- Términos técnicos ordenados alfabéticamente
- Definiciones claras y concisas en español
- Ejemplos de código cuando aplique

---

## 🏗️ Progresión Arquitectónica Deliberada (Estado)

El bootcamp enseña gestión de estado como una progresión intencional, no como temas sueltos:

1. **Semana 4 — Provider**: `setState`, `InheritedWidget`, `ChangeNotifier`. Introduce el problema que resuelve un gestor de estado.
2. **Semana 5 en adelante — Riverpod**: se convierte en el **estándar del curso** para el resto del temario (networking, forms, auth, etc.). Type-safe, testeable, sin `BuildContext`.
3. **Semana 10 — Bloc/Cubit**: cierre de la progresión dentro de Clean Architecture, como alternativa orientada a eventos usada en contextos enterprise.

Al generar contenido de semanas 6-9, **usar Riverpod** salvo que la semana lo indique explícitamente distinto. No mezclar gestores de estado dentro de un mismo ejemplo.

---

## 📝 Convenciones de Código

### Dart Moderno (null safety)

```dart
// ✅ BIEN - clases inmutables con constructores const
class CardData {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  const CardData({
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });
}

// ✅ BIEN - widgets con tipo explícito de retorno
class Card extends StatelessWidget {
  const Card({super.key, required this.data});

  final CardData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: data.onPressed, child: Text(data.title));
  }
}

// ✅ BIEN - null safety explícito
User? currentUser;

// ❌ MAL - usar `dynamic` o `!` sin justificar la garantía de no-nulidad
dynamic user;
```

### Nomenclatura

- **Clases/Widgets**: PascalCase (`HomeScreen`, `ProductCard`)
- **Providers Riverpod**: camelCase con sufijo `Provider` (`authProvider`, `productsProvider`)
- **Cubits/Blocs**: PascalCase con sufijo `Cubit`/`Bloc` (`AuthCubit`, `CartBloc`)
- **Variables y funciones**: camelCase
- **Constantes globales**: `lowerCamelCase` con `const`/`static const` (convención Dart, no UPPER_SNAKE_CASE)
- **Archivos**: `snake_case.dart` (`home_screen.dart`, `auth_provider.dart`)
- **Idioma**: inglés para código, español para documentación

### Estructura de Proyecto Flutter (Clean Architecture, desde semana 10)

```
lib/
├── main.dart
├── app/                  # Configuración de la app (router, theme)
├── features/
│   └── <feature>/
│       ├── data/         # Repositories, data sources, DTOs
│       ├── domain/       # Entities, use cases, contratos de repository
│       └── presentation/ # Widgets, providers/cubits, screens
├── core/                 # Utilidades, constantes, errores compartidos
└── shared/               # Widgets y componentes reutilizables
```

Antes de la semana 10 (mientras el curso usa Provider/Riverpod sin Clean Architecture), una estructura simple por capas es suficiente:

```
lib/
├── main.dart
├── screens/
├── widgets/
├── providers/            # o notifiers/ para Riverpod
├── services/             # Llamadas a API (Dio)
├── models/
└── utils/
```

---

## 🐳 Entorno de Desarrollo (Docker)

- **Docker es el entorno oficial** para `flutter analyze`, `flutter test` y `flutter build` — garantiza versiones idénticas entre estudiantes y paridad con CI.
- Docker **no reemplaza** el SDK local: `flutter run` en un emulador/simulador siempre requiere Flutter instalado en el host (Docker no renderiza GUI). Ver [docs/docker-setup.md](../docs/docker-setup.md).
- Cada proyecto semanal (`3-proyecto/starter/`) incluye su propio `Dockerfile` y `docker-compose.yml` basados en la imagen `ghcr.io/cirruslabs/flutter:stable`.
- Comandos estándar: `docker compose run --rm flutter flutter analyze`, `docker compose run --rm flutter flutter test`.
- Builds de iOS (`flutter build ipa`) requieren siempre un host macOS con Xcode — esto no es una limitación de Docker, es una limitación de Apple. Documentarlo explícitamente en semana 17.

---

## 🧪 Testing

El bootcamp enseña testing con **`flutter_test`** (unit/widget), **`mocktail`** (mocks) e **`integration_test`** (E2E), más golden tests para regresión visual.

### Estructura de Tests

```dart
// test/screens/home_screen_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/screens/home_screen.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('muestra el título correctamente', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: HomeScreen())),
      );
      expect(find.text('Inicio'), findsOneWidget);
    });

    testWidgets('navega al detalle al presionar un item', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: HomeScreen())),
      );
      await tester.tap(find.byKey(const Key('product-item-1')));
      await tester.pumpAndSettle();
      expect(find.byType(Text), findsWidgets);
    });
  });
}
```

---

## 📖 Documentación

### README.md de Semana

Debe incluir:

1. **Título y descripción**
2. **🎯 Objetivos de aprendizaje**
3. **📚 Requisitos previos**
4. **🗂️ Estructura de la semana**
5. **📝 Contenidos** (con enlaces a teoría/prácticas)
6. **⏱️ Distribución del tiempo** (16 horas)
7. **📌 Entregables**
8. **🔗 Navegación** (anterior/siguiente semana)

### Archivos de Teoría

```markdown
# Título del Tema

## 🎯 Objetivos

- Objetivo 1
- Objetivo 2

## 📋 Contenido

### 1. Introducción

### 2. Conceptos Clave

### 3. Ejemplos Prácticos

### 4. Casos de Uso Móvil

## 📚 Recursos Adicionales

## ✅ Checklist de Verificación
```

---

## 🎨 Recursos Visuales y Estándares de Diseño

### Formato de Assets

- ✅ **Preferir SVG** para todos los diagramas, iconos y gráficos
- ❌ **NO usar ASCII art** para diagramas o visualizaciones
- ✅ Usar PNG/JPG solo para screenshots de emulador/simulador
- ✅ Optimizar imágenes antes de incluirlas

### Criterio para Assets SVG por Semana

Los assets SVG en `0-assets/` tienen un propósito educativo específico:

- ✅ Diagramas de arquitectura (widget tree, Clean Architecture, flujo de estado)
- ✅ Flujos de autenticación y ciclo de vida de widgets
- ✅ Comparativas iOS vs Android de componentes
- ✅ Headers de semana para identificación visual

**Reglas de vinculación:**

1. Todo SVG debe estar **vinculado en al menos un archivo** de teoría o práctica
2. Usar sintaxis markdown: `![Descripción](../0-assets/nombre.svg)`
3. Incluir texto alternativo descriptivo para accesibilidad
4. Nombrar descriptivamente: `widget-tree-flow.svg`, `riverpod-provider-graph.svg`

### Tema Visual

- 🌙 **Tema dark** para todos los assets visuales
- ❌ **Sin degradés** (gradients) en diseños
- ✅ Colores sólidos y contrastes claros
- ✅ Paleta basada en azul Flutter (#0175C2, #02569B, #54C5F8)

### Tipografía

- ✅ **Fuentes sans-serif** exclusivamente (Inter, Roboto, System UI)
- ❌ **NO usar fuentes serif**
- ✅ Mantener jerarquía visual clara

---

## 🌐 Idioma y Nomenclatura

### Código y Comentarios Técnicos

- ✅ **Nomenclatura en inglés** (variables, funciones, clases, tipos)
- ✅ **Comentarios de código en inglés**
- ✅ Usar términos técnicos estándar de la industria

```dart
// ✅ CORRECTO - inglés
Future<UserProfile> fetchUserProfile(String userId) async {
  // Fetch user profile from API
  final response = await dio.get('/users/$userId');
  return UserProfile.fromJson(response.data);
}

// ❌ INCORRECTO - español en código
Future<PerfilUsuario> obtenerPerfilUsuario(String idUsuario) async {
  // Obtener perfil del usuario desde la API
  final respuesta = await dio.get('/usuarios/$idUsuario');
  return PerfilUsuario.fromJson(respuesta.data);
}
```

### Documentación

- ✅ **Documentación en español** (READMEs, teoría, guías)
- ✅ Comentarios educativos en español cuando expliquen conceptos

```dart
// ✅ CORRECTO - código en inglés, explicación en español
String formatCurrency(double amount, String currencyCode) {
  // Intl está disponible vía el paquete `intl` — siempre especificar
  // locale para resultados consistentes entre plataformas.
  return NumberFormat.simpleCurrency(locale: 'es_CO', name: currencyCode)
      .format(amount);
}
```

---

## 🔐 Mejores Prácticas

### Código Limpio

- Nombres descriptivos y significativos
- Widgets pequeños con una sola responsabilidad
- Evitar anidamiento profundo en el árbol de widgets (extraer sub-widgets)
- Usar early returns en lógica de negocio

### Seguridad

- Nunca almacenar tokens en SharedPreferences (usar `flutter_secure_storage`)
- Validar todos los inputs de formularios
- No exponer API keys en el código fuente (usar `--dart-define` o `flutter_dotenv`, nunca hardcodear)
- Sanitizar datos de APIs externas antes de renderizar
- Nunca commitear `google-services.json` / `GoogleService-Info.plist` reales (están en `.gitignore`; cada estudiante usa los suyos)

### Rendimiento

- Usar `const` en constructores siempre que sea posible
- `ListView.builder` en vez de `ListView` con listas largas
- Evitar rebuilds innecesarios: `select` de Riverpod, `Consumer` acotado
- `key` únicos en listas dinámicas
- Cachear imágenes de red (`cached_network_image`)

---

## 📊 Evaluación

Cada semana incluye **tres tipos de evidencias**:

1. **Conocimiento 🧠** (30%): Evaluaciones teóricas, cuestionarios
2. **Desempeño 💪** (40%): Ejercicios prácticos en clase
3. **Producto 📦** (30%): Proyecto entregable funcional

### Criterios de Aprobación

- Mínimo **70%** en cada tipo de evidencia
- Entrega puntual de proyectos
- App funcional en emulador/simulador iOS y/o Android
- `flutter analyze` sin errores, tests pasando (cuando aplique)
- **Implementación coherente con el dominio asignado**
- **Originalidad**: Sin copia de implementaciones de otros aprendices

---

## 🚀 Metodología de Aprendizaje

### Estrategias Didácticas

- **Aprendizaje Basado en Proyectos (ABP)**: Proyectos semanales integradores
- **Dominios Únicos**: Cada aprendiz aplica conceptos a su dominio asignado (anticopia)
- **Práctica Deliberada**: Ejercicios incrementales con feedback inmediato
- **Mobile-First Thinking**: Siempre pensar en experiencia táctil y plataforma
- **Progresión Arquitectónica**: Provider → Riverpod → Bloc/Cubit, deliberada
- **Code Review**: Revisión de código entre estudiantes
- **Live Coding**: Sesiones en vivo de programación

### Distribución del Tiempo (16h/semana)

- **Teoría**: 4 horas
- **Prácticas**: 6 horas
- **Proyecto**: 6 horas

---

## 🤖 Instrucciones para Copilot / Claude

Cuando trabajes en este proyecto:

### Límites de Respuesta

1. **Divide respuestas largas**
   - ❌ **NUNCA generar respuestas que superen los límites de tokens**
   - ✅ **SIEMPRE dividir contenido extenso en múltiples entregas**
   - ✅ Crear contenido por secciones, esperar confirmación del usuario
   - ✅ Priorizar calidad sobre cantidad en cada entrega

2. **Estrategia de División**
   - Para semanas completas: dividir por carpetas (teoria → practicas → proyecto)
   - Para archivos grandes: dividir por secciones lógicas
   - Siempre indicar claramente qué parte se entrega y qué falta

### Generación de Código

1. **Usa siempre Dart moderno con null safety**
   - Tipos explícitos obligatorios en parámetros y retornos públicos
   - Constructores `const` siempre que el widget lo permita
   - Evitar `dynamic`; usar `Object?`/tipos concretos

2. **Entorno de Desarrollo**
   - ✅ Docker para `analyze`/`test`/`build` (paridad con CI)
   - ✅ Flutter SDK local + emulador/simulador para `flutter run`
   - ✅ `pubspec.yaml` con versiones exactas en dependencias críticas del curso

3. **Gestión de Paquetes**
   - ✅ **SOLO usar `flutter pub` / `dart pub`** como gestor de paquetes
   - ✅ Versiones exactas para paquetes core del curso (sin `^` en el `pubspec.yaml` de referencia del instructor)
   - Comandos: `flutter pub add dio`, `flutter pub add -d mocktail`

4. **Plataformas**
   - Siempre considerar diferencias iOS / Android
   - Usar `Platform.isIOS` / `Platform.isAndroid` para comportamientos divergentes
   - Testear visualmente en ambas plataformas cuando sea relevante

5. **Comenta el código de manera educativa**
   - Explica conceptos para desarrolladores nuevos en Dart/Flutter
   - Señala diferencias con otros frameworks (React Native, web) cuando aplique
   - Usa comentarios que enseñen, no solo describan

### Creación de Contenido

1. **Estructura clara y progresiva**
   - De lo simple a lo complejo
   - Conceptos construidos sobre conocimientos previos
   - Siempre contextualizar diferencias mobile vs web

2. **Ejemplos del mundo real**
   - Apps móviles que los estudiantes reconocen (Instagram, Uber, Spotify)
   - Casos de uso prácticos en contexto móvil
   - Proyectos que los estudiantes puedan mostrar en portafolios

3. **Enfoque moderno**
   - No mencionar características obsoletas (no `StatefulWidget` para todo, no APIs deprecadas)
   - Enfocarse en mejores prácticas del canal stable de Flutter vigente

### Respuestas y Ayuda

1. **Explicaciones claras**
   - Lenguaje simple y directo
   - Proporcionar analogías con otros frameworks cuando sea útil

2. **Código comentado**
   - Explicar cada paso importante
   - Señalar posibles errores comunes en mobile

3. **Recursos adicionales**
   - Referencias a documentación oficial de Dart y Flutter
   - Riverpod docs, Bloc docs
   - Artículos relevantes de calidad

---

## 📚 Referencias Oficiales

- **Dart**: https://dart.dev/
- **Flutter**: https://flutter.dev/
- **go_router**: https://pub.dev/packages/go_router
- **Riverpod**: https://riverpod.dev/
- **Bloc**: https://bloclibrary.dev/
- **Dio**: https://pub.dev/packages/dio
- **Firebase for Flutter**: https://firebase.google.com/docs/flutter/setup

---

## 🔗 Enlaces Importantes

- **Repositorio**: https://github.com/ergrato-dev/bc-flutter
- **Documentación general**: [README.md](../README.md)
- **Primera semana**: [bootcamp/week-01-fundamentos_dart_y_entorno/README.md](../bootcamp/week-01-fundamentos_dart_y_entorno/README.md)

---

## ✅ Checklist para Nuevas Semanas

Cuando crees contenido para una nueva semana:

- [ ] Crear estructura de carpetas completa
- [ ] README.md con objetivos y estructura
- [ ] Material teórico en 1-teoria/
- [ ] Ejercicios prácticos en 2-practicas/
- [ ] Proyecto integrador en 3-proyecto/ (con `Dockerfile`/`docker-compose.yml` en `starter/`)
- [ ] Recursos adicionales en 4-recursos/
- [ ] Glosario de términos en 5-glosario/
- [ ] Rúbrica de evaluación
- [ ] Verificar coherencia con semanas anteriores (especialmente el gestor de estado vigente)
- [ ] Revisar progresión de dificultad
- [ ] Probar código de ejemplos en emulador/simulador y con `docker compose run --rm flutter flutter analyze`

---

## 💡 Notas Finales

- **Prioridad**: Claridad sobre brevedad
- **Enfoque**: Aprendizaje práctico sobre teoría abstracta
- **Objetivo**: Preparar desarrolladores mobile listos para trabajar
- **Filosofía**: Flutter moderno desde el día 1, con progresión de estado deliberada
