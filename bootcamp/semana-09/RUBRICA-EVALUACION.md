# 📊 Rúbrica de Evaluación - Semana 9

## Arquitectura y Testing

**Duración:** 8 horas | **Puntuación máxima:** 100 puntos

---

## 📋 Distribución General

| Componente         | Peso | Puntos  |
| ------------------ | ---- | ------- |
| Teoría             | 15%  | 15      |
| Prácticas (5)      | 35%  | 35      |
| Proyecto Semanal   | 40%  | 40      |
| Calidad del Código | 10%  | 10      |
| **TOTAL**          | 100% | **100** |

---

## 1️⃣ Evaluación Teórica (15 puntos)

### 1.1 Clean Architecture (5 puntos)

| Nivel            | Puntos | Descripción                                                                       |
| ---------------- | ------ | --------------------------------------------------------------------------------- |
| **Excelente**    | 5      | Explica correctamente las 3 capas, flujo de dependencias y principio de inversión |
| **Bueno**        | 4      | Comprende las capas y sus responsabilidades, menor claridad en dependencias       |
| **Suficiente**   | 3      | Identifica las capas básicas pero confunde responsabilidades                      |
| **Insuficiente** | 0-2    | No comprende la separación de capas ni el flujo de datos                          |

### 1.2 Testing (5 puntos)

| Nivel            | Puntos | Descripción                                                                     |
| ---------------- | ------ | ------------------------------------------------------------------------------- |
| **Excelente**    | 5      | Domina pirámide de tests, diferencia unit/widget/integration, conoce patrón AAA |
| **Bueno**        | 4      | Comprende tipos de tests y cuándo usar cada uno                                 |
| **Suficiente**   | 3      | Conoce conceptos básicos pero confunde cuándo aplicar cada tipo                 |
| **Insuficiente** | 0-2    | No diferencia tipos de tests ni su propósito                                    |

### 1.3 SOLID y DI (5 puntos)

| Nivel            | Puntos | Descripción                                                                 |
| ---------------- | ------ | --------------------------------------------------------------------------- |
| **Excelente**    | 5      | Explica los 5 principios SOLID con ejemplos, comprende DI y Service Locator |
| **Bueno**        | 4      | Comprende mayoría de principios SOLID y beneficios de DI                    |
| **Suficiente**   | 3      | Conoce algunos principios pero sin aplicación práctica clara                |
| **Insuficiente** | 0-2    | No comprende SOLID ni inyección de dependencias                             |

---

## 2️⃣ Prácticas (35 puntos)

### Práctica 1: Estructura Clean Architecture (7 puntos)

| Criterio                        | Puntos | Descripción                                        |
| ------------------------------- | ------ | -------------------------------------------------- |
| Estructura de carpetas          | 3      | Domain/Data/Presentation correctamente organizados |
| Separación de responsabilidades | 2      | Cada capa con archivos apropiados                  |
| Nomenclatura                    | 2      | Nombres descriptivos en inglés                     |

**Rúbrica detallada:**

| Nivel            | Puntos | Indicadores                                                                   |
| ---------------- | ------ | ----------------------------------------------------------------------------- |
| **Excelente**    | 7      | Estructura completa, todos los archivos en su lugar, nomenclatura profesional |
| **Bueno**        | 5-6    | Estructura correcta con pequeñas omisiones                                    |
| **Suficiente**   | 3-4    | Estructura básica pero incompleta o con errores de ubicación                  |
| **Insuficiente** | 0-2    | Estructura incorrecta o muy incompleta                                        |

### Práctica 2: Tests Unitarios (7 puntos)

| Criterio           | Puntos | Descripción                          |
| ------------------ | ------ | ------------------------------------ |
| Cobertura de casos | 3      | Tests para éxito, error y edge cases |
| Uso de mocks       | 2      | Mockito implementado correctamente   |
| Patrón AAA         | 2      | Arrange-Act-Assert bien estructurado |

**Rúbrica detallada:**

| Nivel            | Puntos | Indicadores                                                  |
| ---------------- | ------ | ------------------------------------------------------------ |
| **Excelente**    | 7      | 5+ tests, mocks correctos, AAA claro, assertions específicas |
| **Bueno**        | 5-6    | 3-4 tests, mocks funcionales, estructura correcta            |
| **Suficiente**   | 3-4    | Tests básicos, mocking limitado                              |
| **Insuficiente** | 0-2    | Tests incorrectos o no funcionales                           |

### Práctica 3: Widget Tests (7 puntos)

| Criterio            | Puntos | Descripción                                   |
| ------------------- | ------ | --------------------------------------------- |
| Uso de WidgetTester | 2      | pumpWidget, pump, pumpAndSettle correctos     |
| Finders             | 2      | find.byType, find.text, find.byKey apropiados |
| Interacciones       | 3      | tap, enterText, drag correctamente simulados  |

**Rúbrica detallada:**

| Nivel            | Puntos | Indicadores                                    |
| ---------------- | ------ | ---------------------------------------------- |
| **Excelente**    | 7      | Tests completos de UI, interacciones y estados |
| **Bueno**        | 5-6    | Tests de renderizado y algunas interacciones   |
| **Suficiente**   | 3-4    | Tests básicos de existencia de widgets         |
| **Insuficiente** | 0-2    | Tests que no ejecutan o incorrectos            |

### Práctica 4: BLoC Tests (7 puntos)

| Criterio                | Puntos | Descripción                                 |
| ----------------------- | ------ | ------------------------------------------- |
| Uso de bloc_test        | 3      | blocTest() con build, act, expect correctos |
| Estados verificados     | 2      | Secuencia de estados correcta               |
| Mocking de repositorios | 2      | Dependencias mockeadas correctamente        |

**Rúbrica detallada:**

| Nivel            | Puntos | Indicadores                                   |
| ---------------- | ------ | --------------------------------------------- |
| **Excelente**    | 7      | Tests completos de eventos, estados y errores |
| **Bueno**        | 5-6    | Tests de flujo principal con mocks            |
| **Suficiente**   | 3-4    | Tests básicos de BLoC                         |
| **Insuficiente** | 0-2    | No usa bloc_test o tests incorrectos          |

### Práctica 5: Integration Tests (7 puntos)

| Criterio       | Puntos | Descripción                         |
| -------------- | ------ | ----------------------------------- |
| Flujo completo | 3      | Test end-to-end de feature completo |
| Setup/Teardown | 2      | Configuración y limpieza correctas  |
| Assertions     | 2      | Verificaciones en puntos clave      |

**Rúbrica detallada:**

| Nivel            | Puntos | Indicadores                                  |
| ---------------- | ------ | -------------------------------------------- |
| **Excelente**    | 7      | Flujo completo testado, múltiples escenarios |
| **Bueno**        | 5-6    | Flujo principal testado correctamente        |
| **Suficiente**   | 3-4    | Test de integración básico                   |
| **Insuficiente** | 0-2    | No implementa test de integración            |

---

## 3️⃣ Proyecto: TaskManager Pro (40 puntos)

### 3.1 Arquitectura Clean (12 puntos)

| Criterio          | Puntos | Descripción                                      |
| ----------------- | ------ | ------------------------------------------------ |
| Capa Domain       | 4      | Entities, Use Cases, Repository interfaces       |
| Capa Data         | 4      | Models, Repository implementations, Data sources |
| Capa Presentation | 4      | BLoC/Provider, Screens, Widgets                  |

**Rúbrica:**

| Nivel            | Puntos | Indicadores                                               |
| ---------------- | ------ | --------------------------------------------------------- |
| **Excelente**    | 11-12  | 3 capas completas, dependencias correctas, SOLID aplicado |
| **Bueno**        | 8-10   | Capas definidas con algunas violaciones menores           |
| **Suficiente**   | 5-7    | Estructura reconocible pero incompleta                    |
| **Insuficiente** | 0-4    | No sigue Clean Architecture                               |

### 3.2 Funcionalidades CRUD (10 puntos)

| Funcionalidad  | Puntos | Descripción                             |
| -------------- | ------ | --------------------------------------- |
| Crear tarea    | 2.5    | Formulario con validación               |
| Listar tareas  | 2.5    | Lista con estados loading/error/success |
| Editar tarea   | 2.5    | Edición con actualización               |
| Eliminar tarea | 2.5    | Eliminación con confirmación            |

**Rúbrica:**

| Nivel            | Puntos | Indicadores                             |
| ---------------- | ------ | --------------------------------------- |
| **Excelente**    | 9-10   | CRUD completo, validaciones, UX fluida  |
| **Bueno**        | 7-8    | CRUD funcional con validaciones básicas |
| **Suficiente**   | 4-6    | 2-3 operaciones funcionando             |
| **Insuficiente** | 0-3    | CRUD incompleto o no funcional          |

### 3.3 Testing (12 puntos)

| Tipo de Test | Puntos | Requisitos                               |
| ------------ | ------ | ---------------------------------------- |
| Unit Tests   | 4      | Mínimo 5 tests de use cases/repositories |
| Widget Tests | 4      | Mínimo 3 tests de widgets principales    |
| BLoC Tests   | 4      | Mínimo 3 tests de estados del BLoC       |

**Rúbrica:**

| Nivel            | Puntos | Indicadores                              |
| ---------------- | ------ | ---------------------------------------- |
| **Excelente**    | 11-12  | 15+ tests, coverage > 60%, todos pasando |
| **Bueno**        | 8-10   | 10-14 tests, coverage > 40%              |
| **Suficiente**   | 5-7    | 5-9 tests básicos                        |
| **Insuficiente** | 0-4    | < 5 tests o tests fallando               |

### 3.4 Inyección de Dependencias (6 puntos)

| Criterio                 | Puntos | Descripción                                 |
| ------------------------ | ------ | ------------------------------------------- |
| Configuración DI         | 2      | get_it/injectable configurado correctamente |
| Registro de dependencias | 2      | Todas las dependencias registradas          |
| Uso en widgets           | 2      | Inyección utilizada correctamente           |

**Rúbrica:**

| Nivel            | Puntos | Indicadores                                        |
| ---------------- | ------ | -------------------------------------------------- |
| **Excelente**    | 6      | DI completo, lazy singletons, factories apropiados |
| **Bueno**        | 4-5    | DI funcional con configuración correcta            |
| **Suficiente**   | 2-3    | DI básico pero incompleto                          |
| **Insuficiente** | 0-1    | No implementa DI o incorrecto                      |

---

## 4️⃣ Calidad del Código (10 puntos)

### 4.1 Estilo y Convenciones (4 puntos)

| Criterio               | Puntos | Descripción                   |
| ---------------------- | ------ | ----------------------------- |
| Nomenclatura en inglés | 1.5    | Variables, funciones, clases  |
| Formato Dart           | 1.5    | dart format aplicado          |
| Linting                | 1      | Sin warnings de flutter_lints |

### 4.2 Documentación (3 puntos)

| Criterio              | Puntos | Descripción                         |
| --------------------- | ------ | ----------------------------------- |
| Comentarios de clase  | 1      | Documentación de clases principales |
| Comentarios de método | 1      | Documentación de métodos públicos   |
| README del proyecto   | 1      | Instrucciones de instalación y uso  |

### 4.3 Organización (3 puntos)

| Criterio               | Puntos | Descripción                             |
| ---------------------- | ------ | --------------------------------------- |
| Estructura de archivos | 1.5    | Organización lógica y consistente       |
| Imports organizados    | 1.5    | Dart/Flutter/package/relative ordenados |

**Rúbrica general calidad:**

| Nivel            | Puntos | Indicadores                                   |
| ---------------- | ------ | --------------------------------------------- |
| **Excelente**    | 9-10   | Código profesional, documentado, sin warnings |
| **Bueno**        | 7-8    | Código limpio con documentación parcial       |
| **Suficiente**   | 5-6    | Código funcional pero desorganizado           |
| **Insuficiente** | 0-4    | Código difícil de leer, sin documentación     |

---

## 📈 Escala de Calificación Final

| Rango  | Calificación     | Descripción                                    |
| ------ | ---------------- | ---------------------------------------------- |
| 90-100 | **Excelente**    | Dominio completo de arquitectura y testing     |
| 80-89  | **Muy Bueno**    | Sólida comprensión con áreas de mejora menores |
| 70-79  | **Bueno**        | Comprensión adecuada, necesita práctica        |
| 60-69  | **Suficiente**   | Conocimientos básicos, requiere refuerzo       |
| 0-59   | **Insuficiente** | No alcanza objetivos mínimos                   |

---

## ✅ Checklist de Entrega

### Estructura del Proyecto

- [ ] Carpeta `lib/` con estructura Clean Architecture
- [ ] Carpeta `test/` con tests organizados por tipo
- [ ] Archivo `pubspec.yaml` con dependencias correctas
- [ ] Archivo `README.md` del proyecto

### Código

- [ ] Entities en `domain/entities/`
- [ ] Use Cases en `domain/usecases/`
- [ ] Repository interfaces en `domain/repositories/`
- [ ] Models en `data/models/`
- [ ] Repository implementations en `data/repositories/`
- [ ] BLoC/Provider en `presentation/bloc/` o `presentation/providers/`
- [ ] Screens en `presentation/screens/`
- [ ] Widgets en `presentation/widgets/`
- [ ] DI configuration en `injection.dart` o `di/`

### Tests

- [ ] Unit tests para Use Cases
- [ ] Unit tests para Repositories
- [ ] Widget tests para Screens principales
- [ ] Widget tests para Widgets reutilizables
- [ ] BLoC tests con bloc_test

### Documentación

- [ ] README con instrucciones de ejecución
- [ ] Comentarios dartdoc en clases principales
- [ ] Diagramas de arquitectura (opcional)

---

## 🎯 Criterios de Aprobación

Para **aprobar** la Semana 9, el estudiante debe:

1. ✅ Obtener mínimo **60 puntos** en total
2. ✅ Completar al menos **3 de 5 prácticas** con nota ≥ 4/7
3. ✅ Entregar el proyecto con:
   - Estructura Clean Architecture reconocible
   - Al menos 2 operaciones CRUD funcionando
   - Mínimo 5 tests pasando
4. ✅ Código que compile sin errores

---

## 📝 Formato de Retroalimentación

```markdown
## Retroalimentación - Semana 9

**Estudiante:** [Nombre]
**Fecha:** [DD/MM/YYYY]

### Puntuación

| Componente | Puntos Obtenidos | Puntos Máximos |
| ---------- | ---------------- | -------------- |
| Teoría     | /15              | 15             |
| Prácticas  | /35              | 35             |
| Proyecto   | /40              | 40             |
| Calidad    | /10              | 10             |
| **TOTAL**  | **/**            | **100**        |

### Fortalezas

-

### Áreas de Mejora

-

### Recomendaciones

-

### Calificación Final: [EXCELENTE/MUY BUENO/BUENO/SUFICIENTE/INSUFICIENTE]
```

---

## 🔄 Criterios de Recuperación

Si el estudiante no aprueba:

1. **Prácticas:** Puede rehacer prácticas específicas (máximo 2 intentos)
2. **Proyecto:** Puede entregar versión mejorada en 1 semana
3. **Teoría:** Puede realizar evaluación oral complementaria

**Puntuación máxima en recuperación:** 70 puntos

---

> **Nota:** Esta rúbrica está diseñada para evaluar comprensión y aplicación práctica de Clean Architecture y Testing en Flutter. Se valora tanto el conocimiento teórico como la capacidad de implementación.
