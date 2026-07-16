# Glosario — Semana 11: Animaciones Básicas

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

---

**AnimatedContainer**
Widget que interpola automáticamente propiedades como `width`, `height`, `color`, `padding` o
`decoration` cuando su valor cambia entre un `build()` y el siguiente, sin necesitar un
`AnimationController`.

**AnimatedList**
Widget de lista que anima explícitamente la inserción y eliminación de elementos individuales,
controlado a través de un `GlobalKey<AnimatedListState>` y los métodos `insertItem`/`removeItem`.

**AnimatedOpacity**
Widget que interpola la propiedad `opacity` (0.0–1.0) de su hijo para animar apariciones y
desapariciones sin removerlo del layout.

**AnimatedSize**
Widget que anima el tamaño que termina ocupando su hijo, útil cuando el tamaño destino depende
del contenido y no se conoce de antemano (a diferencia de `AnimatedContainer`, donde tú fijas el
valor destino).

**AnimatedSwitcher**
Widget que anima la transición (por defecto, un fundido) al reemplazar un widget hijo por otro de
tipo distinto — requiere una `key` única por cada variante para detectar el cambio.

**Animación explícita**
Animación en la que el desarrollador controla directamente el progreso del tiempo mediante un
`AnimationController` (`.forward()`, `.reverse()`, `.repeat()`). Se cubre en semana 12.

**Animación implícita**
Animación en la que un widget `Animated*` interpola automáticamente entre el valor viejo y el
nuevo de una propiedad, sin que el desarrollador maneje el reloj de la animación.

**Curve**
Función matemática que determina cómo se distribuye el progreso de una animación en el tiempo
(ej. `Curves.easeInOut` acelera y desacelera; `Curves.linear` avanza a velocidad constante).

**Duration**
Cuánto tiempo tarda una transición animada en completarse, expresado normalmente en
milisegundos (`Duration(milliseconds: 250)`).

**Hero**
Widget que empareja dos instancias con el mismo `tag` en dos pantallas distintas para animar una
transición de "vuelo" (posición y tamaño) entre ellas al navegar.

**RepaintBoundary**
Widget que aísla el repintado de su subárbol en una capa de composición separada, evitando que
Flutter tenga que repintar hermanos costosos en cada frame de una animación cercana.

**tag** (de `Hero`)
Identificador único que conecta dos widgets `Hero` en pantallas distintas — debe coincidir
exactamente entre ambos y ser único por instancia (ej. incluir el `id` del ítem).

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
