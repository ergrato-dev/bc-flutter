# 📊 Rúbrica de Evaluación - Semana 05

## Gestión de Estado en Flutter

---

## 📋 Información General

| Aspecto                 | Detalle           |
| ----------------------- | ----------------- |
| **Semana**              | 05                |
| **Tema**                | Gestión de Estado |
| **Puntuación Total**    | 100 puntos        |
| **Aprobación Mínima**   | 60 puntos         |
| **Dedicación Estimada** | 8 horas           |

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

#### Tipos de Estado (4 pts)

| Nivel            | Puntos | Criterio                                                                     |
| ---------------- | ------ | ---------------------------------------------------------------------------- |
| **Excelente**    | 4      | Distingue claramente estado efímero vs aplicación, sabe cuándo usar cada uno |
| **Bueno**        | 3      | Comprende la diferencia, aplica correctamente en la mayoría de casos         |
| **Suficiente**   | 2      | Entiende conceptos básicos pero confunde casos límite                        |
| **Insuficiente** | 0-1    | No distingue entre tipos de estado                                           |

#### setState y Ciclo de Vida (3 pts)

| Nivel            | Puntos | Criterio                                                   |
| ---------------- | ------ | ---------------------------------------------------------- |
| **Excelente**    | 3      | Domina setState, initState, dispose; evita errores comunes |
| **Bueno**        | 2      | Usa setState correctamente, conoce ciclo de vida básico    |
| **Suficiente**   | 1      | Usa setState pero con errores o sin limpiar recursos       |
| **Insuficiente** | 0      | No comprende setState ni ciclo de vida                     |

#### Provider y Alternativas (3 pts)

| Nivel            | Puntos | Criterio                                                         |
| ---------------- | ------ | ---------------------------------------------------------------- |
| **Excelente**    | 3      | Domina Provider, conoce BLoC/Riverpod, sabe cuándo usar cada uno |
| **Bueno**        | 2      | Implementa Provider correctamente, conoce alternativas           |
| **Suficiente**   | 1      | Usa Provider básico pero sin optimizaciones                      |
| **Insuficiente** | 0      | No logra implementar gestión de estado global                    |

### 1.2 Aplicación de Conocimientos (10 pts)

#### Selección de Solución (4 pts)

| Nivel            | Puntos | Criterio                                                  |
| ---------------- | ------ | --------------------------------------------------------- |
| **Excelente**    | 4      | Elige la solución correcta según complejidad y requisitos |
| **Bueno**        | 3      | Selecciona soluciones apropiadas en la mayoría de casos   |
| **Suficiente**   | 2      | Aplica soluciones funcionales aunque no óptimas           |
| **Insuficiente** | 0-1    | No puede seleccionar solución apropiada                   |

#### Optimización (3 pts)

| Nivel            | Puntos | Criterio                                         |
| ---------------- | ------ | ------------------------------------------------ |
| **Excelente**    | 3      | Usa Selector/select, evita rebuilds innecesarios |
| **Bueno**        | 2      | Aplica optimizaciones básicas                    |
| **Suficiente**   | 1      | Código funcional pero con rebuilds innecesarios  |
| **Insuficiente** | 0      | No considera rendimiento                         |

#### Depuración (3 pts)

| Nivel            | Puntos | Criterio                                          |
| ---------------- | ------ | ------------------------------------------------- |
| **Excelente**    | 3      | Usa DevTools para identificar problemas de estado |
| **Bueno**        | 2      | Debuggea usando logs y herramientas básicas       |
| **Suficiente**   | 1      | Detecta errores obvios                            |
| **Insuficiente** | 0      | No puede depurar problemas de estado              |

---

## 2️⃣ Prácticas (30 puntos)

### Distribución por Práctica

| Práctica    | Tema                    | Puntos     |
| ----------- | ----------------------- | ---------- |
| Práctica 01 | Estado Local (setState) | 5 pts      |
| Práctica 02 | Provider Cart           | 6 pts      |
| Práctica 03 | Selector Performance    | 6 pts      |
| Práctica 04 | BLoC/Cubit              | 6 pts      |
| Práctica 05 | Riverpod + Tests        | 7 pts      |
| **TOTAL**   |                         | **30 pts** |

---

### Práctica 01: Estado Local (5 pts) ⭐

**Lista de tareas con setState**

| Criterio          | Puntos | Descripción                                      |
| ----------------- | ------ | ------------------------------------------------ |
| **Funcionalidad** | 2      | Lista se actualiza, tareas se marcan completadas |
| **Ciclo de vida** | 1.5    | initState/dispose usados correctamente           |
| **Código**        | 1      | setState llamado apropiadamente                  |
| **Documentación** | 0.5    | Comentarios claros                               |

---

### Práctica 02: Provider Cart (6 pts) ⭐⭐

**Carrito con ChangeNotifier**

| Criterio             | Puntos | Descripción                              |
| -------------------- | ------ | ---------------------------------------- |
| **ChangeNotifier**   | 2      | Modelo implementado con notifyListeners  |
| **Provider setup**   | 2      | ChangeNotifierProvider en raíz           |
| **Consumer/context** | 1.5    | Uso correcto de Consumer o context.watch |
| **Código**           | 0.5    | Organización limpia                      |

---

### Práctica 03: Selector Performance (6 pts) ⭐⭐

**Optimización con Selector**

| Criterio            | Puntos | Descripción                         |
| ------------------- | ------ | ----------------------------------- |
| **Identificación**  | 2      | Detecta rebuilds innecesarios       |
| **Selector/select** | 2.5    | Implementa optimizaciones efectivas |
| **Medición**        | 1      | Demuestra mejora (logs o profiler)  |
| **Documentación**   | 0.5    | Explica las optimizaciones          |

---

### Práctica 04: BLoC/Cubit (6 pts) ⭐⭐⭐

**Carrito con Cubit**

| Criterio         | Puntos | Descripción                      |
| ---------------- | ------ | -------------------------------- |
| **Cubit**        | 2      | Implementación correcta con emit |
| **BlocProvider** | 1.5    | Setup correcto                   |
| **BlocBuilder**  | 1.5    | UI reactiva a estados            |
| **Tests**        | 1      | Tests básicos con bloc_test      |

---

### Práctica 05: Riverpod + Tests (7 pts) ⭐⭐⭐

**Carrito con Riverpod y pruebas**

| Criterio              | Puntos | Descripción                             |
| --------------------- | ------ | --------------------------------------- |
| **Provider Riverpod** | 2.5    | StateProvider o StateNotifier funcional |
| **UI con ref**        | 1.5    | watch/read usados correctamente         |
| **Tests**             | 2      | Tests unitarios para la lógica          |
| **Comparativa**       | 1      | Documenta diferencias con Provider/BLoC |

---

## 3️⃣ Proyecto Integrador: ShopApp (50 puntos)

### 3.1 Funcionalidad (20 pts)

#### Catálogo y Productos (6 pts)

| Criterio             | Puntos | Descripción                 |
| -------------------- | ------ | --------------------------- |
| **Lista productos**  | 2      | Grid/List con mock data     |
| **Detalle producto** | 2      | Navegación a detalle        |
| **Búsqueda/Filtro**  | 2      | Opcional: filtrar productos |

#### Carrito (8 pts)

| Criterio             | Puntos | Descripción                    |
| -------------------- | ------ | ------------------------------ |
| **Agregar items**    | 2      | Botón funcional desde producto |
| **Eliminar items**   | 2      | Remover del carrito            |
| **Contador AppBar**  | 2      | Badge con cantidad total       |
| **Pantalla carrito** | 2      | Lista de items con total       |

#### Extras (6 pts)

| Criterio           | Puntos | Descripción                |
| ------------------ | ------ | -------------------------- |
| **Favoritos**      | 2      | Marcar/desmarcar favoritos |
| **Persistencia**   | 2      | SharedPreferences o Hive   |
| **Perfil usuario** | 2      | Pantalla básica de perfil  |

---

### 3.2 Calidad del Código (15 pts)

#### Arquitectura (6 pts)

| Nivel            | Puntos | Criterio                                                    |
| ---------------- | ------ | ----------------------------------------------------------- |
| **Excelente**    | 5-6    | Separación clara: models, providers/state, screens, widgets |
| **Bueno**        | 3-4    | Buena organización con algunas inconsistencias              |
| **Suficiente**   | 1-2    | Organización básica                                         |
| **Insuficiente** | 0      | Sin estructura clara                                        |

**Estructura Esperada:**

```
lib/
├── main.dart
├── models/
│   └── product.dart
├── providers/ (o state/)
│   ├── cart_provider.dart
│   └── favorites_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├── product_detail.dart
│   └── cart_screen.dart
└── widgets/
    └── product_card.dart
```

#### Nomenclatura y Estilo (5 pts)

| Criterio         | Puntos | Descripción                            |
| ---------------- | ------ | -------------------------------------- |
| **Inglés**       | 2      | Todo el código en inglés               |
| **Convenciones** | 1.5    | PascalCase clases, camelCase variables |
| **Consistencia** | 1.5    | Estilo uniforme                        |

#### Documentación (4 pts)

| Criterio          | Puntos | Descripción          |
| ----------------- | ------ | -------------------- |
| **Qué hace**      | 1.5    | Widgets documentados |
| **Para qué**      | 1      | Propósito explicado  |
| **Cómo funciona** | 1.5    | Lógica comentada     |

---

### 3.3 Gestión de Estado (10 pts)

#### Implementación Provider/Riverpod (5 pts)

| Nivel            | Puntos | Criterio                                                   |
| ---------------- | ------ | ---------------------------------------------------------- |
| **Excelente**    | 5      | ChangeNotifier bien estructurado, notifyListeners correcto |
| **Bueno**        | 3-4    | Implementación funcional                                   |
| **Suficiente**   | 1-2    | Funciona pero con problemas                                |
| **Insuficiente** | 0      | No usa gestión de estado global                            |

#### Optimización (3 pts)

| Criterio            | Puntos | Descripción                         |
| ------------------- | ------ | ----------------------------------- |
| **Selector/select** | 1.5    | Usado donde aplica                  |
| **No rebuilds**     | 1.5    | Evita reconstrucciones innecesarias |

#### Separación de Lógica (2 pts)

| Criterio            | Puntos | Descripción                                           |
| ------------------- | ------ | ----------------------------------------------------- |
| **Lógica separada** | 2      | Providers no tienen UI, UI no tiene lógica de negocio |

---

### 3.4 UI/UX y Testing (5 pts)

| Criterio             | Puntos | Descripción                               |
| -------------------- | ------ | ----------------------------------------- |
| **UI limpia**        | 2      | Diseño agradable y funcional              |
| **Feedback usuario** | 1      | Indicadores de carga, mensajes            |
| **Tests básicos**    | 2      | Al menos tests para la lógica del carrito |

---

## 📈 Escala de Calificación Final

| Rango      | Calificación    | Descripción                             |
| ---------- | --------------- | --------------------------------------- |
| **90-100** | ⭐ Excelente    | Dominio completo de gestión de estado   |
| **80-89**  | ✅ Muy Bueno    | Comprensión sólida con detalles menores |
| **70-79**  | 👍 Bueno        | Buen entendimiento, áreas a mejorar     |
| **60-69**  | ⚠️ Suficiente   | Conocimientos básicos adquiridos        |
| **0-59**   | ❌ Insuficiente | Requiere refuerzo significativo         |

---

## 📝 Checklist de Evaluación

### Evaluación Teórica (20 pts)

- [ ] Tipos de Estado (/4)
- [ ] setState y Ciclo de Vida (/3)
- [ ] Provider y Alternativas (/3)
- [ ] Selección de Solución (/4)
- [ ] Optimización (/3)
- [ ] Depuración (/3)

### Prácticas (30 pts)

- [ ] Práctica 01: Estado Local (/5)
- [ ] Práctica 02: Provider Cart (/6)
- [ ] Práctica 03: Selector Performance (/6)
- [ ] Práctica 04: BLoC/Cubit (/6)
- [ ] Práctica 05: Riverpod + Tests (/7)

### Proyecto ShopApp (50 pts)

- [ ] Catálogo y Productos (/6)
- [ ] Carrito (/8)
- [ ] Extras (/6)
- [ ] Arquitectura (/6)
- [ ] Nomenclatura y Estilo (/5)
- [ ] Documentación (/4)
- [ ] Implementación Estado (/5)
- [ ] Optimización (/3)
- [ ] Separación Lógica (/2)
- [ ] UI/UX y Testing (/5)

---

## 🎯 Competencias Evaluadas

| Competencia       | Indicador                                  |
| ----------------- | ------------------------------------------ |
| **Estado Local**  | Usa setState y ciclo de vida correctamente |
| **Provider**      | Implementa ChangeNotifier y Consumer       |
| **Optimización**  | Aplica Selector para evitar rebuilds       |
| **BLoC/Cubit**    | Conoce patrón alternativo                  |
| **Riverpod**      | Conoce alternativa moderna                 |
| **Testing**       | Escribe tests para lógica de estado        |
| **Arquitectura**  | Separa lógica de presentación              |
| **Código Limpio** | Escribe código organizado y documentado    |

---

## 📚 Referencias

- [Teoría Semana 05](./1-teoria/)
- [Prácticas](./2-practicas/)
- [Proyecto](./3-proyecto/)
- [Recursos](./4-recursos/)
- [Glosario](./5-glosario/)

---

_Rúbrica Semana 05 - Gestión de Estado en Flutter_  
_Bootcamp Flutter - 100 puntos totales_
