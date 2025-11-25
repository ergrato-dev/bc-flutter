# 📊 Rúbrica de Evaluación - Semana 04

## Navegación y Rutas en Flutter

---

## 📋 Información General

| Aspecto                 | Detalle            |
| ----------------------- | ------------------ |
| **Semana**              | 04                 |
| **Tema**                | Navegación y Rutas |
| **Puntuación Total**    | 100 puntos         |
| **Aprobación Mínima**   | 60 puntos          |
| **Dedicación Estimada** | 8 horas            |

---

## 📊 Distribución de Puntos

| Componente          | Peso     | Puntos  |
| ------------------- | -------- | ------- |
| Evaluación Teórica  | 20%      | 20      |
| Prácticas (5)       | 30%      | 30      |
| Proyecto Integrador | 50%      | 50      |
| **TOTAL**           | **100%** | **100** |

---

## 1️⃣ Evaluación Teórica (20 puntos)

### 1.1 Comprensión de Conceptos (10 pts)

#### Navigator Stack y Operaciones (4 pts)

| Nivel            | Puntos | Criterio                                                                                                                       |
| ---------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------ |
| **Excelente**    | 4      | Domina completamente el concepto de stack LIFO, explica push/pop/replace con precisión, entiende el ciclo de vida de las rutas |
| **Bueno**        | 3      | Comprende el stack y las operaciones básicas, puede explicar cuándo usar cada una                                              |
| **Suficiente**   | 2      | Entiende push y pop básico pero confunde casos complejos como replace                                                          |
| **Insuficiente** | 0-1    | No comprende el funcionamiento del Navigator stack                                                                             |

#### Rutas Nombradas y Arguments (3 pts)

| Nivel            | Puntos | Criterio                                                                      |
| ---------------- | ------ | ----------------------------------------------------------------------------- |
| **Excelente**    | 3      | Domina rutas nombradas, onGenerateRoute, paso de argumentos y su recuperación |
| **Bueno**        | 2      | Implementa rutas nombradas correctamente, entiende el paso de datos básico    |
| **Suficiente**   | 1      | Configura rutas nombradas pero tiene dificultades con argumentos              |
| **Insuficiente** | 0      | No logra implementar rutas nombradas funcionales                              |

#### Navegación Avanzada (3 pts)

| Nivel            | Puntos | Criterio                                                               |
| ---------------- | ------ | ---------------------------------------------------------------------- |
| **Excelente**    | 3      | Comprende BottomNav, Drawer, TabBar, IndexedStack y navegación anidada |
| **Bueno**        | 2      | Implementa correctamente BottomNav y Drawer, entiende IndexedStack     |
| **Suficiente**   | 1      | Implementa navegación básica con tabs pero sin preservar estado        |
| **Insuficiente** | 0      | No logra implementar navegación por pestañas funcional                 |

### 1.2 Aplicación de Conocimientos (10 pts)

#### Identificación de Patrones (4 pts)

| Nivel            | Puntos | Criterio                                                            |
| ---------------- | ------ | ------------------------------------------------------------------- |
| **Excelente**    | 4      | Identifica correctamente qué patrón usar para cada caso de uso real |
| **Bueno**        | 3      | Reconoce la mayoría de patrones y sus aplicaciones                  |
| **Suficiente**   | 2      | Identifica patrones básicos pero duda en casos complejos            |
| **Insuficiente** | 0-1    | No puede asociar patrones con casos de uso                          |

#### Resolución de Problemas (3 pts)

| Nivel            | Puntos | Criterio                                                |
| ---------------- | ------ | ------------------------------------------------------- |
| **Excelente**    | 3      | Resuelve problemas de navegación complejos sin ayuda    |
| **Bueno**        | 2      | Resuelve la mayoría de problemas con mínima orientación |
| **Suficiente**   | 1      | Necesita guía significativa para resolver problemas     |
| **Insuficiente** | 0      | No puede resolver problemas de navegación               |

#### Depuración (3 pts)

| Nivel            | Puntos | Criterio                                                     |
| ---------------- | ------ | ------------------------------------------------------------ |
| **Excelente**    | 3      | Identifica y corrige errores de navegación usando DevTools   |
| **Bueno**        | 2      | Encuentra la mayoría de errores con herramientas de debug    |
| **Suficiente**   | 1      | Detecta errores obvios pero tiene dificultad con los sutiles |
| **Insuficiente** | 0      | No puede identificar ni corregir errores de navegación       |

---

## 2️⃣ Prácticas (30 puntos)

### Distribución por Práctica

| Práctica    | Tema                         | Puntos     |
| ----------- | ---------------------------- | ---------- |
| Práctica 01 | Navegación Básica (Push/Pop) | 5 pts      |
| Práctica 02 | Rutas Nombradas              | 6 pts      |
| Práctica 03 | Bottom Navigation            | 6 pts      |
| Práctica 04 | Drawer Menu                  | 6 pts      |
| Práctica 05 | App Multinivel               | 7 pts      |
| **TOTAL**   |                              | **30 pts** |

---

### Práctica 01: Navegación Básica (5 pts) ⭐

**Aplicación de lista de tareas con navegación push/pop**

| Criterio          | Puntos | Descripción                                                    |
| ----------------- | ------ | -------------------------------------------------------------- |
| **Funcionalidad** | 2      | Navigator.push funciona, pop retorna datos correctamente       |
| **Código**        | 1.5    | MaterialPageRoute implementado, manejo de async/await correcto |
| **UX**            | 1      | Transiciones fluidas, botón back funcional                     |
| **Documentación** | 0.5    | Comentarios claros explicando el flujo                         |

#### Criterios Detallados

**Funcionalidad (2 pts)**

- ✅ (2 pts) Push navega correctamente, pop retorna resultado, UI se actualiza
- ⚠️ (1 pt) Push funciona pero pop no retorna datos o no actualiza UI
- ❌ (0 pts) Navegación no funciona o genera errores

**Código (1.5 pts)**

- ✅ (1.5 pts) Código limpio, MaterialPageRoute correcto, async/await bien usado
- ⚠️ (0.75 pts) Funciona pero con código desordenado o redundante
- ❌ (0 pts) Errores de implementación significativos

---

### Práctica 02: Rutas Nombradas (6 pts) ⭐⭐

**Catálogo de productos con rutas centralizadas**

| Criterio            | Puntos | Descripción                                                  |
| ------------------- | ------ | ------------------------------------------------------------ |
| **Configuración**   | 2      | MaterialApp routes configurado, AppRoutes class implementada |
| **Argumentos**      | 2      | Paso y recuperación de argumentos funcionando                |
| **onGenerateRoute** | 1      | Manejo de rutas dinámicas implementado                       |
| **Documentación**   | 1      | Código documentado, constantes bien definidas                |

#### Criterios Detallados

**Configuración (2 pts)**

- ✅ (2 pts) Rutas centralizadas en clase, nomenclatura consistente, initialRoute definida
- ⚠️ (1 pt) Rutas funcionan pero sin centralizar o con nomenclatura inconsistente
- ❌ (0 pts) Configuración incorrecta o incompleta

**Argumentos (2 pts)**

- ✅ (2 pts) Arguments pasados y recuperados correctamente con tipado
- ⚠️ (1 pt) Funciona pero sin validación o tipado débil
- ❌ (0 pts) No logra pasar/recuperar argumentos

---

### Práctica 03: Bottom Navigation (6 pts) ⭐⭐

**App social con navegación por pestañas**

| Criterio                | Puntos | Descripción                                       |
| ----------------------- | ------ | ------------------------------------------------- |
| **BottomNavigationBar** | 2      | Widget configurado correctamente, items definidos |
| **IndexedStack**        | 2      | Estado preservado entre tabs, sin reconstrucción  |
| **Interacción**         | 1.5    | Cambio de tabs fluido, indicador visual correcto  |
| **Código**              | 0.5    | Estructura limpia, separación de widgets          |

#### Criterios Detallados

**IndexedStack (2 pts)**

- ✅ (2 pts) Estado completamente preservado, scroll position mantenida, sin rebuilds
- ⚠️ (1 pt) Funciona pero pierde estado parcialmente o hay rebuilds innecesarios
- ❌ (0 pts) No preserva estado o no usa IndexedStack

---

### Práctica 04: Drawer Menu (6 pts) ⭐⭐⭐

**App empresarial con menú lateral**

| Criterio       | Puntos | Descripción                                      |
| -------------- | ------ | ------------------------------------------------ |
| **Drawer**     | 2      | Drawer implementado con DrawerHeader y ListTiles |
| **Navegación** | 2      | Pop antes de push, rutas nombradas desde drawer  |
| **UI/UX**      | 1.5    | Diseño profesional, iconografía consistente      |
| **Extras**     | 0.5    | Indicador de sección activa, responsive          |

#### Criterios Detallados

**Navegación desde Drawer (2 pts)**

- ✅ (2 pts) Cierra drawer antes de navegar, sin duplicación de pantallas, flujo correcto
- ⚠️ (1 pt) Navega pero drawer queda abierto o hay duplicación
- ❌ (0 pts) Navegación desde drawer no funciona correctamente

---

### Práctica 05: App Multinivel (7 pts) ⭐⭐⭐

**E-commerce con navegación compleja**

| Criterio               | Puntos | Descripción                                              |
| ---------------------- | ------ | -------------------------------------------------------- |
| **Arquitectura**       | 2.5    | Estructura de navegación bien diseñada, separación clara |
| **Navegación Anidada** | 2      | Múltiples niveles funcionando, GlobalKeys si necesario   |
| **PopScope**           | 1.5    | Back button controlado, confirmación de salida           |
| **Integración**        | 1      | BottomNav + rutas nombradas + argumentos combinados      |

#### Criterios Detallados

**Navegación Anidada (2 pts)**

- ✅ (2 pts) Múltiples navigators coordinados, cada tab con su stack
- ⚠️ (1 pt) Funciona parcialmente, algunos tabs pierden estado
- ❌ (0 pts) No implementa navegación anidada o no funciona

**PopScope (1.5 pts)**

- ✅ (1.5 pts) Back button interceptado correctamente, confirmación de salida funcional
- ⚠️ (0.75 pts) Implementado pero con comportamiento inconsistente
- ❌ (0 pts) No implementa control del back button

---

## 3️⃣ Proyecto Integrador: TravelApp (50 puntos)

### 3.1 Funcionalidad (20 pts)

#### Navegación Principal (8 pts)

| Criterio      | Puntos | Descripción                             |
| ------------- | ------ | --------------------------------------- |
| **BottomNav** | 3      | 4 tabs funcionando con IndexedStack     |
| **Drawer**    | 2      | Menú lateral con navegación secundaria  |
| **Rutas**     | 3      | Sistema de rutas nombradas centralizado |

**Escala de Evaluación:**

- **Excelente (7-8 pts)**: Toda la navegación funciona perfectamente, transiciones fluidas
- **Bueno (5-6 pts)**: Navegación funcional con detalles menores
- **Suficiente (3-4 pts)**: Funcionalidad básica presente pero incompleta
- **Insuficiente (0-2 pts)**: Navegación no funcional o muy incompleta

#### Flujos de Usuario (8 pts)

| Criterio     | Puntos | Descripción                              |
| ------------ | ------ | ---------------------------------------- |
| **Explorar** | 2      | Lista → Detalle → Reservar fluido        |
| **Reservas** | 2      | Ver, crear, editar, cancelar reservas    |
| **Perfil**   | 2      | Edición de perfil, navegación a settings |
| **Datos**    | 2      | Paso de datos entre pantallas correcto   |

**Escala de Evaluación:**

- **Excelente (7-8 pts)**: Todos los flujos funcionan sin errores
- **Bueno (5-6 pts)**: Flujos principales funcionan, algunos detalles faltantes
- **Suficiente (3-4 pts)**: Solo flujos básicos implementados
- **Insuficiente (0-2 pts)**: Flujos rotos o muy incompletos

#### Pantallas Requeridas (4 pts)

| Pantalla                | Puntos | Requisito                        |
| ----------------------- | ------ | -------------------------------- |
| HomeScreen              | 0.5    | Lista de destinos destacados     |
| ExploreScreen           | 0.5    | Búsqueda y filtros               |
| DestinationDetailScreen | 0.5    | Detalle completo con acciones    |
| BookingsScreen          | 0.5    | Lista de reservas del usuario    |
| BookingDetailScreen     | 0.5    | Detalle de reserva               |
| ProfileScreen           | 0.5    | Información del usuario          |
| SettingsScreen          | 0.5    | Configuración de la app          |
| Otras                   | 0.5    | Pantallas adicionales necesarias |

---

### 3.2 Calidad del Código (15 pts)

#### Arquitectura (6 pts)

| Nivel            | Puntos | Criterio                                                                                                      |
| ---------------- | ------ | ------------------------------------------------------------------------------------------------------------- |
| **Excelente**    | 5-6    | Estructura clara de carpetas, separación de responsabilidades, AppRoutes centralizado, modelos bien definidos |
| **Bueno**        | 3-4    | Buena organización con algunas inconsistencias menores                                                        |
| **Suficiente**   | 1-2    | Organización básica pero funcional                                                                            |
| **Insuficiente** | 0      | Sin estructura clara, código desorganizado                                                                    |

**Estructura Esperada:**

```
lib/
├── main.dart
├── app.dart
├── config/
│   └── routes.dart          // AppRoutes
├── models/
│   ├── destination.dart
│   ├── booking.dart
│   └── user.dart
├── screens/
│   ├── home/
│   ├── explore/
│   ├── bookings/
│   ├── profile/
│   └── settings/
└── widgets/
    └── navigation/
```

#### Nomenclatura y Estilo (5 pts)

| Criterio         | Puntos | Descripción                                                |
| ---------------- | ------ | ---------------------------------------------------------- |
| **Inglés**       | 2      | Todo el código en inglés (variables, funciones, clases)    |
| **Convenciones** | 1.5    | PascalCase para clases, camelCase para variables/funciones |
| **Consistencia** | 1.5    | Estilo uniforme en todo el proyecto                        |

**Penalizaciones:**

- -0.5 pts por cada variable/función en español
- -0.5 pts por mezcla de convenciones de naming
- -0.5 pts por formateo inconsistente

#### Documentación del Código (4 pts)

| Criterio          | Puntos | Descripción                                      |
| ----------------- | ------ | ------------------------------------------------ |
| **Qué hace**      | 1.5    | Cada widget/función documentado con su propósito |
| **Para qué**      | 1      | Contexto del uso y beneficios explicados         |
| **Cómo funciona** | 1.5    | Lógica compleja comentada paso a paso            |

**Ejemplo Esperado:**

```dart
/**
 * Widget: DestinationDetailScreen
 *
 * ¿Qué hace?
 * Muestra información detallada de un destino turístico
 * y permite al usuario iniciar una reserva.
 *
 * ¿Para qué?
 * Proporciona toda la información necesaria para que el
 * usuario tome una decisión de reserva informada.
 *
 * ¿Cómo funciona?
 * 1. Recibe el destino como argumento de navegación
 * 2. Muestra galería, descripción, precio y reviews
 * 3. El botón "Reservar" navega a BookingFormScreen
 * 4. Retorna el resultado de la reserva al pop
 */
class DestinationDetailScreen extends StatelessWidget {
  // ...
}
```

---

### 3.3 Mejores Prácticas de Navegación (10 pts)

#### Gestión del Stack (4 pts)

| Criterio              | Puntos | Descripción                                         |
| --------------------- | ------ | --------------------------------------------------- |
| **Push/Pop correcto** | 1.5    | Uso apropiado de push, pop, pushReplacement         |
| **No duplicación**    | 1      | Sin pantallas duplicadas en el stack                |
| **Limpieza**          | 1.5    | pushAndRemoveUntil donde corresponde (logout, etc.) |

#### Preservación de Estado (3 pts)

| Criterio            | Puntos | Descripción                                         |
| ------------------- | ------ | --------------------------------------------------- |
| **IndexedStack**    | 1.5    | Estado de tabs preservado correctamente             |
| **Scroll position** | 1      | Posición de scroll mantenida al volver              |
| **Form data**       | 0.5    | Datos de formularios no se pierden innecesariamente |

#### Manejo del Back Button (3 pts)

| Criterio           | Puntos | Descripción                                         |
| ------------------ | ------ | --------------------------------------------------- |
| **PopScope**       | 1.5    | Implementado donde es necesario                     |
| **Confirmación**   | 1      | Diálogo de confirmación al salir de flujos críticos |
| **Comportamiento** | 0.5    | Back button se comporta como espera el usuario      |

---

### 3.4 UI/UX de Navegación (5 pts)

| Criterio          | Puntos | Descripción                                    |
| ----------------- | ------ | ---------------------------------------------- |
| **Transiciones**  | 1.5    | Animaciones fluidas y apropiadas               |
| **Indicadores**   | 1.5    | Tab activo, sección actual claramente indicada |
| **Consistencia**  | 1      | Patrones de navegación uniformes               |
| **Accesibilidad** | 1      | Navegación usable, áreas táctiles apropiadas   |

---

## 📈 Escala de Calificación Final

| Rango      | Calificación | Descripción                                 |
| ---------- | ------------ | ------------------------------------------- |
| **90-100** | Excelente    | Dominio completo de navegación en Flutter   |
| **80-89**  | Muy Bueno    | Comprensión sólida con detalles menores     |
| **70-79**  | Bueno        | Buen entendimiento, algunas áreas a mejorar |
| **60-69**  | Suficiente   | Conocimientos básicos adquiridos            |
| **0-59**   | Insuficiente | Requiere refuerzo significativo             |

---

## 📝 Checklist de Evaluación

### Evaluación Teórica (20 pts)

- [ ] Comprensión de Navigator Stack (/4)
- [ ] Rutas Nombradas y Arguments (/3)
- [ ] Navegación Avanzada (/3)
- [ ] Identificación de Patrones (/4)
- [ ] Resolución de Problemas (/3)
- [ ] Depuración (/3)

### Prácticas (30 pts)

- [ ] Práctica 01: Navegación Básica (/5)
- [ ] Práctica 02: Rutas Nombradas (/6)
- [ ] Práctica 03: Bottom Navigation (/6)
- [ ] Práctica 04: Drawer Menu (/6)
- [ ] Práctica 05: App Multinivel (/7)

### Proyecto TravelApp (50 pts)

- [ ] Navegación Principal (/8)
- [ ] Flujos de Usuario (/8)
- [ ] Pantallas Requeridas (/4)
- [ ] Arquitectura (/6)
- [ ] Nomenclatura y Estilo (/5)
- [ ] Documentación (/4)
- [ ] Gestión del Stack (/4)
- [ ] Preservación de Estado (/3)
- [ ] Manejo Back Button (/3)
- [ ] UI/UX Navegación (/5)

---

## 🎯 Competencias Evaluadas

Al completar esta semana, el estudiante demuestra capacidad para:

| Competencia               | Indicador                                   |
| ------------------------- | ------------------------------------------- |
| **Navegación Imperativa** | Implementa Navigator.push/pop correctamente |
| **Rutas Declarativas**    | Configura y usa rutas nombradas             |
| **Paso de Datos**         | Transfiere información entre pantallas      |
| **Navegación por Tabs**   | Implementa BottomNav con estado preservado  |
| **Menús Laterales**       | Crea Drawer funcional con navegación        |
| **Navegación Anidada**    | Maneja múltiples navigators                 |
| **UX de Navegación**      | Crea flujos intuitivos y consistentes       |
| **Código Limpio**         | Escribe código organizado y documentado     |

---

## 📚 Referencias

- [Documentación Teoría](./1-teoria/)
- [Prácticas Detalladas](./2-practicas/)
- [Especificación del Proyecto](./3-proyecto/)
- [Recursos de Apoyo](./4-recursos/)
- [Glosario de Términos](./5-glosario/)

---

## 📞 Soporte

Si tienes dudas sobre los criterios de evaluación:

1. Revisa los ejemplos en cada práctica
2. Consulta el glosario de términos
3. Contacta al instructor

---

_Rúbrica Semana 04 - Navegación y Rutas en Flutter_  
_Bootcamp Flutter - 100 puntos totales_
