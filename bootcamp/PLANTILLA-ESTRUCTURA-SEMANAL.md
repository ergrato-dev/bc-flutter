# 📋 Plantilla de Estructura Semanal para Bootcamps

> **Documento de referencia para replicar la estructura en otros bootcamps**  
> Versión: 1.0 | Última actualización: Noviembre 2025

---

## 📖 Índice

1. [Visión General](#-visión-general)
2. [Estructura de Carpetas](#-estructura-de-carpetas)
3. [Descripción de Cada Componente](#-descripción-de-cada-componente)
4. [Justificación Pedagógica](#-justificación-pedagógica)
5. [Guía de Implementación](#-guía-de-implementación)
6. [Checklist de Creación](#-checklist-de-creación)
7. [Adaptación a Otros Bootcamps](#-adaptación-a-otros-bootcamps)

---

## 🎯 Visión General

### Filosofía de Diseño

Esta estructura está diseñada siguiendo los principios de:

- **Aprendizaje progresivo**: De teoría a práctica, de simple a complejo
- **Autonomía del estudiante**: Materiales autocontenidos para estudio independiente
- **Evaluación clara**: Criterios transparentes y objetivos medibles
- **Recursos accesibles**: Todo el material organizado y fácil de encontrar

### Formato del Bootcamp

| Parámetro           | Valor            |
| ------------------- | ---------------- |
| Duración por semana | 8 horas          |
| Dedicación teoría   | 2-3 horas (~30%) |
| Dedicación práctica | 2-3 horas (~30%) |
| Dedicación proyecto | 3-4 horas (~40%) |
| Número de prácticas | 5 por semana     |
| Proyecto integrador | 1 por semana     |

---

## 📁 Estructura de Carpetas

```
semana-XX/
├── README.md                    # 📋 Documento índice principal
├── RUBRICA-EVALUACION.md        # 📊 Criterios de evaluación (100 pts)
│
├── 0-assets/                    # 🎨 Recursos visuales
│   ├── README.md               # Índice de assets con previews
│   └── *.svg                   # Diagramas numerados (01-, 02-, etc.)
│
├── 1-teoria/                    # 📚 Contenido teórico
│   ├── README.md               # Índice de módulos teóricos
│   ├── 01-[tema-principal].md  # Módulo 1
│   ├── 02-[tema-secundario].md # Módulo 2
│   └── 03-[tema-terciario].md  # Módulo 3
│
├── 2-practicas/                 # 💻 Ejercicios prácticos
│   ├── README.md               # Índice de prácticas
│   ├── practica-01-[nombre].md # Práctica 1 (más fácil)
│   ├── practica-02-[nombre].md # Práctica 2
│   ├── practica-03-[nombre].md # Práctica 3
│   ├── practica-04-[nombre].md # Práctica 4
│   └── practica-05-[nombre].md # Práctica 5 (más difícil)
│
├── 3-proyecto/                  # 🔨 Proyecto integrador
│   ├── README.md               # Especificaciones del proyecto
│   ├── GUIA-DISENO.md          # Sistema de diseño / arquitectura
│   └── EJEMPLOS-DATOS.md       # Datos de ejemplo / mocks
│
├── 4-recursos/                  # 📖 Material complementario
│   ├── README.md               # Índice general de recursos
│   ├── 01-videos-[tema].md     # Videos por tema
│   ├── 02-videos-[tema].md
│   ├── ...
│   ├── 04-ebooks-[tema].md     # eBooks por tema
│   ├── ...
│   ├── 06-articulos-[tema].md  # Artículos por tema
│   ├── ...
│   ├── 08-documentacion-oficial.md
│   ├── 09-herramientas-desarrollo.md
│   ├── 10-playgrounds-online.md
│   ├── 11-comunidades.md
│   ├── 12-canales-youtube.md
│   ├── ebooks-free/            # Subcarpeta para PDFs
│   ├── videografia/            # Subcarpeta para notas de videos
│   └── webgrafia/              # Subcarpeta para bookmarks
│
└── 5-glosario/                  # 📖 Terminología
    └── README.md               # Glosario de términos (~40 términos)
```

---

## 📝 Descripción de Cada Componente

### 📋 README.md (Raíz de la semana)

**Propósito**: Documento índice que sirve como punto de entrada y guía de navegación.

**Contenido obligatorio**:

```markdown
# 🎨 Semana XX: [Título Descriptivo]

## Header con badges

- Tecnología principal
- Versión
- Duración (8 horas)
- Nivel de dificultad

## 📋 Descripción General

Resumen de 2-3 párrafos sobre el tema de la semana

## 🎯 Objetivos de Aprendizaje

Lista de 5-7 objetivos específicos y medibles con checkboxes

## ⏱️ Distribución del Tiempo

Tabla con teoría, prácticas y proyecto

## 📚 Contenido Teórico

Tabla con enlaces a los 3 módulos teóricos

## 💻 Prácticas

Tabla con las 5 prácticas, dificultad y tiempo estimado

## 🔨 Proyecto Integrador

Descripción breve con enlaces a documentos del proyecto

## 📖 Recursos

Tabla con los 12 archivos de recursos

## 📖 Glosario

Enlace al glosario con descripción breve

## 🎨 Assets y Diagramas

Tabla de diagramas disponibles

## 📊 Evaluación

Resumen de criterios con enlace a rúbrica

## ✅ Checklist de Completitud

Checkboxes para teoría, prácticas y proyecto

## 🧭 Navegación del Bootcamp

Diagrama ASCII mostrando posición en el bootcamp

## 💡 Tips de la Semana

Consejos, errores comunes, buenas prácticas

## 🔗 Enlaces Rápidos

Links externos importantes

## Footer

Navegación anterior/siguiente semana
```

**Justificación**: El README principal es el "mapa" del estudiante. Un documento bien estructurado reduce la fricción y aumenta la autonomía del estudiante.

---

### 📊 RUBRICA-EVALUACION.md

**Propósito**: Establecer criterios claros y transparentes de evaluación.

**Estructura obligatoria**:

```markdown
# 📊 Rúbrica de Evaluación - Semana XX

## Distribución de Puntos (Total: 100)

| Componente    | Peso | Puntos |
| ------------- | ---- | ------ |
| Teoría        | 20%  | 20     |
| Prácticas (5) | 30%  | 30     |
| Proyecto      | 50%  | 50     |

## 1️⃣ Evaluación Teórica (20 pts)

- Comprensión de conceptos (10 pts)
- Aplicación de conocimientos (10 pts)

## 2️⃣ Prácticas (30 pts)

- 6 puntos por cada práctica
- Criterios específicos por práctica

## 3️⃣ Proyecto Integrador (50 pts)

- Funcionalidad (20 pts)
- Calidad técnica (15 pts)
- Código limpio (10 pts)
- Diseño visual (5 pts)

## Escala de Calificación

90-100: Excelente | 80-89: Muy Bueno | 70-79: Bueno | 60-69: Suficiente | 0-59: Insuficiente

## Bonificaciones y Penalizaciones

- Extras: +5 máximo
- Tardanza: -10 por día

## Checklist de Entrega

## Notas para el Evaluador
```

**Justificación**: La transparencia en la evaluación:

- Reduce ansiedad del estudiante
- Establece expectativas claras
- Facilita la autoevaluación
- Estandariza criterios entre instructores

---

### 🎨 0-assets/

**Propósito**: Centralizar recursos visuales que apoyan el aprendizaje.

**Convenciones**:

- Numeración: `01-`, `02-`, etc. en orden lógico de consulta
- Formato: SVG preferido (escalable, editable)
- Tema: Dark theme (#1e1e1e fondo) para reducir fatiga visual
- Sin degradados: Colores sólidos para mejor legibilidad

**Estructura del README**:

```markdown
# 🎨 Assets - Semana XX

## Diagramas Disponibles

| #   | Archivo    | Usado en | Descripción |
| --- | ---------- | -------- | ----------- |
| 01  | nombre.svg | Módulo X | Descripción |

## Previews

![Nombre](01-nombre.svg)
```

**Justificación**: Los diagramas visuales:

- Facilitan la comprensión de conceptos abstractos
- Sirven como referencia rápida
- Mejoran la retención (aprendizaje visual)
- Profesionalizan el material

---

### 📚 1-teoria/

**Propósito**: Contenido teórico estructurado y progresivo.

**Convenciones**:

- 3 módulos por semana (ajustable según complejidad)
- Nomenclatura: `01-tema-principal.md`, `02-tema-secundario.md`
- Tiempo estimado por módulo: 40-60 minutos

**Estructura de cada módulo**:

```markdown
# Módulo X: [Título]

## 🎯 Objetivos del Módulo

- Objetivo 1
- Objetivo 2

## 📚 Contenido

### X.1 [Subtema]

[Explicación con código]

### X.2 [Subtema]

[Explicación con código]

## 💡 Puntos Clave

- Resumen de conceptos importantes

## ⚠️ Errores Comunes

- Lista de errores frecuentes

## 🔗 Referencias

- Enlaces a documentación oficial

## ✅ Autoevaluación

- Preguntas para verificar comprensión
```

**Justificación**: La teoría estructurada:

- Permite estudio asíncrono
- Facilita la revisión posterior
- Establece fundamentos sólidos
- Incluye código documentado (qué, para qué, cómo)

---

### 💻 2-practicas/

**Propósito**: Ejercicios prácticos de dificultad progresiva.

**Convenciones**:

- 5 prácticas por semana
- Dificultad creciente: ⭐ → ⭐⭐ → ⭐⭐⭐
- Tiempo: 25-35 minutos cada una
- Nomenclatura: `practica-01-nombre-descriptivo.md`

**Estructura de cada práctica**:

```markdown
# 💻 Práctica X: [Nombre]

## 📋 Información General

| Campo           | Valor              |
| --------------- | ------------------ |
| Dificultad      | ⭐⭐               |
| Tiempo estimado | 30 min             |
| Conceptos       | Lista de conceptos |

## 🎯 Objetivos

- Objetivo específico 1
- Objetivo específico 2

## 📝 Descripción

[Descripción del ejercicio]

## 🔧 Requisitos Técnicos

- Herramientas necesarias
- Dependencias

## 📋 Instrucciones

### Paso 1: [Título]

[Instrucciones detalladas con código]

### Paso 2: [Título]

[Instrucciones detalladas con código]

## 🎨 Resultado Esperado

[Descripción o screenshot del resultado]

## 💡 Pistas

<details>
<summary>Pista 1</summary>
[Ayuda sin dar la solución completa]
</details>

## ✅ Criterios de Evaluación

| Criterio      | Puntos |
| ------------- | ------ |
| Funcionalidad | X      |
| Código limpio | X      |

## 🚀 Desafío Extra (Opcional)

[Extensión para estudiantes avanzados]

## 📚 Recursos Relacionados

- Enlaces a documentación
```

**Justificación**: Las prácticas progresivas:

- Consolidan el aprendizaje teórico
- Construyen confianza gradualmente
- Preparan para el proyecto integrador
- Ofrecen desafíos opcionales para diferentes niveles

---

### 🔨 3-proyecto/

**Propósito**: Proyecto integrador que aplica todos los conceptos de la semana.

**Archivos obligatorios**:

1. **README.md**: Especificaciones completas
2. **GUIA-DISENO.md**: Sistema de diseño o arquitectura
3. **EJEMPLOS-DATOS.md**: Datos mock y ejemplos

**Estructura del README del proyecto**:

````markdown
# 🔨 Proyecto: [Nombre]

## 📋 Descripción General

[Descripción del proyecto]

## 🎯 Objetivos de Aprendizaje

- Integrar conceptos de la semana
- Aplicar en contexto real

## ✨ Características

### Funcionalidades Principales

- Feature 1
- Feature 2

### Funcionalidades Opcionales

- Bonus feature

## 🏗️ Arquitectura / Estructura

[Diagrama o descripción de la arquitectura]

## 📱 Pantallas / Vistas

| Pantalla | Descripción | Widgets/Componentes |
| -------- | ----------- | ------------------- |
| Home     | ...         | ...                 |

## 📊 Modelo de Datos

```code
[Definición del modelo]
```
````

## 🔧 Requisitos Técnicos

- Tecnologías requeridas
- Versiones mínimas

## 📋 Entregables

- [ ] Código fuente
- [ ] README con instrucciones
- [ ] Screenshots
- [ ] Documentación

## ⏱️ Tiempo Estimado

3-4 horas

## 📊 Evaluación

Enlace a la rúbrica específica

## 💡 Tips de Implementación

- Consejo 1
- Consejo 2

## 🚀 Extensiones Sugeridas

Ideas para mejorar el proyecto

````

**Justificación**: El proyecto integrador:
- Simula un escenario real de desarrollo
- Integra múltiples conceptos
- Desarrolla habilidades de planificación
- Genera portfolio para el estudiante

---

### 📖 4-recursos/

**Propósito**: Material complementario organizado por tipo y tema.

**Estructura recomendada (12 archivos)**:

| # | Archivo | Contenido |
|---|---------|-----------|
| 01-03 | videos-[tema].md | Tutoriales en video por tema |
| 04-05 | ebooks-[tema].md | Libros gratuitos por tema |
| 06-07 | articulos-[tema].md | Artículos técnicos por tema |
| 08 | documentacion-oficial.md | Links a docs oficiales |
| 09 | herramientas-desarrollo.md | IDEs, plugins, utilidades |
| 10 | playgrounds-online.md | Entornos de práctica |
| 11 | comunidades.md | Discord, Reddit, foros |
| 12 | canales-youtube.md | Canales recomendados |

**Subcarpetas**:
- `ebooks-free/`: PDFs descargables
- `videografia/`: Notas de videos
- `webgrafia/`: Bookmarks organizados

**Estructura de cada archivo de recursos**:

```markdown
# [Tipo]: [Tema]

## 🎬 Recursos Disponibles

### Nivel Principiante
| Recurso | Autor | Duración | Idioma | Link |
|---------|-------|----------|--------|------|
| ... | ... | ... | ... | ... |

### Nivel Intermedio
[Tabla similar]

### Nivel Avanzado
[Tabla similar]

## 💡 Recomendación del Instructor
[Top 3 recursos imprescindibles]
````

**Justificación**: Los recursos organizados:

- Extienden el aprendizaje más allá del bootcamp
- Acomodan diferentes estilos de aprendizaje
- Proporcionan profundización opcional
- Crean hábito de investigación autónoma

---

### 📖 5-glosario/

**Propósito**: Referencia rápida de terminología técnica.

**Cantidad recomendada**: 30-50 términos por semana

**Estructura del README**:

````markdown
# 📖 Glosario - Semana XX

## 📋 Índice Alfabético

[A](#a) | [B](#b) | [C](#c) | ...

## Términos

### A

#### **Término**

> Definición concisa y clara

**Ejemplo**:

```code
[Código de ejemplo]
```
````

**Relacionado**: [Otro término](#otro-término)

---

```

**Categorías sugeridas**:
- Conceptos fundamentales
- Propiedades y atributos
- Patrones y prácticas
- Herramientas

**Justificación**: El glosario:
- Estandariza vocabulario técnico
- Sirve como referencia rápida
- Reduce confusión terminológica
- Facilita la comunicación en equipo

---

## 🧠 Justificación Pedagógica

### Modelo de Aprendizaje

Esta estructura sigue el modelo **"Tell-Show-Do-Apply"**:

```

┌─────────────────────────────────────────────────────────────┐
│ CICLO DE APRENDIZAJE │
├─────────────────────────────────────────────────────────────┤
│ │
│ 1. TELL (Teoría) │
│ └── Módulos teóricos con explicaciones │
│ ↓ │
│ 2. SHOW (Demostración) │
│ └── Código de ejemplo documentado │
│ ↓ │
│ 3. DO (Prácticas) │
│ └── Ejercicios guiados progresivos │
│ ↓ │
│ 4. APPLY (Proyecto) │
│ └── Proyecto integrador autónomo │
│ │
└─────────────────────────────────────────────────────────────┘

````

### Taxonomía de Bloom

Los componentes están alineados con niveles cognitivos:

| Componente | Nivel Bloom | Verbos |
|------------|-------------|--------|
| Teoría | Recordar, Comprender | Definir, explicar, identificar |
| Prácticas 1-2 | Aplicar | Implementar, usar, ejecutar |
| Prácticas 3-4 | Analizar | Comparar, organizar, diferenciar |
| Práctica 5 | Evaluar | Criticar, juzgar, seleccionar |
| Proyecto | Crear | Diseñar, construir, desarrollar |

### Principios de Diseño Instruccional

1. **Chunking**: Información dividida en módulos manejables
2. **Scaffolding**: Dificultad progresiva con soporte gradual
3. **Spaced Repetition**: Conceptos reforzados en diferentes contextos
4. **Active Learning**: Énfasis en práctica sobre teoría pasiva
5. **Immediate Feedback**: Criterios claros para autoevaluación

---

## 🛠️ Guía de Implementación

### Paso 1: Crear Estructura Base

```bash
# Script para crear estructura de una semana
mkdir -p semana-XX/{0-assets,1-teoria,2-practicas,3-proyecto,4-recursos/{ebooks-free,videografia,webgrafia},5-glosario}

# Crear archivos base
touch semana-XX/README.md
touch semana-XX/RUBRICA-EVALUACION.md
touch semana-XX/0-assets/README.md
touch semana-XX/1-teoria/{README.md,01-tema.md,02-tema.md,03-tema.md}
touch semana-XX/2-practicas/{README.md,practica-01.md,practica-02.md,practica-03.md,practica-04.md,practica-05.md}
touch semana-XX/3-proyecto/{README.md,GUIA-DISENO.md,EJEMPLOS-DATOS.md}
touch semana-XX/4-recursos/{README.md,01-videos.md,02-videos.md,03-videos.md,04-ebooks.md,05-ebooks.md,06-articulos.md,07-articulos.md,08-documentacion.md,09-herramientas.md,10-playgrounds.md,11-comunidades.md,12-canales.md}
touch semana-XX/5-glosario/README.md
````

### Paso 2: Orden de Desarrollo

1. ✅ Definir objetivos de aprendizaje de la semana
2. ✅ Crear módulos teóricos (1-teoria)
3. ✅ Diseñar prácticas progresivas (2-practicas)
4. ✅ Especificar proyecto integrador (3-proyecto)
5. ✅ Recopilar recursos externos (4-recursos)
6. ✅ Compilar glosario de términos (5-glosario)
7. ✅ Crear diagramas visuales (0-assets)
8. ✅ Definir rúbrica de evaluación
9. ✅ Redactar README principal

### Paso 3: Revisión de Calidad

- [ ] Todos los enlaces funcionan
- [ ] Código compila/ejecuta sin errores
- [ ] Tiempos estimados son realistas
- [ ] Dificultad es progresiva
- [ ] Vocabulario es consistente
- [ ] Formato markdown es correcto

---

## ✅ Checklist de Creación

### Por Semana (Estimado: 8-12 horas de preparación)

```markdown
## Estructura

- [ ] Carpetas creadas (0-assets, 1-teoria, 2-practicas, 3-proyecto, 4-recursos, 5-glosario)
- [ ] README.md en cada carpeta

## Teoría (~3 horas)

- [ ] Módulo 01 completo con código documentado
- [ ] Módulo 02 completo con código documentado
- [ ] Módulo 03 completo con código documentado
- [ ] Diagramas vinculados en módulos

## Prácticas (~2 horas)

- [ ] Práctica 01 (dificultad ⭐)
- [ ] Práctica 02 (dificultad ⭐⭐)
- [ ] Práctica 03 (dificultad ⭐⭐)
- [ ] Práctica 04 (dificultad ⭐⭐⭐)
- [ ] Práctica 05 (dificultad ⭐⭐⭐)

## Proyecto (~2 horas)

- [ ] README con especificaciones
- [ ] Guía de diseño/arquitectura
- [ ] Datos de ejemplo

## Recursos (~1 hora)

- [ ] 12 archivos de recursos creados
- [ ] Links verificados
- [ ] Subcarpetas con READMEs

## Glosario (~1 hora)

- [ ] 30-50 términos definidos
- [ ] Ejemplos de código incluidos
- [ ] Índice alfabético

## Assets (~1 hora)

- [ ] Diagramas SVG creados
- [ ] Numerados en orden lógico
- [ ] Tema oscuro aplicado
- [ ] Vinculados en documentos

## Evaluación (~1 hora)

- [ ] Rúbrica con 100 puntos
- [ ] Criterios específicos por componente
- [ ] Escala de calificación

## README Principal (~1 hora)

- [ ] Todos los componentes enlazados
- [ ] Navegación del bootcamp
- [ ] Tips y errores comunes
```

---

## 🔄 Adaptación a Otros Bootcamps

### Variables a Personalizar

| Variable            | Ejemplo Flutter         | Adaptación            |
| ------------------- | ----------------------- | --------------------- |
| Tecnología          | Flutter/Dart            | React, Python, etc.   |
| Duración semana     | 8 horas                 | Ajustable             |
| Número de prácticas | 5                       | 3-7 según complejidad |
| Tipo de proyecto    | App móvil               | Web, CLI, API, etc.   |
| Herramientas        | VS Code, Android Studio | Según stack           |

### Bootcamps Compatibles

Esta estructura es adaptable para:

- **Frontend**: React, Vue, Angular, Svelte
- **Backend**: Node.js, Python/Django, Go, Rust
- **Mobile**: React Native, Kotlin, Swift
- **DevOps**: Docker, Kubernetes, CI/CD
- **Data**: Python, SQL, Machine Learning
- **Otros**: Blockchain, IoT, Game Dev

### Ejemplo de Adaptación (React)

```
semana-03/
├── README.md
├── RUBRICA-EVALUACION.md
├── 0-assets/
│   └── 01-component-lifecycle.svg
│   └── 02-hooks-diagram.svg
├── 1-teoria/
│   ├── 01-componentes-funcionales.md
│   ├── 02-hooks-basicos.md
│   └── 03-estado-props.md
├── 2-practicas/
│   ├── practica-01-contador.md
│   ├── practica-02-lista-tareas.md
│   ├── practica-03-formulario.md
│   ├── practica-04-fetch-api.md
│   └── practica-05-context-theme.md
├── 3-proyecto/
│   └── README.md (App de Notas)
├── 4-recursos/
│   └── [12 archivos adaptados]
└── 5-glosario/
    └── README.md (términos React)
```

---

## 📊 Métricas de Éxito

### Para el Estudiante

| Métrica              | Objetivo                 |
| -------------------- | ------------------------ |
| Tasa de completitud  | >80% completan la semana |
| Puntuación promedio  | >70 puntos               |
| Tiempo de dedicación | ±8 horas (±20%)          |
| Satisfacción         | >4/5 estrellas           |

### Para el Contenido

| Métrica            | Objetivo      |
| ------------------ | ------------- |
| Enlaces rotos      | 0%            |
| Código funcional   | 100%          |
| Errores reportados | <5 por semana |
| Actualizaciones    | Trimestral    |

---

## 📝 Notas Finales

### Principios a Mantener

1. **Consistencia**: Misma estructura en todas las semanas
2. **Calidad**: Todo código debe funcionar
3. **Claridad**: Lenguaje simple y directo
4. **Completitud**: Nada queda sin documentar
5. **Actualización**: Revisar versiones periódicamente

### Anti-patrones a Evitar

- ❌ Semanas con estructuras diferentes
- ❌ Código sin probar
- ❌ Enlaces rotos o desactualizados
- ❌ Tiempos irrealistas
- ❌ Prácticas sin criterios de evaluación
- ❌ Teoría sin ejemplos de código

---

<div align="center">

**Documento de Referencia - Bootcamp Structure Template v1.0**

_Diseñado para escalabilidad y reusabilidad_

</div>
