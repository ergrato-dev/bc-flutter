# 📊 Rúbrica de Evaluación - Semana 06

## 🎯 Consumo de APIs y HTTP

**Puntuación Total:** 100 puntos

---

## 📋 Distribución de Puntos

| Componente          | Peso | Puntos  |
| ------------------- | ---- | ------- |
| Teoría y Conceptos  | 15%  | 15      |
| Prácticas (5)       | 35%  | 35      |
| Proyecto Integrador | 50%  | 50      |
| **TOTAL**           | 100% | **100** |

---

## 1️⃣ Teoría y Conceptos (15 puntos)

### Comprensión de HTTP y REST (8 pts)

| Nivel            | Puntos | Criterios                                                                                                                 |
| ---------------- | ------ | ------------------------------------------------------------------------------------------------------------------------- |
| **Excelente**    | 7-8    | Domina métodos HTTP, códigos de estado, headers. Entiende REST y sus principios. Conoce diferencias entre POST/PUT/PATCH. |
| **Bueno**        | 5-6    | Comprende la mayoría de conceptos HTTP. Puede explicar request/response. Conoce los métodos principales.                  |
| **Suficiente**   | 3-4    | Entiende conceptos básicos. Sabe hacer GET y POST. Reconoce códigos 200, 404, 500.                                        |
| **Insuficiente** | 0-2    | Confunde métodos HTTP. No entiende el ciclo request-response.                                                             |

### Comprensión de Async/Serialización (7 pts)

| Nivel            | Puntos | Criterios                                                                           |
| ---------------- | ------ | ----------------------------------------------------------------------------------- |
| **Excelente**    | 6-7    | Domina Future, async/await, serialización JSON. Entiende modelos y fromJson/toJson. |
| **Bueno**        | 4-5    | Usa correctamente async/await. Puede crear modelos básicos con serialización.       |
| **Suficiente**   | 2-3    | Usa Future básico. Puede parsear JSON simple.                                       |
| **Insuficiente** | 0-1    | No entiende programación asíncrona.                                                 |

---

## 2️⃣ Prácticas (35 puntos)

### Práctica 01: JSONPlaceholder API (7 pts)

| Criterio                                    | Puntos |
| ------------------------------------------- | ------ |
| GET request funcional                       | 2      |
| Modelo User correcto                        | 2      |
| Manejo de estados (loading, error, success) | 2      |
| Código limpio y documentado                 | 1      |

### Práctica 02: CRUD Completo (7 pts)

| Criterio                   | Puntos |
| -------------------------- | ------ |
| POST - Crear recurso       | 2      |
| PUT/PATCH - Actualizar     | 2      |
| DELETE - Eliminar          | 2      |
| Feedback visual al usuario | 1      |

### Práctica 03: FutureBuilder Lista (7 pts)

| Criterio                   | Puntos |
| -------------------------- | ------ |
| FutureBuilder implementado | 2      |
| Estado de carga correcto   | 2      |
| Estado de error con retry  | 2      |
| UI pulida                  | 1      |

### Práctica 04: Dio e Interceptores (7 pts)

| Criterio                      | Puntos |
| ----------------------------- | ------ |
| Dio configurado correctamente | 2      |
| LogInterceptor funcional      | 2      |
| AuthInterceptor básico        | 2      |
| Manejo de errores de Dio      | 1      |

### Práctica 05: Búsqueda en Tiempo Real (7 pts)

| Criterio                  | Puntos |
| ------------------------- | ------ |
| Debounce implementado     | 2      |
| Cancelación de peticiones | 2      |
| UI de búsqueda responsiva | 2      |
| Historial de búsquedas    | 1      |

---

## 3️⃣ Proyecto Integrador: News Reader App (50 puntos)

### Funcionalidad (20 pts)

| Criterio        | Puntos | Descripción                                       |
| --------------- | ------ | ------------------------------------------------- |
| **Home Screen** | 4      | Top headlines, cards de noticias, pull-to-refresh |
| **Categorías**  | 3      | Chips funcionales, filtrado correcto              |
| **Búsqueda**    | 5      | Debounce, resultados, historial                   |
| **Detalle**     | 3      | Imagen, contenido, abrir en navegador             |
| **Favoritos**   | 4      | Agregar/quitar, persistencia local                |
| **Navegación**  | 1      | BottomNavigationBar funcional                     |

### Consumo de API (12 pts)

| Criterio              | Puntos | Descripción                             |
| --------------------- | ------ | --------------------------------------- |
| **Service Layer**     | 4      | NewsService bien estructurado           |
| **Modelos**           | 3      | Article, Source, NewsResponse correctos |
| **Manejo de Errores** | 3      | Excepciones tipadas, mensajes claros    |
| **Headers/Auth**      | 2      | API key configurada, headers correctos  |

### Calidad del Código (10 pts)

| Criterio          | Puntos | Descripción                                 |
| ----------------- | ------ | ------------------------------------------- |
| **Arquitectura**  | 3      | Separación de capas clara                   |
| **Nomenclatura**  | 2      | Variables/funciones en inglés, descriptivas |
| **Documentación** | 2      | Comentarios útiles, README                  |
| **DRY**           | 2      | Sin código repetido                         |
| **Type Safety**   | 1      | Tipos correctos, null safety                |

### UX/UI (8 pts)

| Criterio               | Puntos | Descripción                       |
| ---------------------- | ------ | --------------------------------- |
| **Estados de Carga**   | 2      | Shimmer o indicadores apropiados  |
| **Estados de Error**   | 2      | Mensajes claros, opción retry     |
| **Estados Vacíos**     | 2      | Ilustración o mensaje informativo |
| **Diseño Consistente** | 2      | Colores, tipografía, espaciado    |

---

## 🎁 Puntos Extra (hasta +10)

| Criterio                 | Puntos |
| ------------------------ | ------ |
| Tema claro/oscuro        | +3     |
| Animaciones/transiciones | +2     |
| Paginación infinita      | +3     |
| Tests unitarios          | +2     |

---

## 📈 Escala de Calificación

| Rango   | Calificación     | Descripción                                     |
| ------- | ---------------- | ----------------------------------------------- |
| 90-100+ | **Excelente**    | Dominio completo. Código profesional.           |
| 80-89   | **Muy Bueno**    | Buen dominio. Pequeñas mejoras posibles.        |
| 70-79   | **Bueno**        | Comprensión sólida. Algunos aspectos a mejorar. |
| 60-69   | **Suficiente**   | Cumple requisitos mínimos. Necesita práctica.   |
| 0-59    | **Insuficiente** | No cumple requisitos. Requiere refuerzo.        |

---

## ✅ Checklist de Entrega

### Prácticas

- [ ] Práctica 01 completada y funcional
- [ ] Práctica 02 completada y funcional
- [ ] Práctica 03 completada y funcional
- [ ] Práctica 04 completada y funcional
- [ ] Práctica 05 completada y funcional

### Proyecto

- [ ] Código fuente en repositorio
- [ ] README con instrucciones de ejecución
- [ ] API key configurada (no expuesta)
- [ ] Capturas de pantalla o video demo
- [ ] App funcional sin errores críticos

---

## 📝 Criterios de Evaluación del Código

### Excelente (90-100%)

```dart
// ✅ Arquitectura clara
// ✅ Modelos tipados correctamente
// ✅ Manejo de errores robusto
// ✅ Código documentado
// ✅ UI responsiva con todos los estados
```

### Bueno (70-89%)

```dart
// ✅ Funcionalidad completa
// ⚠️ Algunos comentarios faltan
// ⚠️ Manejo de errores básico
// ✅ UI funcional
```

### Suficiente (60-69%)

```dart
// ✅ Funcionalidad básica
// ⚠️ Código desorganizado
// ⚠️ Sin manejo de errores
// ⚠️ UI incompleta
```

### Insuficiente (<60%)

```dart
// ❌ No compila o tiene errores críticos
// ❌ Funcionalidad incompleta
// ❌ No consume API correctamente
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
