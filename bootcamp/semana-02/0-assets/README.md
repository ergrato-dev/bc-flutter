# 🎨 Assets Visuales - Semana 02

> **Programación Orientada a Objetos, Colecciones y Flutter**  
> **Formato**: SVG (Escalable y ligero)  
> **Tema**: Fondo oscuro para mejor visualización

---

## 📑 Catálogo de Assets

### Diagramas Conceptuales

1. **[01-diagrama-poo.svg](./01-diagrama-poo.svg)**
   - Diagrama de clases, herencia y mixins
   - Ilustra jerarquía de ejemplo (Animal → Dog, Cat)
   - Muestra relaciones: extends, implements, with
   
2. **[02-diagrama-colecciones.svg](./02-diagrama-colecciones.svg)**
   - Visualización de List, Set, Map
   - Operaciones comunes de cada colección
   - Comparativa de características

3. **[03-estructura-flutter.svg](./03-estructura-flutter.svg)**
   - Arquitectura de una app Flutter
   - Capas: Material/Cupertino, Widgets, Rendering, Foundation
   - Flujo de construcción de UI

4. **[04-widget-tree.svg](./04-widget-tree.svg)**
   - Árbol de widgets típico
   - Ejemplo: MaterialApp → Scaffold → Column → Widgets
   - Relaciones padre-hijo

### Diagramas de Flujo

5. **[05-ciclo-vida-widget.svg](./05-ciclo-vida-widget.svg)**
   - Lifecycle de StatefulWidget
   - Estados: initState, build, setState, dispose
   - Flujo de actualización

6. **[06-navegacion-flutter.svg](./06-navegacion-flutter.svg)**
   - Stack de navegación
   - push, pop, pushReplacement
   - Paso de datos entre pantallas

---

## 🎨 Estilo Visual

### Paleta de Colores

```css
/* Tema Oscuro */
--background: #1e1e1e
--surface: #252526
--primary: #569cd6
--secondary: #4ec9b0
--accent: #c586c0
--text: #d4d4d4
--border: #3e3e42

/* Elementos */
--class: #4ec9b0
--method: #dcdcaa
--property: #9cdcfe
--keyword: #569cd6
--comment: #6a9955
```

### Tipografía

- **Títulos**: 'SF Pro Display', sans-serif, 24px
- **Código**: 'Fira Code', monospace, 14px
- **Texto**: 'Roboto', sans-serif, 16px

---

## 📐 Dimensiones

| Asset | Ancho | Alto | Ratio |
|-------|-------|------|-------|
| 01-diagrama-poo.svg | 800px | 600px | 4:3 |
| 02-diagrama-colecciones.svg | 900px | 600px | 3:2 |
| 03-estructura-flutter.svg | 800px | 800px | 1:1 |
| 04-widget-tree.svg | 700px | 900px | 7:9 |
| 05-ciclo-vida-widget.svg | 800px | 600px | 4:3 |
| 06-navegacion-flutter.svg | 800px | 700px | 8:7 |

---

## 🔗 Uso en Documentación

### En Markdown

```markdown
![Diagrama POO](./0-assets/01-diagrama-poo.svg)
```

### En HTML (con tamaño)

```html
<img src="./0-assets/01-diagrama-poo.svg" width="600" alt="Diagrama POO">
```

### Centrado

```markdown
<div align="center">
  <img src="./0-assets/01-diagrama-poo.svg" width="700">
  <p><em>Figura 1: Jerarquía de clases en POO</em></p>
</div>
```

---

## 📚 Referencias en Contenido

Los assets están vinculados en:

### Teoría
- **[01-poo-dart.md](../1-teoria/01-poo-dart.md)** → usa `01-diagrama-poo.svg`
- **[02-colecciones-estructuras.md](../1-teoria/02-colecciones-estructuras.md)** → usa `02-diagrama-colecciones.svg`
- **[03-intro-flutter.md](../1-teoria/03-intro-flutter.md)** → usa `03-estructura-flutter.svg`, `04-widget-tree.svg`

### Prácticas
- **[practica-01-poo-biblioteca.md](../2-practicas/practica-01-poo-biblioteca.md)** → referencia `01-diagrama-poo.svg`
- **[practica-05-flutter-contador.md](../2-practicas/practica-05-flutter-contador.md)** → referencia `05-ciclo-vida-widget.svg`

### Proyecto
- **[README.md](../3-proyecto/README.md)** → usa `03-estructura-flutter.svg`, `04-widget-tree.svg`

---

## 🛠️ Herramientas de Creación

Los SVGs fueron creados con:
- **Diseño**: Figma / Excalidraw
- **Optimización**: SVGO
- **Validación**: SVG Validator

---

## 📱 Responsive

Todos los SVGs son:
- ✅ **Escalables**: Se adaptan a cualquier tamaño
- ✅ **Vectoriales**: Sin pérdida de calidad
- ✅ **Accesibles**: Incluyen atributos `aria-label`
- ✅ **Ligeros**: < 50KB cada uno
- ✅ **Optimizados**: Sin elementos innecesarios

---

## 🎯 Convenciones

### Nomenclatura
```
[número]-[descripción-kebab-case].svg
```

Ejemplos:
- `01-diagrama-poo.svg`
- `02-diagrama-colecciones.svg`
- `03-estructura-flutter.svg`

### Contenido
- Fondo oscuro (#1e1e1e)
- Texto legible (contraste mínimo 4.5:1)
- Iconos consistentes
- Grid implícito de 8px

---

## 💡 Tips de Visualización

### En VS Code
Instala extensión: **SVG Preview**
- Ver SVG en panel lateral
- Zoom y pan
- Export a PNG

### En GitHub
Los SVGs se renderizan automáticamente en README.md

### En Navegador
Abre directamente el archivo .svg
- Ctrl/Cmd + / para inspeccionar
- Responsive por defecto

---

## 🔄 Actualizaciones

Si necesitas modificar un SVG:

1. Abre en editor (Figma, Inkscape, VS Code)
2. Mantén proporciones originales
3. Exporta como SVG optimizado
4. Valida que funcione en dark mode
5. Actualiza referencias en documentación

---

## 📊 Uso por Documento

| Documento | Assets Usados | Cantidad |
|-----------|---------------|----------|
| 01-poo-dart.md | 01 | 1 |
| 02-colecciones-estructuras.md | 02 | 1 |
| 03-intro-flutter.md | 03, 04, 05 | 3 |
| practica-01-poo-biblioteca.md | 01 | 1 |
| practica-05-flutter-contador.md | 05 | 1 |
| Proyecto README.md | 03, 04, 06 | 3 |

---

## ⚡ Performance

| Métrica | Valor |
|---------|-------|
| Tamaño promedio | 35 KB |
| Tiempo de carga | < 100ms |
| Formato | SVG 1.1 |
| Compresión | SVGO optimizado |

---

## 🎨 Personalización

Para crear assets consistentes:

1. **Colores**: Usa variables CSS del tema
2. **Tipografía**: Mantén fuentes establecidas
3. **Iconos**: Usa Material Icons o similares
4. **Espaciado**: Grid de 8px
5. **Exportar**: Siempre optimizar con SVGO

---

## 📝 Licencia

Todos los assets son de uso educativo dentro del bootcamp.

---

**Total de Assets**: 6 SVGs  
**Tamaño Total**: ~210 KB  
**Última Actualización**: Noviembre 2025
