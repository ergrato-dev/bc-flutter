# Glosario — Semana 02: Widgets y Layout

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## A

**AppBar**: barra superior estándar de Material Design, típicamente dentro de un `Scaffold`.

## B

**BuildContext**: referencia a la ubicación de un widget dentro del árbol de widgets. Se usa
para acceder a `Theme.of(context)`, navegación (semana 3), y más.

## C

**Container**: widget "todo en uno" para padding, margin, tamaño, color y decoración.

**CrossAxisAlignment**: alineación en el eje transversal de un `Row`/`Column`.

**Cupertino**: sistema de widgets con apariencia iOS, alternativo a Material.

## E

**Expanded**: fuerza a un hijo de `Row`/`Column` a ocupar el espacio disponible en el eje
principal.

## F

**Flexible**: similar a `Expanded`, pero permite que el hijo sea más pequeño si no necesita todo
el espacio disponible.

## H

**Hot reload**: inyecta cambios de código en la app corriendo, preservando el estado.

**Hot restart**: reinicia la app desde cero, perdiendo el estado.

## L

**ListTile**: fila estándar de Material con ícono, título, subtítulo y trailing opcional.

**ListView.builder**: construye solo los widgets visibles de una lista larga, bajo demanda —
equivalente conceptual a `FlatList` de React Native.

## M

**MainAxisAlignment**: alineación en el eje principal de un `Row`/`Column`.

**MaterialApp**: widget raíz que configura tema, título y navegación de una app Material.

## S

**Scaffold**: estructura visual básica de una pantalla Material (AppBar, body, FAB, etc.).

**setState**: método de `State` que notifica a Flutter que debe reconstruir (`build()`) el
widget tras un cambio de estado interno.

**Spacer**: widget invisible que ocupa el espacio disponible en un `Row`/`Column`, empujando a
sus vecinos hacia los extremos.

**StatefulWidget**: widget con estado mutable interno, gestionado por un objeto `State`.

**StatelessWidget**: widget sin estado mutable propio — se reconstruye solo si cambian sus
parámetros.

## T

**TextEditingController**: objeto que controla y observa el texto de un `TextField`. Debe
liberarse con `.dispose()`.

**TextField**: widget de entrada de texto de una sola línea (o multilínea con configuración).

## W

**Widget tree**: jerarquía de widgets anidados que describe la interfaz completa de la app.

---

> 📚 Plan de estudios completo del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
