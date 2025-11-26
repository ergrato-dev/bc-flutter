# 📊 Rúbrica de Evaluación - Semana 7

## Persistencia de Datos en Flutter

---

## 📋 Distribución de Puntos

| Componente                   | Peso     | Puntos      |
| ---------------------------- | -------- | ----------- |
| **Teoría y Comprensión**     | 20%      | 20 pts      |
| **Prácticas (5 ejercicios)** | 30%      | 30 pts      |
| **Proyecto NotesVault**      | 50%      | 50 pts      |
| **TOTAL**                    | **100%** | **100 pts** |

---

## 1️⃣ Evaluación Teórica (20 puntos)

### 1.1 Comprensión de Conceptos de Almacenamiento (10 pts)

| Nivel            | Puntos | Criterios                                                                                                                               |
| ---------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Excelente**    | 9-10   | Domina SharedPreferences, SQLite y Hive. Explica cuándo usar cada uno con ejemplos claros. Comprende CRUD, transacciones y migraciones. |
| **Bueno**        | 7-8    | Entiende bien las diferencias entre tecnologías. Sabe implementar operaciones básicas. Comprende el concepto de persistencia local.     |
| **Suficiente**   | 5-6    | Conoce los fundamentos de al menos dos tecnologías. Puede realizar operaciones CRUD básicas.                                            |
| **Insuficiente** | 0-4    | No distingue entre tecnologías. Confusión sobre conceptos básicos de almacenamiento.                                                    |

### 1.2 Diseño de Modelos de Datos (10 pts)

| Nivel            | Puntos | Criterios                                                                                                                   |
| ---------------- | ------ | --------------------------------------------------------------------------------------------------------------------------- |
| **Excelente**    | 9-10   | Diseña modelos normalizados correctamente. Implementa serialización/deserialización. Define relaciones y claves apropiadas. |
| **Bueno**        | 7-8    | Crea modelos funcionales con serialización JSON. Entiende relaciones básicas (1:N).                                         |
| **Suficiente**   | 5-6    | Modelos simples que funcionan pero no óptimos. Serialización básica.                                                        |
| **Insuficiente** | 0-4    | Modelos mal estructurados. No implementa serialización correctamente.                                                       |

---

## 2️⃣ Prácticas (30 puntos)

### Práctica 1: SharedPreferences - UserPreferencesManager (6 pts)

| Criterio               | Puntos | Descripción                                      |
| ---------------------- | ------ | ------------------------------------------------ |
| Funcionalidad completa | 2      | Guarda/carga tema, idioma, notificaciones, login |
| Singleton pattern      | 1.5    | Implementación correcta del patrón singleton     |
| Manejo async/await     | 1.5    | Uso correcto de Future y await                   |
| Código limpio          | 1      | Nomenclatura, documentación, organización        |

### Práctica 2: SQLite - TaskDatabase (6 pts)

| Criterio         | Puntos | Descripción                            |
| ---------------- | ------ | -------------------------------------- |
| CRUD completo    | 2      | Create, Read, Update, Delete funcionan |
| Esquema correcto | 1.5    | Tabla con campos apropiados y tipos    |
| Migraciones      | 1.5    | Implementa al menos una migración      |
| Código limpio    | 1      | Documentación y estructura             |

### Práctica 3: Hive - ContactsBox (6 pts)

| Criterio          | Puntos | Descripción                              |
| ----------------- | ------ | ---------------------------------------- |
| CRUD completo     | 2      | Todas las operaciones funcionan          |
| TypeAdapter       | 1.5    | Adapter registrado correctamente         |
| Búsqueda/filtrado | 1.5    | Implementa búsqueda por nombre/favoritos |
| Código limpio     | 1      | Documentación y organización             |

### Práctica 4: Archivos - AppFileManager (6 pts)

| Criterio          | Puntos | Descripción                            |
| ----------------- | ------ | -------------------------------------- |
| Lectura/escritura | 2      | Lee y escribe archivos correctamente   |
| Directorios       | 1.5    | Usa correctamente documents/temp/cache |
| Manejo de errores | 1.5    | Try-catch, validaciones de existencia  |
| Código limpio     | 1      | Documentación clara                    |

### Práctica 5: Repository Pattern (6 pts)

| Criterio             | Puntos | Descripción                           |
| -------------------- | ------ | ------------------------------------- |
| Abstracción correcta | 2      | Interface Repository bien definida    |
| Implementaciones     | 2      | SQLite y Hive implementan el contrato |
| Cambio de backend    | 1      | Fácil cambiar entre implementaciones  |
| Código limpio        | 1      | SOLID principles aplicados            |

---

## 3️⃣ Proyecto NotesVault (50 puntos)

### 3.1 Funcionalidad Core (20 pts)

| Feature                 | Puntos | Criterios                                                  |
| ----------------------- | ------ | ---------------------------------------------------------- |
| **CRUD de Notas**       | 5      | Crear, leer, editar, eliminar notas funciona correctamente |
| **Sistema de Carpetas** | 4      | Crear carpetas, mover notas entre carpetas                 |
| **Etiquetas/Tags**      | 4      | Asignar múltiples tags, filtrar por tag                    |
| **Búsqueda**            | 4      | Búsqueda por título, contenido, tags                       |
| **Markdown Preview**    | 3      | Renderiza Markdown básico correctamente                    |

### 3.2 Persistencia (15 pts)

| Aspecto                     | Puntos | Criterios                             |
| --------------------------- | ------ | ------------------------------------- |
| **SQLite para notas**       | 5      | Esquema correcto, relaciones, índices |
| **Hive para configuración** | 3      | Preferencias de usuario guardadas     |
| **SharedPreferences**       | 2      | Última sesión, estado de UI           |
| **Archivos adjuntos**       | 3      | Manejo de imágenes en filesystem      |
| **Migraciones**             | 2      | Sistema de migraciones implementado   |

### 3.3 Calidad del Código (10 pts)

| Aspecto               | Puntos | Criterios                                   |
| --------------------- | ------ | ------------------------------------------- |
| **Arquitectura**      | 3      | Repository pattern, separación de capas     |
| **Nomenclatura**      | 2      | Variables/funciones en inglés, descriptivas |
| **Documentación**     | 2      | Comentarios qué/para qué/cómo               |
| **Manejo de errores** | 2      | Try-catch, estados de error en UI           |
| **Código DRY**        | 1      | Sin duplicación innecesaria                 |

### 3.4 UI/UX (5 pts)

| Aspecto                 | Puntos | Criterios                     |
| ----------------------- | ------ | ----------------------------- |
| **Material Design**     | 2      | Widgets y patrones correctos  |
| **Estados de carga**    | 1.5    | Loading indicators apropiados |
| **Feedback al usuario** | 1.5    | SnackBars, confirmaciones     |

---

## 📝 Rúbrica Detallada por Niveles

### Nivel Excelente (90-100 pts)

✅ **Dominio completo** de SharedPreferences, SQLite y Hive  
✅ **Arquitectura limpia** con Repository Pattern bien implementado  
✅ **Proyecto NotesVault** con todas las funcionalidades  
✅ **Código profesional**: documentado, sin errores, siguiendo convenciones  
✅ **Features adicionales**: offline sync, backup/restore, encriptación  
✅ **Testing**: al menos tests unitarios para repositorios

### Nivel Muy Bueno (80-89 pts)

✅ Buen manejo de las tres tecnologías de almacenamiento  
✅ Repository Pattern implementado correctamente  
✅ NotesVault con funcionalidades principales completas  
✅ Código bien estructurado y documentado  
✅ Manejo apropiado de errores y estados de carga

### Nivel Bueno (70-79 pts)

✅ Comprende y usa correctamente al menos dos tecnologías  
✅ Patrón Repository básico implementado  
✅ NotesVault funcional con CRUD y carpetas  
✅ Código organizado con documentación básica  
✅ UI funcional con Material Design

### Nivel Suficiente (60-69 pts)

✅ Implementa correctamente una tecnología principal  
✅ CRUD funcional en el proyecto  
✅ Código funciona pero con mejoras pendientes  
✅ Documentación mínima  
✅ UI básica pero funcional

### Nivel Insuficiente (0-59 pts)

❌ No implementa correctamente la persistencia  
❌ Errores frecuentes o código que no compila  
❌ Falta de comprensión de conceptos fundamentales  
❌ Proyecto incompleto o no funcional

---

## 🏆 Bonus Points (+10 pts máximo)

| Feature Extra                       | Puntos |
| ----------------------------------- | ------ |
| **Encriptación de datos sensibles** | +2     |
| **Sistema de backup/restore**       | +2     |
| **Offline-first con sync queue**    | +3     |
| **Tests unitarios (>70% coverage)** | +2     |
| **Export a PDF/HTML**               | +1     |

---

## 📋 Checklist de Entrega

### Obligatorio

- [ ] Código fuente del proyecto NotesVault
- [ ] Las 5 prácticas completadas
- [ ] README con instrucciones de ejecución
- [ ] Capturas de pantalla de la aplicación

### Recomendado

- [ ] Diagrama de base de datos
- [ ] Video demo (2-3 min)
- [ ] Tests unitarios
- [ ] Documentación de API del Repository

---

## 🗓️ Fechas Importantes

| Entrega                 | Fecha           | Peso         |
| ----------------------- | --------------- | ------------ |
| Prácticas 1-3           | Mitad de semana | 18 pts       |
| Prácticas 4-5           | Final de semana | 12 pts       |
| Proyecto NotesVault     | Fin de semana   | 50 pts       |
| Quiz teórico (opcional) | En clase        | +5 pts bonus |

---

## 💡 Tips para Maximizar tu Puntuación

### Para las Prácticas

1. **Lee toda la especificación** antes de empezar
2. **Implementa el happy path** primero, luego edge cases
3. **Documenta mientras codeas**, no al final
4. **Prueba cada función** individualmente

### Para el Proyecto

1. **Planifica tu modelo de datos** antes de codear
2. **Empieza por el Repository** y la capa de datos
3. **Usa el checklist** de funcionalidades
4. **Commit frecuente** para mostrar progreso
5. **Pide feedback** antes de la entrega final

### Errores Comunes a Evitar

❌ No cerrar la base de datos correctamente  
❌ Olvidar registrar TypeAdapters de Hive  
❌ No manejar el caso de primer uso (DB vacía)  
❌ Queries sin índices en tablas grandes  
❌ No validar datos antes de guardar

---

## 📞 Soporte

Si tienes dudas sobre la evaluación:

1. **Revisa esta rúbrica** detalladamente
2. **Consulta los ejemplos** en 3-proyecto/
3. **Pregunta en el foro** del bootcamp
4. **Office hours**: [horario a definir]

---

> **Recuerda**: La calidad del código es tan importante como la funcionalidad. Un proyecto que funciona pero está mal estructurado tendrá penalización. ¡Éxito! 🚀
