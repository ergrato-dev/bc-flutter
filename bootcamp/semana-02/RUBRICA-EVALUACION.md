# 📊 Rúbrica de Evaluación - Semana 02

> **Curso**: Bootcamp Flutter  
> **Semana**: 02 - POO en Dart y Fundamentos de Flutter  
> **Puntuación Total**: 100 puntos  
> **Duración**: 8 horas dedicación semanal

---

## 🎯 Distribución General de Puntos

| Categoría | Peso | Puntos | Descripción |
|-----------|------|--------|-------------|
| **1. POO en Dart** | 30% | 30 pts | Clases, herencia, mixins, polimorfismo |
| **2. Colecciones** | 20% | 20 pts | List, Map, Set y operaciones |
| **3. Flutter Básico** | 30% | 30 pts | Widgets, estado, ciclo de vida |
| **4. Proyecto Integrador** | 20% | 20 pts | Agenda Personal Digital |
| **TOTAL** | 100% | **100 pts** | |

---

## 1️⃣ POO en Dart (30 puntos)

### 1.1 Práctica 01: Sistema de Biblioteca (10 puntos)

| Criterio | Excelente<br>(9-10) | Bueno<br>(7-8) | Suficiente<br>(5-6) | Insuficiente<br>(0-4) |
|----------|---------------------|----------------|---------------------|------------------------|
| **Herencia** | Implementa correctamente herencia con `extends`, usa `super` apropiadamente, override de métodos bien aplicado | Herencia funcional, pequeños errores en `super` o `@override` | Herencia básica funciona, múltiples errores conceptuales | No implementa herencia o código no compila |
| **Encapsulamiento** | Usa modificadores privados (`_`), getters/setters bien aplicados, lógica protegida | Algunos miembros privados, getters/setters presentes | Encapsulamiento mínimo, mayoría de campos públicos | Sin encapsulamiento |
| **Polimorfismo** | Demuestra polimorfismo con tipos base y métodos sobrescritos correctamente | Polimorfismo presente pero implementación simple | Intenta polimorfismo con errores | No aplica polimorfismo |
| **Calidad Código** | Código limpio, bien documentado, nombres descriptivos, sin warnings | Código funcional, documentación básica, algunos warnings | Código funciona con múltiples warnings, poca documentación | Código desorganizado |

**Puntuación**:
- 9-10: Dominio completo de POO, implementación profesional
- 7-8: Comprensión sólida, pequeños detalles mejorables
- 5-6: Entiende conceptos básicos, errores de implementación
- 0-4: No demuestra comprensión de POO

---

### 1.2 Práctica 03: Sistema de Habilidades con Mixins (10 puntos)

| Criterio | Excelente<br>(9-10) | Bueno<br>(7-8) | Suficiente<br>(5-6) | Insuficiente<br>(0-4) |
|----------|---------------------|----------------|---------------------|------------------------|
| **Uso de Mixins** | Múltiples mixins correctamente aplicados con `with`, sin constructores en mixins | Mixins funcionales, comprende diferencia con herencia | Usa mixins básicamente, confusión con herencia | No usa mixins o código no compila |
| **Composición** | Demuestra composición efectiva, combina mixins lógicamente | Composición presente, combinación básica | Intenta composición con errores | Sin composición o solo herencia |
| **Interfaces** | Implementa interfaces con `implements`, cumple contratos | Interfaces presentes, implementación simple | Interfaces básicas, errores en implementación | No usa interfaces |

**Puntuación**:
- 9-10: Domina mixins y composición, código elegante
- 7-8: Entiende mixins, aplicación correcta
- 5-6: Usa mixins básicamente, conceptos confusos
- 0-4: No comprende mixins

---

### 1.3 Modelos del Proyecto (Task, Note, Contact) (10 puntos)

| Criterio | Excelente<br>(9-10) | Bueno<br>(7-8) | Suficiente<br>(5-6) | Insuficiente<br>(0-4) |
|----------|---------------------|----------------|---------------------|------------------------|
| **Diseño de Clases** | Modelos bien estructurados, propiedades apropiadas, constructores eficientes (named, factory) | Modelos funcionales, constructores básicos | Modelos con propiedades, constructores simples | Modelos mal diseñados o incompletos |
| **Métodos de Negocio** | Métodos útiles implementados (ej: `markComplete()`, `toggleFavorite()`), lógica encapsulada | Algunos métodos presentes, funcionales | Métodos mínimos o mal implementados | Sin métodos de negocio |
| **Enums y Constantes** | Usa enums para estados/categorías, constantes bien definidas | Enums presentes, uso básico | Intenta usar enums con errores | Usa strings mágicos en lugar de enums |

**Puntuación**:
- 9-10: Modelos profesionales, bien diseñados
- 7-8: Modelos funcionales y correctos
- 5-6: Modelos básicos que funcionan
- 0-4: Modelos deficientes o no compilan

---

## 2️⃣ Colecciones en Dart (20 puntos)

### 2.1 Práctica 02: Gestor de Tareas con Colecciones (10 puntos)

| Criterio | Excelente<br>(9-10) | Bueno<br>(7-8) | Suficiente<br>(5-6) | Insuficiente<br>(0-4) |
|----------|---------------------|----------------|---------------------|------------------------|
| **Uso de List** | Usa List con métodos avanzados (`map`, `where`, `fold`), operaciones eficientes | List con métodos básicos (`add`, `remove`, `where`) | List con operaciones simples, bucles manuales | Uso básico o incorrecto de List |
| **Uso de Map** | Map para agrupaciones/indexación, métodos avanzados (`putIfAbsent`, `update`) | Map funcional, operaciones básicas | Map presente, uso limitado | No usa Map o uso incorrecto |
| **Transformaciones** | Encadena operaciones (`where().map().toList()`), usa programación funcional | Algunas transformaciones, menos elegante | Transformaciones mínimas, bucles tradicionales | No transforma colecciones |

**Puntuación**:
- 9-10: Domina colecciones y métodos funcionales
- 7-8: Usa colecciones correctamente
- 5-6: Conocimientos básicos de colecciones
- 0-4: No maneja colecciones adecuadamente

---

### 2.2 Services del Proyecto (Managers) (10 puntos)

| Criterio | Excelente<br>(9-10) | Bueno<br>(7-8) | Suficiente<br>(5-6) | Insuficiente<br>(0-4) |
|----------|---------------------|----------------|---------------------|------------------------|
| **Gestión de Datos** | Services mantienen colecciones eficientemente, CRUD completo implementado | CRUD funcional, gestión básica de colecciones | CRUD parcial, gestión simple | CRUD incompleto o no funcional |
| **Operaciones Avanzadas** | Filtros, búsquedas, ordenamiento implementados con métodos funcionales | Algunas operaciones avanzadas, métodos básicos | Operaciones mínimas | Sin operaciones avanzadas |
| **Organización** | Services bien separados, responsabilidades claras, código reutilizable | Services organizados, separación básica | Services presentes pero desorganizados | Sin services o mezclados con UI |

**Puntuación**:
- 9-10: Services profesionales y eficientes
- 7-8: Services funcionales y organizados
- 5-6: Services básicos que funcionan
- 0-4: Services deficientes o inexistentes

---

## 3️⃣ Flutter Básico (30 puntos)

### 3.1 Práctica 04: Hola Mundo Flutter (5 puntos)

| Criterio | Excelente<br>(5) | Bueno<br>(4) | Suficiente<br>(3) | Insuficiente<br>(0-2) |
|----------|------------------|--------------|-------------------|-----------------------|
| **StatelessWidget** | StatelessWidget correcto, estructura apropiada, personalización | Widget funcional, estructura básica | Widget funciona, errores menores | No compila o estructura incorrecta |
| **Material Design** | Usa Scaffold, AppBar, personaliza tema y estilos | Scaffold y AppBar presentes, estilos básicos | Widgets mínimos | Sin estructura Material |

---

### 3.2 Práctica 05: Contador Flutter (10 puntos)

| Criterio | Excelente<br>(9-10) | Bueno<br>(7-8) | Suficiente<br>(5-6) | Insuficiente<br>(0-4) |
|----------|---------------------|----------------|---------------------|------------------------|
| **StatefulWidget** | StatefulWidget correcto, `createState()` apropiado, estructura profesional | StatefulWidget funcional, estructura básica | Widget funciona, errores menores | No usa StatefulWidget correctamente |
| **Manejo de Estado** | Usa `setState()` correctamente, estado bien gestionado, sin rebuilds innecesarios | `setState()` funcional, gestión básica | `setState()` presente con errores | Mal uso de `setState()` |
| **Interactividad** | Múltiples botones (+, -, reset), lógica completa, feedback visual | Botones funcionales, lógica básica | Interactividad mínima | Sin interactividad o no funciona |

**Puntuación**:
- 9-10: Domina StatefulWidget y estado local
- 7-8: Entiende y aplica correctamente
- 5-6: Uso básico funcional
- 0-4: No comprende estado

---

### 3.3 Navegación en Proyecto (15 puntos)

| Criterio | Excelente<br>(14-15) | Bueno<br>(11-13) | Suficiente<br>(8-10) | Insuficiente<br>(0-7) |
|----------|----------------------|------------------|----------------------|-----------------------|
| **Navigator** | Navegación completa entre 4 pantallas, `push`/`pop` correctos, stack bien manejado | Navegación funcional entre pantallas, básico push/pop | Navegación limitada, algunos errores | Sin navegación o no funciona |
| **Paso de Datos** | Pasa datos entre pantallas correctamente (constructores, arguments) | Pasa datos básicamente | Intenta pasar datos con errores | No pasa datos |
| **UX** | Flujo lógico, botones de navegación claros, back button funciona | Navegación entendible, UX aceptable | Navegación confusa | UX deficiente |

**Puntuación**:
- 14-15: Navegación profesional y fluida
- 11-13: Navegación funcional y correcta
- 8-10: Navegación básica que funciona
- 0-7: Navegación deficiente

---

## 4️⃣ Proyecto Integrador: Agenda Personal Digital (20 puntos)

### 4.1 Funcionalidad CRUD (10 puntos)

#### TasksScreen (3.3 puntos)
| Criterio | Excelente<br>(3-3.3) | Bueno<br>(2.5-2.9) | Suficiente<br>(1.7-2.4) | Insuficiente<br>(0-1.6) |
|----------|----------------------|---------------------|--------------------------|--------------------------|
| **CRUD Completo** | Create, Read, Update, Delete totalmente funcionales | CRUD funciona, pequeños bugs | CRUD parcial funcional | CRUD incompleto |
| **Features Extra** | Filtros (prioridad, estado), búsqueda, estadísticas | Algunos filtros o búsqueda | Features mínimas | Sin features extra |

#### NotesScreen (3.3 puntos)
| Criterio | Excelente<br>(3-3.3) | Bueno<br>(2.5-2.9) | Suficiente<br>(1.7-2.4) | Insuficiente<br>(0-1.6) |
|----------|----------------------|---------------------|--------------------------|--------------------------|
| **CRUD Completo** | Create, Read, Update, Delete totalmente funcionales | CRUD funciona, pequeños bugs | CRUD parcial funcional | CRUD incompleto |
| **Layout** | GridView bien implementado, categorías funcionales, favoritos | Grid funcional, categorías básicas | Layout simple | Layout deficiente |

#### ContactsScreen (3.4 puntos)
| Criterio | Excelente<br>(3.1-3.4) | Bueno<br>(2.5-3.0) | Suficiente<br>(1.7-2.4) | Insuficiente<br>(0-1.6) |
|----------|-------------------------|---------------------|--------------------------|--------------------------|
| **CRUD Completo** | Create, Read, Update, Delete totalmente funcionales | CRUD funciona, pequeños bugs | CRUD parcial funcional | CRUD incompleto |
| **Alfabético** | Lista alfabética con secciones, búsqueda, avatars | Lista alfabética funcional | Lista simple | Sin ordenamiento |

---

### 4.2 Calidad del Código (5 puntos)

| Criterio | Excelente<br>(5) | Bueno<br>(4) | Suficiente<br>(3) | Insuficiente<br>(0-2) |
|----------|------------------|--------------|-------------------|-----------------------|
| **Organización** | Código bien estructurado (models/, services/, screens/), separación de responsabilidades | Organización presente, algunos archivos mezclados | Organización básica | Sin organización |
| **Limpieza** | Sin código comentado, sin warnings, nombres descriptivos, formato consistente | Código limpio, pocos warnings | Algunos warnings, código funcional | Muchos warnings, código sucio |
| **Documentación** | Comentarios útiles, clases documentadas, README presente | Documentación básica | Comentarios mínimos | Sin documentación |

---

### 4.3 UX/UI y Diseño (5 puntos)

| Criterio | Excelente<br>(5) | Bueno<br>(4) | Suficiente<br>(3) | Insuficiente<br>(0-2) |
|----------|------------------|--------------|-------------------|-----------------------|
| **Usabilidad** | App intuitiva, flujo lógico, botones claros, feedback visual | Usable, lógico, feedback básico | Funciona pero confuso | Difícil de usar |
| **Diseño Visual** | Colores consistentes, tipografía apropiada, espaciado correcto, íconos | Diseño aceptable, consistencia básica | Diseño simple pero funcional | Sin atención al diseño |
| **Responsive** | Adapta a diferentes tamaños, padding/margin apropiados | Funciona en tamaños comunes | Funciona en un tamaño | No responsive |

---

## 📊 Escala de Calificación Final

| Puntuación | Nivel | Descripción | Acción Recomendada |
|------------|-------|-------------|--------------------|
| **90-100** | 🏆 **Excelente** | Dominio completo de POO, colecciones y Flutter. Proyecto profesional. | Listo para Semana 03. Considera compartir tu proyecto. |
| **80-89** | ⭐ **Muy Bueno** | Comprensión sólida de conceptos. Implementación correcta. Pequeños detalles mejorables. | Listo para Semana 03. Revisa feedback para pulir detalles. |
| **70-79** | ✅ **Bueno** | Entiende conceptos fundamentales. Proyecto funcional. Algunos errores conceptuales. | Listo para Semana 03. Refuerza POO o colecciones según necesidad. |
| **60-69** | 🔄 **Suficiente** | Conocimientos básicos. Proyecto funciona pero limitado. Requiere refuerzo. | Repasa material antes de Semana 03. Practica ejercicios adicionales. |
| **0-59** | ❌ **Insuficiente** | No alcanza objetivos mínimos. Proyecto incompleto o no funcional. | REPETIR Semana 02. Revisar teoría desde inicio. Pedir ayuda. |

---

## 🎯 Objetivos de Aprendizaje por Puntuación

### Para Obtener 90-100 (Excelente)

Debes demostrar:
- ✅ Dominio de clases, herencia, mixins, interfaces
- ✅ Uso avanzado de colecciones con métodos funcionales
- ✅ StatelessWidget y StatefulWidget correctos
- ✅ Navegación completa y fluida
- ✅ Proyecto CRUD completo con features extra
- ✅ Código limpio, organizado y documentado
- ✅ UI/UX profesional

### Para Obtener 70-89 (Aprobado Bien)

Debes demostrar:
- ✅ Comprensión de POO (clases, herencia, básico)
- ✅ Uso funcional de colecciones (List, Map)
- ✅ StatefulWidget con setState() correcto
- ✅ Navegación básica funcional
- ✅ Proyecto CRUD funcional (puede faltar alguna feature)
- ✅ Código funcional (puede tener warnings menores)

### Para Obtener 60-69 (Suficiente)

Mínimo aceptable:
- ✅ Clases básicas funcionales
- ✅ Usa List y Map básicamente
- ✅ StatefulWidget funciona
- ✅ Navegación entre al menos 2 pantallas
- ✅ CRUD parcial implementado
- ✅ Código compila y ejecuta

---

## 📋 Autoevaluación Rápida

Antes de entregar, verifica:

**POO (30 pts)**:
- [ ] Práctica 01 completada y funcional
- [ ] Práctica 03 con mixins implementados
- [ ] Modelos Task, Note, Contact bien diseñados

**Colecciones (20 pts)**:
- [ ] Práctica 02 completada
- [ ] Services usan colecciones eficientemente
- [ ] Filtros y búsquedas funcionan

**Flutter (30 pts)**:
- [ ] Práctica 04 y 05 completadas
- [ ] Navegación funcional entre 4 pantallas
- [ ] setState() usado correctamente

**Proyecto (20 pts)**:
- [ ] CRUD completo en Tasks, Notes, Contacts
- [ ] Código organizado en carpetas
- [ ] UI usable y diseño aceptable
- [ ] App ejecuta sin crashes críticos

---

## 🔗 Recursos para Mejorar

**Si tienes dificultades con**:

**POO** (<70%):
- Repasa: [`1-teoria/01-poo-dart.md`](1-teoria/01-poo-dart.md)
- Videos: [`4-recursos/01-videos-poo.md`](4-recursos/01-videos-poo.md)
- Artículos: [`4-recursos/06-articulos-poo.md`](4-recursos/06-articulos-poo.md)

**Colecciones** (<70%):
- Repasa: [`1-teoria/02-colecciones-estructuras.md`](1-teoria/02-colecciones-estructuras.md)
- Videos: [`4-recursos/02-videos-colecciones.md`](4-recursos/02-videos-colecciones.md)

**Flutter** (<70%):
- Repasa: [`1-teoria/03-intro-flutter.md`](1-teoria/03-intro-flutter.md)
- Videos: [`4-recursos/03-videos-flutter-intro.md`](4-recursos/03-videos-flutter-intro.md)
- Docs: [`4-recursos/08-documentacion-oficial.md`](4-recursos/08-documentacion-oficial.md)

**Proyecto**:
- Guía: [`3-proyecto/README.md`](3-proyecto/README.md)
- Ejemplos: Revisa código de las pantallas implementadas

---

## 💬 Feedback y Entrega

### Formato de Entrega

**Repositorio Git** (recomendado):
```
github.com/tu-usuario/agenda-personal-flutter
```

**O Archivo ZIP**:
```
nombre-apellido-semana02.zip
├── proyecto/
│   └── [código Flutter completo]
├── practicas/
│   ├── practica-01.dart
│   ├── practica-02.dart
│   └── practica-03.dart
└── README.md (breve descripción y screenshots)
```

### Incluir

1. **Código Completo**: Todo el proyecto Flutter
2. **README.md**: Descripción, features, cómo ejecutar
3. **Screenshots**: 3-5 capturas de pantallas principales
4. **Video Demo** (opcional): 1-2 min mostrando funcionalidad

### Plazo

- Fecha límite: Final de Semana 02
- Enviar a: [plataforma del bootcamp]

---

## ⏰ Tiempo de Evaluación

**Auto-evaluación**: 30 minutos  
**Revisión por instructor**: 45-60 minutos por estudiante  
**Feedback**: Dentro de 48-72 horas

---

**Versión**: 1.0 | **Actualizado**: Noviembre 2025 | **Semana**: 02
