# Glosario — Semana 01: Fundamentos de Dart y Entorno

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## A

**AOT (Ahead-Of-Time)**: compilación que traduce el código a nativo antes de ejecutarlo. Flutter
la usa para builds de producción (más rápido en el dispositivo, sin hot reload).

**async / await**: palabras clave para trabajar con código asíncrono de forma secuencial y
legible, sin bloquear el hilo principal.

## C

**const**: modificador para valores conocidos en tiempo de **compilación**. En Flutter, los
constructores `const` permiten reutilizar instancias de widgets entre rebuilds.

## D

**Dart**: lenguaje de programación de Google usado por Flutter, con tipado fuerte y null safety.

## E

**Extension method**: mecanismo para agregar métodos a una clase existente (incluso del SDK) sin
heredar de ella.

## F

**final**: modificador para valores que se asignan una sola vez, en tiempo de **ejecución**.

**Future\<T\>**: representa un valor de tipo `T` que estará disponible en el futuro (por ejemplo,
el resultado de una llamada de red).

## J

**JIT (Just-In-Time)**: compilación que traduce el código mientras se ejecuta. Flutter la usa en
desarrollo para habilitar hot reload.

## L

**late**: modificador que difiere la inicialización de una variable no-nulable, prometiendo al
compilador que tendrá un valor antes de usarse.

## M

**Mixin**: comportamiento reutilizable que se "mezcla" en una clase con la palabra clave `with`,
sin que exista una relación de herencia entre ellas.

## N

**Null safety**: sistema de tipos en el que cada tipo es no-nulable por defecto, y solo admite
`null` si se marca explícitamente con `?`.

## O

**Operador `?.`**: acceso seguro a una propiedad o método — retorna `null` en vez de lanzar una
excepción si el objeto es `null`.

**Operador `??`**: retorna el valor de la izquierda si no es `null`, o el de la derecha en caso
contrario (valor por defecto).

**Operador `??=`**: asigna un valor a una variable solo si esta es actualmente `null`.

**Operador `!`**: le dice al compilador "confío en que este valor no es null". Si te equivocas,
lanza una excepción en tiempo de ejecución.

## S

**Stream\<T\>**: representa una secuencia de valores de tipo `T` que se emiten a lo largo del
tiempo (a diferencia de `Future`, que resuelve una sola vez).

## V

**var**: declara una variable con tipo inferido, que puede reasignarse.

---

> 📚 Plan de estudios completo del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
