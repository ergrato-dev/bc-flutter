# Assets Visuales - Semana 1: Fundamentos de Dart

## 📊 Recursos Gráficos Educativos

Esta carpeta contiene diagramas y visualizaciones en formato SVG para facilitar la comprensión de conceptos fundamentales de Dart.

---

## 🎨 Assets Disponibles

### 1. `01-tipos-datos-dart.svg`

**Concepto**: Tipos de datos fundamentales en Dart

**Qué ilustra**:

- Tipos numéricos: `int`, `double`, `num`
- Tipos de texto: `String`
- Tipo booleano: `bool`
- Colecciones: `List`, `Set`, `Map`
- Null safety: tipos nullable (`?`)

**Cuándo usar**:

- Al explicar sistema de tipos de Dart
- En teoría de variables y tipos
- Como referencia rápida de tipos básicos

**Vinculado en**:

- README principal de la semana
- Documentación de teoría sobre variables

---

### 2. `02-null-safety-operadores.svg`

**Concepto**: Operadores de Null Safety en Dart

**Qué ilustra**:

- `?` - Tipo nullable
- `!` - Null assertion operator
- `??` - If-null operator
- `?.` - Conditional member access
- `??=` - Null-aware assignment

**Cuándo usar**:

- Al enseñar null safety
- En ejercicios de manejo de null
- Como referencia rápida de operadores

**Vinculado en**:

- README principal de la semana
- Documentación de teoría sobre null safety
- Guías de prácticas

---

### 3. `03-funciones-parametros.svg`

**Concepto**: Tipos de parámetros en funciones Dart

**Qué ilustra**:

- Parámetros posicionales requeridos
- Parámetros opcionales posicionales `[]`
- Parámetros named `{}`
- Parámetro `required`
- Valores por defecto

**Cuándo usar**:

- Al explicar funciones y parámetros
- En teoría de sintaxis de funciones
- Como guía de mejores prácticas

**Vinculado en**:

- README principal de la semana
- Documentación de teoría sobre funciones

---

## 🎯 Características de los SVGs

### Tema Dark

- ✅ Fondo oscuro (#1E1E1E)
- ✅ Alto contraste para accesibilidad
- ✅ Colores basados en VS Code Dark+ theme

### Sin Degradados

- ✅ Colores sólidos únicamente
- ✅ Bordes definidos
- ✅ Mejor legibilidad

### Fuentes Sans-Serif

- ✅ Arial, Helvetica, sans-serif
- ✅ Consolas, Monaco, monospace (para código)
- ✅ Sin serifas para mejor legibilidad en pantalla

### Colores Consistentes

- **#0175C2** - Dart Blue (color oficial de Dart)
- **#01579B** - Dart Dark Blue (acento)
- **#4EC9B0** - Verde menta (colecciones)
- **#C586C0** - Púrpura (funciones)
- **#DCDCAA** - Amarillo pálido (variables)
- **#CE9178** - Naranja suave (strings)
- **#B5CEA8** - Verde claro (números)
- **#CCCCCC** - Gris claro (texto secundario)
- **#FFFFFF** - Blanco (títulos y texto principal)

---

## 💡 Cómo Usar los SVGs

### En Markdown

```markdown
![Tipos de Datos en Dart](./0-assets/01-tipos-datos-dart.svg)
```

### En HTML

```html
<img
  src="./0-assets/02-null-safety-operadores.svg"
  alt="Operadores Null Safety" />
```

### Visualización Directa

Los SVGs se pueden abrir directamente en navegadores o editores que soporten SVG.

---

## 🔧 Edición de SVGs

Si necesitas modificar los SVGs:

1. **Editor Online**: [SVGEdit](https://svgedit.netlify.app/)
2. **Editor Desktop**: Inkscape, Adobe Illustrator, Figma
3. **Editor de Texto**: Cualquier editor (son archivos XML)

**Importante**: Mantén el mismo esquema de colores y fuentes para consistencia.

---

## 🔢 Sistema de Numeración

Todos los assets en esta carpeta utilizan un sistema de numeración secuencial para facilitar la consulta lógica:

- `01-tipos-datos-dart.svg` - Primer concepto fundamental
- `02-null-safety-operadores.svg` - Segundo concepto fundamental
- `03-funciones-parametros.svg` - Tercer concepto fundamental

Este sistema se mantiene consistente con **semana-02** y posteriores para una mejor organización del bootcamp.

---

## 📝 Plantilla de Colores

```css
/* Fondo */
background: #1e1e1e;

/* Colores principales - Dart */
dart-blue: #0175c2;
dart-dark-blue: #01579b;
green-mint: #4ec9b0;
purple: #c586c0;
yellow-pale: #dcdcaa;
orange-soft: #ce9178;
green-light: #b5cea8;

/* Texto */
text-primary: #ffffff;
text-secondary: #cccccc;
text-code: #9cdcfe;

/* Bordes y líneas */
border-light: #666666;
border-dark: #2d2d2d;

/* Fuentes */
font-family: Arial, Helvetica, sans-serif;
font-family-code: Consolas, Monaco, 'Courier New', monospace;
```

---

## 🚀 Próximos Assets a Crear

Ideas para futuras visualizaciones:

- [ ] Ciclo de vida de variables (var, final, const)
- [ ] Colecciones comparadas (List, Set, Map)
- [ ] Async/await y Futures
- [ ] Clases y constructors
- [ ] Herencia vs Mixins vs Interfaces

---

**Última actualización**: Semana 1 - Fundamentos de Dart
