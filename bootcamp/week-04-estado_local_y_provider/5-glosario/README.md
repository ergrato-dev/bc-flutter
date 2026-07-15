# Glosario — Semana 04: Estado Local y Provider

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## C

**ChangeNotifier**: clase de Flutter (`dart:foundation`) que contiene estado y notifica a sus
suscriptores cuando cambia, vía `notifyListeners()`.

**ChangeNotifierProvider**: widget de Provider que crea y expone un `ChangeNotifier` al árbol.

**context.read\<T\>()**: obtiene la instancia de `T` sin suscribirse a cambios — para usar en
callbacks (`onPressed`, etc.).

**context.watch\<T\>()**: obtiene la instancia de `T` y suscribe al widget actual a sus
cambios — solo válido dentro de `build()`.

**Consumer\<T\>**: widget que busca el `T` más cercano en el árbol y reconstruye su `builder`
cuando cambia.

## I

**InheritedWidget**: mecanismo base de Flutter para compartir datos hacia abajo en el árbol de
widgets sin pasar parámetros explícitamente. Provider está construido sobre él.

## M

**MultiProvider**: widget que combina varios providers en una sola declaración legible.

## N

**notifyListeners()**: método de `ChangeNotifier` que avisa a todos los widgets suscritos que
deben reconstruirse.

## P

**Prop drilling**: pasar datos a través de widgets intermedios que no los usan, solo para que
lleguen a un widget descendiente que sí los necesita.

**Provider**: paquete que simplifica el uso de `InheritedWidget` para compartir y observar
estado en la app.

**ProxyProvider**: variante de provider que permite que un notifier dependa del valor de otro.

## S

**Selector\<T, S\>**: widget que se suscribe solo a una parte derivada (`S`) del estado de `T`,
evitando rebuilds cuando otras partes de `T` cambian.

---

> 📚 Plan de estudios completo del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
