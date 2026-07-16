# Ejercicio 03 — Clean Architecture Mini

> Construirás una feature completa de punta a punta — domain, data y presentation — para una
> frase aleatoria (`dummyjson.com/quotes/random`), conectando todo con `get_it`, descomentando
> código paso a paso. Es el ejercicio más largo de la semana: es el mismo flujo completo del
> proyecto, en miniatura.

## 🎯 Objetivos

- Escribir las tres capas de una feature desde cero: entidad, contrato, use case, datasource,
  repository impl, Cubit
- Registrar toda la cadena de dependencias con `get_it`, en el orden correcto
- Verificar que cada capa solo conoce a la capa inmediatamente interior

## 📋 Requisitos

- Ejercicios 01 y 02 completados
- Conexión a internet (usa la API pública `dummyjson.com`)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: domain — entidad, contrato y use case

```dart
class Quote {
  const Quote({required this.content, required this.author});
  final String content;
  final String author;
}

abstract class QuoteRepository {
  Future<Quote> getRandomQuote();
}

class GetRandomQuote {
  GetRandomQuote(this._repository);
  final QuoteRepository _repository;
  Future<Quote> call() => _repository.getRandomQuote();
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

`Quote` no tiene `fromJson` — la entidad no sabe que existe una API (ver teoría 02).

---

## Paso 2: data — datasource y repository impl

```dart
class QuoteRemoteDataSource {
  QuoteRemoteDataSource(this._dio);
  final Dio _dio;

  Future<Quote> fetchRandomQuote() async {
    final response = await _dio.get('https://dummyjson.com/quotes/random');
    return Quote(content: response.data['quote'] as String, author: response.data['author'] as String);
  }
}

class QuoteRepositoryImpl implements QuoteRepository {
  QuoteRepositoryImpl(this._remote);
  final QuoteRemoteDataSource _remote;

  @override
  Future<Quote> getRandomQuote() => _remote.fetchRandomQuote();
}
```

**Descomenta la sección `PASO 2`**.

`QuoteRemoteDataSource` es la única clase que sabe que existe Dio. `QuoteRepositoryImpl`
implementa el contrato de domain delegando en ella — mismo patrón que `ItemsRepositoryImpl` del
proyecto, sin la parte de cache (esta feature no la necesita).

---

## Paso 3: presentation + get_it — Cubit, registro y UI

```dart
sealed class QuoteState extends Equatable {
  const QuoteState();
  @override
  List<Object?> get props => [];
}
class QuoteLoading extends QuoteState { const QuoteLoading(); }
class QuoteLoaded extends QuoteState {
  const QuoteLoaded(this.quote);
  final Quote quote;
  @override
  List<Object?> get props => [quote];
}
class QuoteError extends QuoteState {
  const QuoteError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit(this._getRandomQuote) : super(const QuoteLoading());
  final GetRandomQuote _getRandomQuote;

  Future<void> loadQuote() async {
    emit(const QuoteLoading());
    try {
      emit(QuoteLoaded(await _getRandomQuote()));
    } catch (e) {
      emit(QuoteError('$e'));
    }
  }
}
```

**Descomenta la sección `PASO 3.1`** (estas tres clases).

```dart
final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => QuoteRemoteDataSource(getIt()));
  getIt.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => GetRandomQuote(getIt()));
  getIt.registerLazySingleton(() => QuoteCubit(getIt())..loadQuote());
}
```

**Descomenta la sección `PASO 3.2`** y llama `setup()` al inicio de `main()`, antes de `runApp()`.

```dart
BlocProvider.value(
  value: getIt<QuoteCubit>(),
  child: Scaffold(
    body: Center(
      child: BlocBuilder<QuoteCubit, QuoteState>(
        builder: (context, state) => switch (state) {
          QuoteLoading() => const CircularProgressIndicator(),
          QuoteError(:final message) => Text(message),
          QuoteLoaded(:final quote) => Padding(
              padding: const EdgeInsets.all(24),
              child: Text('"${quote.content}"\n— ${quote.author}', textAlign: TextAlign.center),
            ),
        },
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => context.read<QuoteCubit>().loadQuote(),
      child: const Icon(Icons.refresh),
    ),
  ),
)
```

**Descomenta la sección `PASO 3.3`** y reemplaza el `body` de `HomeScreen` por este árbol.

✅ **Verifica**: al abrir la app, debe mostrarse una frase. Al presionar el botón de refrescar,
debe cambiar a otra frase.

---

## ✅ Resultado final

Una feature completa con las tres capas de Clean Architecture, registrada de punta a punta con
`get_it` — exactamente el mismo flujo que ya viste en el proyecto (`items`/`auth`), aquí
condensado en un solo archivo para verlo completo de un vistazo.
