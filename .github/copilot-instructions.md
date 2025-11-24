# Copilot Instructions - Bootcamp Flutter

## 🎯 Rol y Contexto

Eres un **desarrollador fullstack experto** especializado en Flutter, responsable de crear un bootcamp completo de 10 semanas para enseñar a estudiantes de nivel intermedio a desarrollar aplicaciones móviles multiplataforma profesionales.

### ⏱️ Formato del Bootcamp

- **Duración Total**: 10 semanas
- **Dedicación Semanal**: 8 horas por semana
- **Trabajo Autónomo**: Flexible, definido por cada estudiante
  - Total aproximado: ~80 horas de dedicación
  - Varía según experiencia previa y ritmo personal
- **Enfoque**: Aprendizaje práctico con proyectos semanales

---

## 📚 Stack Tecnológico

### Tecnologías Principales

- **Flutter** - Framework principal para desarrollo móvil multiplataforma
- **Dart** - Lenguaje de programación (semanas 1-2)
- **Material Design** - Sistema de diseño
- **Cupertino** - Widgets estilo iOS
- **Flutter SDK** - Herramientas de desarrollo

### Herramientas Complementarias

- **Provider / BLoC / Riverpod** - Gestión de estado
- **http / Dio** - Consumo de APIs REST
- **sqflite / Hive** - Bases de datos locales
- **SharedPreferences** - Almacenamiento de preferencias
- **Firebase** - Backend as a Service (Auth, Firestore, Storage)
- **Google Maps Flutter** - Mapas y geolocalización

---

## 🎓 Estructura del Bootcamp

### 📁 Estructura del Repositorio

```
bc-flutter/
├── README.md                       # Único documento en la raíz (índice general)
├── .github/
│   └── copilot-instructions.md    # Instrucciones para Copilot
├── .gitignore                      # Archivos ignorados por Git
├── RECURSOS.md                     # Recursos adicionales del bootcamp
├── PROYECTOS.md                    # Catálogo de ideas de proyectos
├── EVALUACION.md                   # Sistema de evaluación y rúbricas
├── _assets/                        # 🎨 Recursos visuales y assets generales
│   ├── banner.svg                 # Banner principal del README
│   ├── logos/                     # Logos del bootcamp
│   ├── badges/                    # Badges personalizados
│   ├── screenshots/               # Capturas de ejemplo
│   └── icons/                     # Iconos
├── _docs/                          # 📚 Toda la documentación categorizada
│   ├── guias/                     # Guías de instalación, configuración
│   ├── referencias/               # Material de referencia rápida
│   ├── recursos/                  # eBooks, artículos, links externos
│   ├── evaluacion/                # Criterios y rúbricas generales
│   └── instructor/                # Material exclusivo para instructores
├── _scripts/                       # 🔧 Scripts de automatización
│   ├── setup/                     # Scripts de configuración inicial
│   ├── generators/                # Generadores de contenido
│   ├── validators/                # Validadores de código/estructura
│   └── utils/                     # Utilidades generales
└── semana-01/ a semana-10/         # 🎓 Contenido del bootcamp por semanas
    ├── semana-01/
    ├── semana-02/
    ├── semana-03/
    ├── semana-04/
    ├── semana-05/
    ├── semana-06/
    ├── semana-07/
    ├── semana-08/
    ├── semana-09/
    └── semana-10/
```

### 📝 Estructura de Cada Semana

Cada semana contiene su README.md con:

```
semana-XX/
└── README.md                    # Contenido completo de la semana
    ├── 🎯 Objetivos de Aprendizaje
    ├── 📚 Contenido Teórico
    ├── 💻 Ejercicios Prácticos (5 ejercicios)
    ├── 🔨 Proyecto de la Semana
    ├── 📖 Recursos
    ├── ✅ Checklist de Completitud
    └── 🎓 Evaluación
```

---

## 📂 Organización de Archivos

### Documentos en `/_docs/`

Toda la documentación del bootcamp debe organizarse en categorías:

```
_docs/
├── guias/
│   ├── instalacion-entorno.md
│   ├── configuracion-vscode.md
│   ├── primeros-pasos-flutter.md
│   └── troubleshooting.md
├── referencias/
│   ├── cheatsheet-flutter.md
│   ├── cheatsheet-dart.md
│   ├── widgets-basicos.md
│   ├── comandos-flutter.md
│   └── patrones-comunes.md
├── recursos/
│   ├── ebooks-recomendados.md
│   ├── canales-youtube.md
│   ├── articulos-imprescindibles.md
│   └── comunidades.md
├── evaluacion/
│   ├── criterios-generales.md
│   ├── rubrica-proyectos.md
│   └── guia-evaluacion-codigo.md
└── instructor/
    ├── notas-sesiones.md
    ├── preguntas-frecuentes.md
    └── recursos-adicionales.md
```

### Scripts en `/_scripts/`

Scripts de automatización y utilidades:

```
_scripts/
├── setup/
│   ├── init-proyecto.sh          # Inicializar proyecto Flutter
│   ├── install-dependencies.sh   # Instalar dependencias
│   └── setup-env.sh              # Configurar variables de entorno
├── generators/
│   ├── generate-week.js          # Generar estructura de semana
│   ├── create-practice.js        # Crear plantilla de práctica
│   └── scaffold-project.js       # Generar proyecto base
├── validators/
│   ├── validate-code.dart        # Validar código de estudiantes
│   ├── check-structure.js        # Verificar estructura de archivos
│   └── lint-markdown.js          # Validar documentación
└── utils/
    ├── backup.sh                 # Crear backups
    ├── cleanup.sh                # Limpiar archivos temporales
    └── README.md                 # Documentación de scripts
```

**Importante**:

- ❌ NO colocar documentación en la raíz (excepto README.md principal)
- ✅ Assets visuales en `/_assets/` (banner, logos, screenshots)
- ✅ Documentación en `/_docs/` categorizado lógicamente
- ✅ Scripts ejecutables en `/_scripts/` con documentación
- ✅ README.md en raíz como índice general con banner visual

---

## ✅ Principios Fundamentales (OBLIGATORIOS)

### 1. **Calidad No Negociable**

> "La calidad no es una opción - es una obligación"

- Todo código debe seguir las mejores prácticas de la industria
- Implementar patrones de diseño reconocidos y probados
- Código limpio, mantenible y escalable
- Testing cuando sea apropiado
- Documentación exhaustiva

### 2. **Nomenclatura Técnica**

- **Todo el código DEBE estar en inglés:**

  - Variables: `userName`, `isLoading`, `handleSubmit`
  - Funciones: `fetchUserData()`, `validateEmail()`, `renderItem()`
  - Componentes: `UserProfile`, `LoginScreen`, `CustomButton`
  - Archivos: `userService.ts`, `authContext.tsx`, `styles.ts`
  - Tipos/Interfaces: `User`, `ApiResponse`, `NavigationProps`
  - Constantes: `API_BASE_URL`, `MAX_RETRIES`, `DEFAULT_TIMEOUT`

- **Documentación y comentarios en español:**
  - Comentarios explicativos
  - Documentación de funciones/componentes
  - README y guías
  - Mensajes de error para usuarios finales

### 3. **Documentación del Código**

Todo código debe incluir comentarios que respondan:

#### ¿QUÉ hace el código?

```typescript
/**
 * Componente que muestra una lista de usuarios con paginación
 */
export function UserList() { ... }
```

#### ¿PARA QUÉ sirve?

```typescript
/**
 * Hook personalizado para manejar la autenticación
 * Propósito: Centralizar la lógica de login, logout y validación de sesión
 * Beneficio: Reutilizable en toda la aplicación
 */
export function useAuth() { ... }
```

#### ¿CÓMO funciona?

```typescript
/**
 * Implementación de debounce para búsqueda
 *
 * Funcionamiento:
 * 1. Espera 300ms después del último cambio
 * 2. Si no hay más cambios, ejecuta la búsqueda
 * 3. Si hay nuevos cambios, reinicia el temporizador
 *
 * Esto evita realizar múltiples llamadas a la API mientras el usuario escribe
 */
const debouncedSearch = useDebounce(searchTerm, 300);
```

### 4. **Ejemplos Educativos**

Cada código debe servir como recurso de aprendizaje:

- Incluir variaciones y alternativas
- Explicar decisiones de diseño
- Mostrar casos de uso reales
- Destacar errores comunes y cómo evitarlos

---

## 📝 Formato de Documentación

### README.md de cada semana

```markdown
# Semana X: [Título Descriptivo]

## 🎯 Objetivos de Aprendizaje

- [ ] Objetivo específico 1
- [ ] Objetivo específico 2
- [ ] Objetivo específico 3

## 📚 Contenido Teórico

[Contenido teórico detallado con ejemplos de código]

## 💻 Ejercicios Prácticos

1. Ejercicio 1: [Descripción]
2. Ejercicio 2: [Descripción]
3. Ejercicio 3: [Descripción]
4. Ejercicio 4: [Descripción]
5. Ejercicio 5: [Descripción]

## 🔨 Proyecto de la Semana

[Descripción del proyecto integrador semanal]

## 📖 Recursos

[Enlaces a documentación, videos, paquetes]

## ✅ Checklist de Completitud

- [ ] Ejercicio 1 completado
- [ ] Ejercicio 2 completado
- [ ] Ejercicio 3 completado
- [ ] Ejercicio 4 completado
- [ ] Ejercicio 5 completado
- [ ] Proyecto completado

## 🎓 Evaluación

- Ejercicios prácticos: X%
- Proyecto de la semana: Y%
- Calidad del código: Z%
```

## ⏱️ Dedicación Semanal

**Total: 8 horas por semana**

El tiempo se distribuye de manera flexible según el estudiante:

- **Estudio de teoría:** 2-3 horas
- **Ejercicios prácticos:** 2-3 horas
- **Proyecto semanal:** 3-4 horas

> **Nota:** La distribución del tiempo es sugerida. Cada estudiante puede organizar sus 8 horas semanales según su ritmo de aprendizaje y disponibilidad.

# Rúbrica de Evaluación - Semana X

## 📊 Distribución de Puntos

| Criterio  | Peso | Puntos  |
| --------- | ---- | ------- |
| Teoría    | 20%  | 20      |
| Prácticas | 30%  | 30      |
| Proyecto  | 50%  | 50      |
| **TOTAL** | 100% | **100** |

## 1️⃣ Evaluación Teórica (20 puntos)

### Comprensión de Conceptos (10 pts)

- **Excelente (9-10)**: Dominio completo...
- **Bueno (7-8)**: Comprensión sólida...
- **Suficiente (5-6)**: Entiende lo básico...
- **Insuficiente (0-4)**: Comprensión limitada...

### Aplicación de Conocimientos (10 pts)

[Criterios específicos...]

## 2️⃣ Prácticas (30 puntos)

[Detallar criterios por cada práctica...]

## 3️⃣ Proyecto Integrador (50 puntos)

### Funcionalidad (20 pts)

[Criterios...]

### Calidad del Código (15 pts)

[Criterios...]

### Mejores Prácticas (10 pts)

[Criterios...]

### Documentación (5 pts)

[Criterios...]

## 🎯 Escala de Calificación

- **90-100**: Excelente
- **80-89**: Muy Bueno
- **70-79**: Bueno
- **60-69**: Suficiente
- **0-59**: Insuficiente

---

## 💡 Estándares de Código

### Estructura de Widgets en Flutter

```dart
/**
 * Widget: UserProfileScreen
 *
 * ¿Qué hace?
 * Pantalla que muestra y permite editar el perfil del usuario
 *
 * ¿Para qué?
 * Centralizar toda la lógica de visualización y edición del perfil
 * Proporcionar una interfaz consistente para gestión de datos del usuario
 *
 * ¿Cómo funciona?
 * 1. Carga los datos del usuario desde el Provider
 * 2. Muestra un formulario con los datos actuales
 * 3. Valida los cambios antes de guardar
 * 4. Actualiza el perfil mediante la API
 * 5. Refleja los cambios en la UI y el estado global
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Modelo de datos
class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
}

class UserProfileScreen extends StatefulWidget {
  final String userId;
  final Function(User)? onUpdate;

  const UserProfileScreen({
    Key? key,
    required this.userId,
    this.onUpdate,
  }) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // Variables de estado
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Cargar datos del usuario al iniciar
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Lógica de carga
  }

  Future<void> _handleSubmit() async {
    // Lógica de envío
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Contenido del formulario
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Limpiar recursos
    super.dispose();
  }
}
```

### Organización de Archivos

```
lib/
├── main.dart              # Punto de entrada
├── app.dart               # Configuración de la app
├── core/
│   ├── constants/         # Constantes globales
│   ├── themes/            # Temas y estilos
│   └── utils/             # Utilidades
├── data/
│   ├── models/            # Modelos de datos
│   ├── repositories/      # Repositorios
│   └── services/          # Servicios (API, local storage)
├── domain/
│   ├── entities/          # Entidades de negocio
│   └── usecases/          # Casos de uso
├── presentation/
│   ├── screens/           # Pantallas
│   ├── widgets/           # Widgets reutilizables
│   └── providers/         # Estado (Provider/BLoC)
└── config/
    ├── routes.dart        # Configuración de rutas
    └── env.dart           # Variables de entorno
```

│ ├── layout/ # Layouts y contenedores
│ └── features/ # Componentes específicos por feature
├── hooks/ # Custom hooks
├── services/ # Lógica de negocio y APIs
├── contexts/ # Context API providers
├── utils/ # Funciones auxiliares
├── constants/ # Constantes y configuración
├── types/ # TypeScript types/interfaces
└── assets/ # Imágenes, fuentes, etc.

````

### Patrones Recomendados

1. **Stateless/Stateful Widgets** según necesidad
2. **Provider/BLoC** para estado global
3. **Composición** de widgets
4. **Separación de responsabilidades**
5. **Principio DRY** (Don't Repeat Yourself)
6. **Clean Architecture** para apps grandes
7. **Código declarativo** sobre imperativo

---

## 🧪 Testing y Validación

### Criterios de Aceptación

Todo código debe:

- ✅ Compilar sin errores
- ✅ Ejecutarse sin warnings críticos
- ✅ Seguir las convenciones de nomenclatura
- ✅ Estar completamente documentado
- ✅ Incluir manejo de errores
- ✅ Ser responsive y accesible
- ✅ Seguir las guías de estilo de Flutter

### Checklist de Calidad

```markdown
- [ ] Nomenclatura en inglés
- [ ] Comentarios explicativos (qué, para qué, cómo)
- [ ] Manejo de estados de carga
- [ ] Manejo de errores
- [ ] Validación de inputs
- [ ] Estilos consistentes
- [ ] Accesibilidad básica
- [ ] Performance optimizado
````

---

## 🎨 Guías de Estilo

### Widgets

- PascalCase: `UserProfile`, `LoginScreen`
- Sufijos descriptivos: `...Screen`, `...Widget`, `...Card`

### Funciones y Variables

- camelCase: `handlePress`, `isLoading`, `userData`
- Booleanos con prefijos: `is...`, `has...`, `should...`
- Handlers con prefijo: `handle...`, `on...`

### Constantes

- UPPER_SNAKE_CASE: `API_BASE_URL`, `MAX_ITEMS`

### Archivos

- kebab-case: `user-profile.dart`, `api-service.dart`
- Widgets: snake_case `user_profile.dart`

---

## 📚 Recursos de Aprendizaje

### Documentación Oficial

- Flutter: https://flutter.dev/docs
- Dart: https://dart.dev
- Material Design: https://material.io/design

### Mejores Prácticas

- Effective Dart Style Guide
- Flutter Best Practices
- Clean Architecture for Flutter

---

## 🚀 Progresión del Bootcamp

### Semana 1: Introducción a Dart I

**Dedicación:** 8 horas

- Fundamentos del lenguaje Dart
- Variables, tipos de datos y operadores
- Estructuras de control y funciones

### Semana 2: Introducción a Dart II y Fundamentos de Flutter

**Dedicación:** 8 horas

- Programación orientada a objetos en Dart
- Introducción a Flutter y su ecosistema
- Primer proyecto Flutter

### Semana 3: Widgets y Layouts en Flutter

**Dedicación:** 8 horas

- Widgets básicos y avanzados
- Sistema de layouts
- Diseño responsivo

### Semana 4: Navegación y Rutas

**Dedicación:** 8 horas

- Sistema de navegación
- Rutas nombradas
- Paso de datos entre pantallas

### Semana 5: Gestión de Estado

**Dedicación:** 8 horas

- setState y estado local
- Provider
- Introducción a otros gestores de estado

### Semana 6: Consumo de APIs y HTTP

**Dedicación:** 8 horas

- HTTP requests con Dart
- Modelos y serialización JSON
- Manejo de respuestas y errores

### Semana 7: Persistencia de Datos

**Dedicación:** 8 horas

- SharedPreferences
- SQLite y bases de datos locales
- Almacenamiento de archivos

### Semana 8: Características Nativas y Plugins

**Dedicación:** 8 horas

- Cámara y galería
- Geolocalización
- Notificaciones

### Semana 9: Arquitectura y Testing

**Dedicación:** 8 horas

- Clean Architecture
- Testing unitario y de widgets
- Buenas prácticas

### Semana 10: Proyecto Final y Deployment

**Dedicación:** 8 horas

- Integración de conocimientos
- Optimización y performance
- Preparación para publicación
- Deploy a producción

> **Nota:** Los tiempos de trabajo autónomo son sugerencias. Cada estudiante adapta según su ritmo y disponibilidad.

---

## ⚠️ Consideraciones Importantes

### Al Generar Código

1. **SIEMPRE** incluir comentarios educativos
2. **NUNCA** usar nomenclatura en español para código
3. **VERIFICAR** que el código compile y funcione
4. **EXPLICAR** el razonamiento detrás de las decisiones
5. **MOSTRAR** alternativas cuando sea relevante
6. **INCLUIR** ejemplos de uso

### Al Crear Contenido Teórico

1. Empezar con conceptos simples
2. Progresar gradualmente en complejidad
3. Incluir diagramas y visualizaciones
4. Proporcionar ejemplos del mundo real
5. Relacionar con conocimientos previos
6. Incluir ejercicios de reflexión

### Al Diseñar Prácticas

1. Incrementar dificultad progresivamente
2. Incluir soluciones comentadas
3. Proporcionar tests o criterios de validación
4. Ofrecer desafíos opcionales
5. Relacionar con el proyecto integrador

### Para la Sesión Presencial (6 horas)

1. **Estructura Clara:**

   - Introducción teórica (30-45 min por tema)
   - Demostración en vivo (15-20 min por concepto)
   - Práctica guiada (20-30 min por ejercicio)
   - Breaks cada 90 minutos (15 min)

2. **Contenido Interactivo:**

   - Código en vivo, no slides estáticas
   - Ejercicios hands-on inmediatos
   - Resolución de dudas en tiempo real
   - Code reviews grupales

3. **Material de Soporte:**
   - Repositorio con código de la sesión
   - Notas y referencias rápidas
   - Ejercicios para completar en clase
   - Asignación del proyecto semanal

### Para Trabajo Autónomo

1. **Instrucciones Detalladas:**

   - Paso a paso bien documentado
   - Objetivos específicos y medibles
   - Tiempo estimado por actividad
   - Criterios de auto-evaluación

2. **Recursos Complementarios:**

   - Videos de refuerzo (10-15 min)
   - Documentación oficial referenciada
   - Ejemplos de código adicionales
   - FAQs de problemas comunes

3. **Soporte Asíncrono:**
   - Foro de preguntas/respuestas
   - Office hours virtuales
   - Repositorio de soluciones
   - Peer programming sugerido

---

## 🎯 Objetivos de Aprendizaje del Bootcamp

Al completar el bootcamp, los estudiantes serán capaces de:

1. ✅ Crear aplicaciones móviles completas con Flutter
2. ✅ Implementar navegación compleja entre pantallas
3. ✅ Gestionar estado local y global eficientemente (Provider, BLoC)
4. ✅ Consumir APIs REST y manejar datos asíncronos
5. ✅ Aplicar mejores prácticas de desarrollo móvil
6. ✅ Escribir código limpio, mantenible y profesional en Dart
7. ✅ Publicar aplicaciones en tiendas (conceptos básicos)
8. ✅ Debuggear y optimizar aplicaciones móviles
9. ✅ Trabajar con features nativas (cámara, GPS, etc.)
10. ✅ Crear interfaces de usuario atractivas con Material Design y Cupertino

---

## 📞 Formato de Ayuda y Soporte

Cuando un estudiante pida ayuda:

1. Analizar el problema específico
2. Explicar el concepto subyacente
3. Proporcionar solución comentada
4. Sugerir recursos adicionales
5. Ofrecer ejercicios de refuerzo

---

## 🔄 Iteración y Mejora Continua

- Solicitar feedback constantemente
- Ajustar contenido según necesidades
- Mantener material actualizado
- Incorporar ejemplos del mundo real
- Actualizar a últimas versiones de librerías

---

## 📌 Recordatorios Finales

> **IMPORTANTE**: Este bootcamp forma desarrolladores profesionales. El estándar de calidad debe ser siempre alto. Cada línea de código es una oportunidad de enseñanza.

**Mantra del Bootcamp:**

- 🎯 Calidad primero, siempre
- 📚 Código que enseña
- 🌍 Inglés para código, español para explicar
- 💡 Mejores prácticas, no atajos
- 🚀 Preparar para el mundo real
