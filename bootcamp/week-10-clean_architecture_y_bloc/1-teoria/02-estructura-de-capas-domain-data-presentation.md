# Estructura de Capas: Domain, Data, Presentation

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué archivo va en cada capa, con el ejemplo real de la feature `items` de este proyecto
- La diferencia entre una **entidad** (domain) y un **modelo** (data)
- Qué es un **use case** y por qué es una clase con un solo método `call()`

## 📋 Conceptos Clave

![Flujo de una feature en Clean Architecture: HomeScreen usa ItemsCubit (presentation), que depende de GetItems (domain, use case), que depende del contrato ItemsRepository (domain), implementado por ItemsRepositoryImpl (data), que combina ItemsRemoteDataSource (Dio) e ItemsLocalDataSource (Hive)](../0-assets/01-clean-architecture-layers.svg)

### 1. domain/ — el centro, sin dependencias externas

```
features/items/domain/
├── entities/item.dart              # clase Item pura: id, name, description
├── repositories/items_repository.dart   # abstract class — el CONTRATO
└── usecases/
    ├── get_items.dart              # class GetItems { call() }
    └── create_item.dart            # class CreateItem { call(item) }
```

La **entidad** `Item` no tiene `fromJson`/`toJson` — no sabe que existe una API. El **contrato**
`ItemsRepository` declara `getItems()`/`createItem()` sin decir cómo se obtienen. Un **use case**
es una clase con una sola responsabilidad y un método `call()`, lo que permite invocar la
instancia como si fuera una función: `final items = await getItems();`.

### 2. data/ — traduce el mundo exterior al lenguaje del domain

```
features/items/data/
├── models/item_model.dart                    # ItemModel extends Item + fromJson/toJson
├── datasources/
│   ├── items_remote_data_source.dart         # Dio — igual que DioItemsRepository (semana 6)
│   └── items_local_data_source.dart          # Hive — igual que el Box de semana 8
└── repositories/items_repository_impl.dart    # implementa ItemsRepository combinando ambos
```

`ItemModel extends Item` — un modelo **es** una entidad, con la traducción extra hacia/desde
JSON o el cache. Los datasources son la misma responsabilidad que ya conocías (Dio, Hive) — ahora
cada una vive en su propia clase, aislada, en vez de mezclada dentro de un solo repository.
`ItemsRepositoryImpl` es el mismo patrón de `CachedItemsRepository` (semana 8): red primero,
cache como respaldo — solo que ahora delega en dos datasources en vez de manejar Dio y el Box
directamente.

### 3. presentation/ — solo conoce domain

```
features/items/presentation/
├── cubit/items_cubit.dart          # ItemsCubit(GetItems) — recibe el use case, no el repository
├── screens/home_screen.dart
└── widgets/item_card.dart
```

`ItemsCubit` recibe `GetItems` (un use case), nunca `ItemsRepository` directamente ni mucho menos
`Dio`. Esto es intencional: si mañana agregas lógica extra antes de obtener los items (por
ejemplo, combinar dos repositories), la agregas dentro del use case — el Cubit no cambia.

### 4. ¿Por qué favoritos vive dentro de `items/` y no en su propia feature?

`favorites/` no tiene sentido sin `items/` — un favorito siempre es el favorito **de un
elemento**. Separarlo en `features/favorites/` obligaría a esa feature a depender de `items/` de
todos modos, rompiendo el aislamiento que buscas entre features. La regla práctica: una feature
nueva se justifica cuando puede explicarse sin mencionar otra feature — `auth` (login) cumple
esa regla, favoritos no.

## ✅ Checklist de Verificación

- [ ] Sé qué archivos van en `domain/`, `data/` y `presentation/` de una feature
- [ ] Sé la diferencia entre una entidad (`Item`) y un modelo (`ItemModel`)
- [ ] Sé por qué un use case es una clase con un solo método `call()`
- [ ] Sé por qué favoritos vive dentro de la feature `items`, no en su propia feature

## 📚 Próximo paso

[Cubit — Estado Simple con emit() →](03-cubit-estado-simple-con-emit.md)
