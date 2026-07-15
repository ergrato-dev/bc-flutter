---
description: "Genera un diagrama SVG educativo para 0-assets/ siguiendo los estándares visuales del bootcamp: dark theme, sin degradés, fuente sans-serif, paleta Flutter. Usar cuando la teoría o práctica necesite un diagrama visual."
name: "Nuevo diagrama SVG"
argument-hint: "Describe el diagrama: qué concepto ilustra, qué elementos debe tener, semana y nombre de archivo sugerido (ej: week-05/riverpod-provider-graph.svg)"
mode: "agent"
---

# Generar diagrama SVG educativo — Bootcamp Flutter

Crea un diagrama SVG para `0-assets/` que ilustre conceptos de Dart/Flutter de
forma visual y educativa, siguiendo los estándares del bootcamp.

## Estándares visuales obligatorios

### Tema

- 🌙 **Fondo oscuro**: `#0d1117` (GitHub dark)
- ❌ **Sin degradés** (`linearGradient`, `radialGradient` están **PROHIBIDOS**)
- ✅ Colores sólidos únicamente

### Paleta de colores

| Rol                 | Color     | Uso                                  |
| -------------------- | --------- | ------------------------------------- |
| Fondo base            | `#0d1117` | Background principal del SVG          |
| Acento Flutter (claro) | `#54C5F8` | Títulos, acciones, bordes de énfasis |
| Acento Flutter (oscuro)| `#0175C2` | Elementos secundarios, marcos        |
| Texto principal        | `#ffffff` | Texto sobre fondo oscuro             |
| Texto secundario       | `#8b949e` | Subtítulos, descripciones            |
| Superficie card        | `#161b22` | Cajas, paneles, contenedores         |
| Borde sutil            | `#30363d` | Bordes de cajas y separadores        |
| Éxito / positivo       | `#3fb950` | Flujos exitosos, checkmarks          |
| Error / negativo       | `#f85149` | Errores, rechazos, x-marks           |
| Advertencia            | `#d29922` | Notas de precaución                  |

### Tipografía

- ✅ **Sans-serif exclusivamente**: `font-family="system-ui, -apple-system, sans-serif"`
- ❌ **NO usar fuentes serif**: `Times`, `Georgia`, etc.
- ❌ **NO usar monospace** salvo para fragmentos de código dentro del diagrama
- Jerarquía de tamaños: título 20-24px, subtítulo 14-16px, cuerpo 11-13px

### Dimensiones recomendadas

- **Diagrama de flujo**: 800×500px o 1000×600px
- **Comparativa iOS vs Android**: 900×400px
- **Arquitectura en capas (Clean Architecture)**: 700×600px
- **Timeline / secuencia**: 900×350px

## Tipos de diagrama más usados en el bootcamp

### Widget tree / árbol de widgets

```svg
<svg width="800" height="400" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="400" fill="#0d1117"/>
  <!-- Widget padre -->
  <rect x="50" y="150" width="160" height="100" rx="8" fill="#161b22" stroke="#30363d" stroke-width="1"/>
  <text x="130" y="205" fill="#ffffff" font-size="14" text-anchor="middle" font-family="system-ui, sans-serif">Scaffold</text>
  <!-- Flecha -->
  <line x1="210" y1="200" x2="290" y2="200" stroke="#54C5F8" stroke-width="2" marker-end="url(#arrow)"/>
  <!-- ... -->
</svg>
```

### Diagrama de arquitectura en capas (Clean Architecture)

Mostrar la separación:

```
Presentation (widgets / providers-cubits)
    ↕
Domain (entities / use cases)
    ↕
Data (repositories / data sources)
    ↕
Backend (API / almacenamiento local)
```

### Comparativa iOS vs Android

Dos columnas con los mismos widgets mostrando diferencias visuales (Material vs Cupertino):

- Columna izquierda: iOS (Cupertino)
- Columna derecha: Android (Material)
- Fila central: código Flutter compartido

### Grafo de dependencias de providers (Riverpod)

Nodos = providers, aristas = dependencias entre `ref.watch`/`ref.read`. Útil para explicar
composición de estado sin `BuildContext`.

### Diagrama de ciclo de vida / secuencia

Timeline izquierda→derecha con pasos numerados y actores (App, API, Provider/Cubit, Storage).

## Reglas de vinculación (obligatorio)

Todo SVG creado debe estar vinculado en al menos un archivo de teoría o práctica:

```markdown
![Descripción accesible del diagrama](../0-assets/nombre-del-diagrama.svg)
```

Nombrar descriptivamente en kebab-case:

- ✅ `widget-tree-flow.svg`
- ✅ `riverpod-provider-graph.svg`
- ✅ `jwt-auth-flow.svg`
- ❌ `diagrama1.svg`
- ❌ `image.svg`

## Accesibilidad

Incluir siempre `<title>` y `<desc>` en el SVG raíz:

```svg
<svg ...>
  <title>Diagrama del grafo de providers de Riverpod</title>
  <desc>Dependencias entre authProvider, userRepositoryProvider y homeScreenProvider</desc>
  <!-- contenido -->
</svg>
```

## Instrucciones para el agente

1. Crear el SVG en `bootcamp/week-XX/0-assets/nombre-descriptivo.svg`
2. Aplicar estrictamente la paleta de colores — NO usar degradés bajo ninguna circunstancia
3. Fuente `system-ui, -apple-system, sans-serif` en todos los textos
4. Incluir `<title>` y `<desc>` para accesibilidad
5. Verificar que el SVG sea válido (tags cerrados, atributos con comillas)
6. Indicar en qué archivo de teoría o práctica debe vincularse el SVG generado
7. Proporcionar el snippet markdown de vinculación listo para copiar

## Descripción del diagrama a crear

$input
