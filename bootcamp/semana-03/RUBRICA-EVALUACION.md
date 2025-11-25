# 📊 Rúbrica de Evaluación - Semana 03

> **Tema:** Widgets y Layouts en Flutter  
> **Puntuación máxima:** 100 puntos  
> **Aprobación mínima:** 60 puntos

---

## 📋 Distribución de Puntos

| Componente           | Peso     | Puntos  |
| -------------------- | -------- | ------- |
| Teoría y Comprensión | 20%      | 20      |
| Prácticas (5)        | 30%      | 30      |
| Proyecto Integrador  | 50%      | 50      |
| **TOTAL**            | **100%** | **100** |

---

## 1️⃣ Evaluación Teórica (20 puntos)

### 1.1 Comprensión de Widgets (10 pts)

| Nivel            | Puntos | Criterios                                                                                                                                                 |
| ---------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Excelente**    | 9-10   | Explica correctamente el árbol de widgets, diferencia StatelessWidget y StatefulWidget, comprende el ciclo de vida y sabe cuándo usar cada tipo de widget |
| **Bueno**        | 7-8    | Comprende la mayoría de conceptos, puede explicar widgets básicos y sus propiedades principales                                                           |
| **Suficiente**   | 5-6    | Entiende conceptos básicos de widgets, puede crear interfaces simples                                                                                     |
| **Insuficiente** | 0-4    | Confusión entre tipos de widgets, no comprende la jerarquía ni propiedades                                                                                |

### 1.2 Dominio de Layouts (10 pts)

| Nivel            | Puntos | Criterios                                                                                                                                                               |
| ---------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Excelente**    | 9-10   | Domina Column, Row, Stack, ListView, GridView. Comprende MainAxisAlignment, CrossAxisAlignment, Expanded y Flexible. Sabe elegir el layout correcto para cada situación |
| **Bueno**        | 7-8    | Usa correctamente los layouts principales, comprende alineaciones y distribución de espacio                                                                             |
| **Suficiente**   | 5-6    | Puede crear layouts básicos con Column y Row, entiende conceptos de alineación                                                                                          |
| **Insuficiente** | 0-4    | Errores frecuentes de overflow, no comprende sistema de constraints                                                                                                     |

---

## 2️⃣ Prácticas (30 puntos)

### Práctica 01: Tarjeta de Perfil (6 pts)

| Criterio    | Puntos | Descripción                                               |
| ----------- | ------ | --------------------------------------------------------- |
| Estructura  | 2      | Container, Column, widgets básicos correctamente anidados |
| Estilos     | 2      | BoxDecoration, bordes, sombras, padding aplicados         |
| Completitud | 2      | Avatar, nombre, descripción, botón de acción              |

### Práctica 02: Lista de Productos (6 pts)

| Criterio           | Puntos | Descripción                                        |
| ------------------ | ------ | -------------------------------------------------- |
| ListView.builder   | 2      | Implementación eficiente con itemBuilder           |
| Item personalizado | 2      | Card con imagen, título, precio, bien estructurado |
| Interactividad     | 2      | onTap funcional, feedback visual                   |

### Práctica 03: Galería de Imágenes (6 pts)

| Criterio       | Puntos | Descripción                                    |
| -------------- | ------ | ---------------------------------------------- |
| GridView       | 2      | Implementación con crossAxisCount o extent     |
| Imágenes       | 2      | Carga correcta, placeholder, manejo de errores |
| Hero animation | 2      | Transición fluida al detalle (bonus)           |

### Práctica 04: Layout Responsivo (6 pts)

| Criterio      | Puntos | Descripción                         |
| ------------- | ------ | ----------------------------------- |
| MediaQuery    | 2      | Uso correcto de sizeOf, orientación |
| LayoutBuilder | 2      | Adaptación según constraints        |
| Breakpoints   | 2      | Diseño diferente para móvil/tablet  |

### Práctica 05: Pantalla Completa (6 pts)

| Criterio          | Puntos | Descripción                             |
| ----------------- | ------ | --------------------------------------- |
| Integración       | 2      | Combina múltiples layouts correctamente |
| Scaffold completo | 2      | AppBar, body, FAB, BottomNav            |
| Calidad visual    | 2      | Diseño cohesivo, espaciado consistente  |

---

## 3️⃣ Proyecto Integrador: App de Recetas (50 puntos)

### 3.1 Funcionalidad (20 pts)

| Criterio               | Puntos | Descripción                                         |
| ---------------------- | ------ | --------------------------------------------------- |
| **Pantalla principal** | 5      | Lista de recetas con categorías, búsqueda funcional |
| **Detalle de receta**  | 5      | Imagen, ingredientes, pasos, tiempo de preparación  |
| **Navegación**         | 5      | Flujo correcto entre pantallas, back button         |
| **Estado**             | 5      | Favoritos funcionales, persistencia básica          |

### 3.2 Layouts y Widgets (15 pts)

| Criterio                   | Puntos | Descripción                                                   |
| -------------------------- | ------ | ------------------------------------------------------------- |
| **Variedad de layouts**    | 5      | Usa Column, Row, Stack, ListView, GridView apropiadamente     |
| **Widgets personalizados** | 5      | Crea widgets reutilizables (RecipeCard, IngredientItem, etc.) |
| **Responsive**             | 5      | Se adapta a diferentes tamaños de pantalla                    |

### 3.3 Calidad del Código (10 pts)

| Criterio          | Puntos | Descripción                                                    |
| ----------------- | ------ | -------------------------------------------------------------- |
| **Organización**  | 3      | Estructura de carpetas lógica, separación de responsabilidades |
| **Nomenclatura**  | 3      | Código en inglés, nombres descriptivos, convenciones de Dart   |
| **Documentación** | 2      | Comentarios explicativos (qué, para qué, cómo)                 |
| **Sin errores**   | 2      | Compila sin warnings, no hay errores de overflow               |

### 3.4 Diseño Visual (5 pts)

| Criterio            | Puntos | Descripción                                     |
| ------------------- | ------ | ----------------------------------------------- |
| **Consistencia**    | 2      | Colores, tipografía y espaciado uniformes       |
| **Material Design** | 2      | Sigue guías de diseño, usa componentes estándar |
| **Acabado**         | 1      | Atención al detalle, pulido visual              |

---

## 📈 Escala de Calificación

| Rango  | Calificación    | Descripción                                  |
| ------ | --------------- | -------------------------------------------- |
| 90-100 | ⭐ Excelente    | Dominio completo, código profesional         |
| 80-89  | 🟢 Muy Bueno    | Sólida comprensión, implementación correcta  |
| 70-79  | 🟡 Bueno        | Comprende conceptos, algunas áreas de mejora |
| 60-69  | 🟠 Suficiente   | Cumple mínimos, necesita práctica adicional  |
| 0-59   | 🔴 Insuficiente | No alcanza objetivos mínimos                 |

---

## ✅ Checklist de Entrega

### Prácticas

- [ ] Práctica 01: Tarjeta de perfil funcional
- [ ] Práctica 02: Lista de productos con scroll
- [ ] Práctica 03: Galería de imágenes en grid
- [ ] Práctica 04: Layout que cambia según pantalla
- [ ] Práctica 05: Dashboard completo

### Proyecto Integrador

- [ ] Código fuente en repositorio
- [ ] README con instrucciones de ejecución
- [ ] Screenshots de la aplicación
- [ ] App compila sin errores
- [ ] Todas las funcionalidades implementadas

---

## 🎯 Criterios de Evaluación Adicionales

### Bonificaciones (+5 pts máximo)

| Criterio    | Puntos | Descripción                                  |
| ----------- | ------ | -------------------------------------------- |
| Animaciones | +2     | Hero, AnimatedContainer, transiciones suaves |
| Tema oscuro | +1     | Implementa ThemeMode con cambio dinámico     |
| Testing     | +2     | Widget tests para componentes principales    |

### Penalizaciones

| Criterio        | Puntos | Descripción                     |
| --------------- | ------ | ------------------------------- |
| Entrega tardía  | -10    | Por cada día de retraso         |
| Código copiado  | -50    | Plagio detectado (mínimo)       |
| No compila      | -20    | El proyecto no ejecuta          |
| Overflow errors | -5     | Errores de renderizado visibles |

---

## 📝 Notas para el Evaluador

1. **Priorizar funcionalidad sobre estética** - El código debe funcionar primero
2. **Valorar la comprensión** - Preguntar "por qué" eligió cierta solución
3. **Considerar el progreso** - Comparar con semanas anteriores
4. **Feedback constructivo** - Indicar áreas específicas de mejora
5. **Reconocer creatividad** - Valorar soluciones innovadoras

---

## 📅 Fechas Importantes

| Entregable          | Fecha Límite          |
| ------------------- | --------------------- |
| Prácticas 01-03     | Día 3 de la semana    |
| Prácticas 04-05     | Día 5 de la semana    |
| Proyecto Integrador | Día 7 de la semana    |
| Revisión de código  | Día 8 (sesión grupal) |
