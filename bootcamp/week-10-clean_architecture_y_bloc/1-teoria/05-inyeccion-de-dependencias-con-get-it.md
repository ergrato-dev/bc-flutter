# Inyección de Dependencias con get_it

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué este proyecto necesita un mecanismo de inyección de dependencias sin Riverpod
- Cómo registrar y resolver dependencias con `get_it`
- El orden correcto de registro: externos → datasources → repositories → use cases → cubits

## 📋 Conceptos Clave

### 1. El problema sin Riverpod

Riverpod resolvía dos cosas a la vez: **estado** (`AsyncNotifier`) y **construcción de
dependencias** (cada provider sabía cómo construirse a partir de otros providers, vía
`ref.watch()`). Bloc solo resuelve estado — no tiene un mecanismo propio para decir "un
`ItemsRepositoryImpl` necesita un `ItemsRemoteDataSource`, que necesita un `Dio`".

Sin algo que lo resuelva, `main.dart` terminaría construyendo manualmente cada capa de cada
feature, en el orden correcto, cada vez — decenas de líneas frágiles. `get_it` es un **service
locator**: un registro central donde declaras una vez cómo se construye cada tipo, y lo pides
desde cualquier lugar sin repetir esa construcción.

### 2. Registrar y resolver

```dart
final getIt = GetIt.instance;

getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: '...')));

getIt.registerLazySingleton<ItemsRemoteDataSource>(
  () => ItemsRemoteDataSourceImpl(getIt()), // getIt() resuelve el Dio de arriba
);

getIt.registerLazySingleton<ItemsRepository>(
  () => ItemsRepositoryImpl(getIt(), getIt()), // resuelve remote + local
);

getIt.registerLazySingleton(() => GetItems(getIt()));
getIt.registerLazySingleton(() => ItemsCubit(getIt()));
```

```dart
// En cualquier parte de la app:
final cubit = getIt<ItemsCubit>();
```

`registerLazySingleton()` construye la instancia la **primera vez** que se pide, y retorna esa
misma instancia en pedidos siguientes — equivalente al `keepAlive: true` de Riverpod. El closure
`() => ...` solo se ejecuta una vez.

### 3. Dos instancias del mismo tipo — `instanceName`

Este proyecto tiene **dos** `Dio`: uno para tus datos de dominio (`jsonplaceholder`) y otro para
login (`dummyjson`, semana 9). `get_it` distingue instancias del mismo tipo con un nombre:

```dart
getIt.registerLazySingleton<Dio>(() => Dio(...), instanceName: 'itemsDio');
getIt.registerLazySingleton<Dio>(() => Dio(...), instanceName: 'authDio');

// Al resolver:
getIt<Dio>(instanceName: 'itemsDio')
```

### 4. Orden de registro: de afuera hacia adentro

`injection_container.dart` registra en este orden — cada línea puede depender solo de líneas
**anteriores**:

1. **Externos**: `Dio`, `Box`, `SharedPreferences`, `FlutterSecureStorage`
2. **Datasources**: usan los externos
3. **Repositories** (implementaciones): usan los datasources
4. **Use cases**: usan los repositories (por su contrato, `ItemsRepository`, no la implementación)
5. **Cubits**: usan los use cases

Este orden **es** la regla de dependencia de Clean Architecture (teoría 01), aplicada al momento
de construcción en vez de al momento de import.

### 5. Instancias async — `Box` y `SharedPreferences`

`Hive.openBox()` y `SharedPreferences.getInstance()` son async — no se pueden registrar con
`registerLazySingleton()` (que espera un closure síncrono). Por eso `main()` las carga **antes**
de llamar a `initDependencies()`, y las pasa como parámetros ya resueltos:

```dart
final itemsBox = await Hive.openBox('items_cache');
final prefs = await SharedPreferences.getInstance();
await initDependencies(itemsBox: itemsBox, prefs: prefs);
```

Dentro de `initDependencies()`, `getIt.registerSingleton(itemsBox)` (sin "Lazy") registra un
**valor ya construido**, no un closure — mismo espíritu que `overrideWithValue()` de semana 8-9.

## ✅ Checklist de Verificación

- [ ] Sé por qué Bloc necesita un mecanismo de inyección de dependencias aparte
- [ ] Sé registrar y resolver una dependencia con `get_it`
- [ ] Sé usar `instanceName` para dos instancias del mismo tipo
- [ ] Sé el orden correcto de registro (externos → datasources → repositories → use cases → cubits)

## 📚 Próximo paso

[GoRouterRefreshStream y Buenas Prácticas de Arquitectura →](06-gorouterrefreshstream-y-buenas-practicas.md)
