# Glosario — Semana 10: Clean Architecture y Bloc

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## B

**Bloc**: clase de `flutter_bloc` que recibe eventos y los traduce a estados nuevos mediante
handlers registrados con `on<Event>()` — la variante orientada a eventos, más elaborada que
`Cubit`.

**BlocBuilder**: widget que reconstruye la UI en cada estado nuevo de un Cubit/Bloc —
equivalente a `ref.watch()` de Riverpod.

**BlocConsumer**: combina `BlocBuilder` y `BlocListener` en un solo widget.

**BlocListener**: widget que ejecuta un efecto secundario (SnackBar, navegación) en cada estado
nuevo, sin reconstruir la UI — equivalente a `ref.listen()` de Riverpod.

**BlocProvider**: widget que expone un Cubit/Bloc al árbol de widgets — equivalente a
`ProviderScope` de Riverpod, a nivel de una sola instancia.

## C

**Clean Architecture**: patrón de organización de código en capas concéntricas
(domain-data-presentation) donde las dependencias de código fuente solo apuntan hacia adentro.

**Cubit**: clase de `flutter_bloc` que mantiene un estado y lo cambia con `emit()` desde sus
propios métodos, sin necesitar clases de evento.

## D

**Data source**: clase responsable de una sola fuente de datos concreta (Dio, Hive,
SharedPreferences) — vive en la capa `data`, nunca en `domain` ni `presentation`.

**Dependency rule (regla de dependencia)**: principio central de Clean Architecture — las capas
internas (domain) nunca importan nada de las capas externas (data, presentation).

## E

**Entidad**: objeto de dominio puro, sin `fromJson`/`toJson` ni conocimiento de la API o la base
de datos — vive en `domain/entities/`.

**Equatable**: paquete que genera `==`/`hashCode` a partir de una lista `props`, usado en las
clases de estado de Cubit/Bloc para comparación por valor.

## G

**get_it**: paquete de _service locator_ — registra cómo se construye cada dependencia una vez,
y la resuelve desde cualquier parte de la app sin repetir esa construcción.

**GoRouterRefreshStream**: `ChangeNotifier` que se suscribe a un `Stream` (el de un Cubit/Bloc) y
notifica a `GoRouter` para que reevalúe `redirect` — usado porque Bloc no tiene un mecanismo
equivalente a `ref.watch()` fuera del árbol de widgets.

## I

**instanceName**: parámetro de `get_it` que distingue dos instancias registradas del mismo tipo
(por ejemplo, dos `Dio` con `baseUrl` distintos).

## M

**Modelo (Model/DTO)**: clase de la capa `data` que extiende una entidad y le agrega la
traducción hacia/desde JSON o el formato del cache — la entidad nunca conoce este formato.

## R

**refreshListenable**: propiedad de `GoRouter` que acepta cualquier `Listenable` — al notificar,
`GoRouter` reevalúa `redirect` sin reconstruirse.

**registerLazySingleton()**: método de `get_it` que construye una instancia la primera vez que se
pide, y retorna esa misma instancia en pedidos siguientes.

## U

**Use case**: clase de la capa `domain` con una sola responsabilidad de negocio y un método
`call()`, lo que permite invocarla como si fuera una función.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
