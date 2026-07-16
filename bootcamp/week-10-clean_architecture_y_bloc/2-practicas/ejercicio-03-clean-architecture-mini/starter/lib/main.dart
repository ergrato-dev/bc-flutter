/// Ejercicio 03 — Clean Architecture Mini
/// Qué: una feature completa de punta a punta (domain, data, presentation)
/// para una frase aleatoria, conectada con get_it.
/// Para qué: es el mismo flujo completo del proyecto de esta semana
/// (items/auth), condensado en un solo archivo.
library;

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  debugPrint('--- Ejercicio 03: Clean Architecture Mini ---');
  // TODO temporal: en el PASO 3.2 llama `setup();` aquí, antes de runApp().
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 03',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO temporal: en el PASO 3.3 reemplaza este Scaffold por el árbol
    // BlocProvider.value(...) — ver instrucciones abajo.
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 03')),
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: domain — entidad, contrato y use case
// ============================================
// Agrega estas clases a nivel de archivo:
//
// class Quote {
//   const Quote({required this.content, required this.author});
//   final String content;
//   final String author;
// }
//
// abstract class QuoteRepository {
//   Future<Quote> getRandomQuote();
// }
//
// class GetRandomQuote {
//   GetRandomQuote(this._repository);
//   final QuoteRepository _repository;
//   Future<Quote> call() => _repository.getRandomQuote();
// }

// ============================================
// PASO 2: data — datasource y repository impl
// ============================================
// Agrega estas clases a nivel de archivo:
//
// class QuoteRemoteDataSource {
//   QuoteRemoteDataSource(this._dio);
//   final Dio _dio;
//
//   Future<Quote> fetchRandomQuote() async {
//     final response = await _dio.get('https://dummyjson.com/quotes/random');
//     return Quote(
//       content: response.data['quote'] as String,
//       author: response.data['author'] as String,
//     );
//   }
// }
//
// class QuoteRepositoryImpl implements QuoteRepository {
//   QuoteRepositoryImpl(this._remote);
//   final QuoteRemoteDataSource _remote;
//
//   @override
//   Future<Quote> getRandomQuote() => _remote.fetchRandomQuote();
// }

// ============================================
// PASO 3.1: presentation — estado y Cubit
// ============================================
// Agrega estas clases a nivel de archivo:
//
// sealed class QuoteState extends Equatable {
//   const QuoteState();
//   @override
//   List<Object?> get props => [];
// }
//
// class QuoteLoading extends QuoteState {
//   const QuoteLoading();
// }
//
// class QuoteLoaded extends QuoteState {
//   const QuoteLoaded(this.quote);
//   final Quote quote;
//   @override
//   List<Object?> get props => [quote];
// }
//
// class QuoteError extends QuoteState {
//   const QuoteError(this.message);
//   final String message;
//   @override
//   List<Object?> get props => [message];
// }
//
// class QuoteCubit extends Cubit<QuoteState> {
//   QuoteCubit(this._getRandomQuote) : super(const QuoteLoading());
//   final GetRandomQuote _getRandomQuote;
//
//   Future<void> loadQuote() async {
//     emit(const QuoteLoading());
//     try {
//       emit(QuoteLoaded(await _getRandomQuote()));
//     } catch (e) {
//       emit(QuoteError('$e'));
//     }
//   }
// }

// ============================================
// PASO 3.2: get_it — registrar la cadena de dependencias
// ============================================
// Agrega esto a nivel de archivo, y llama `setup();` en main() antes de
// runApp() (ver el TODO temporal arriba):
//
// final getIt = GetIt.instance;
//
// void setup() {
//   getIt.registerLazySingleton(() => Dio());
//   getIt.registerLazySingleton(() => QuoteRemoteDataSource(getIt()));
//   getIt.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(getIt()));
//   getIt.registerLazySingleton(() => GetRandomQuote(getIt()));
//   getIt.registerLazySingleton(() => QuoteCubit(getIt())..loadQuote());
// }

// ============================================
// PASO 3.3: UI — BlocProvider.value + BlocBuilder
// ============================================
// Reemplaza el `Scaffold` de HomeScreen.build() por:
//
// return BlocProvider.value(
//   value: getIt<QuoteCubit>(),
//   child: Scaffold(
//     appBar: AppBar(title: const Text('Ejercicio 03')),
//     body: Center(
//       child: BlocBuilder<QuoteCubit, QuoteState>(
//         builder: (context, state) => switch (state) {
//           QuoteLoading() => const CircularProgressIndicator(),
//           QuoteError(:final message) => Text(message),
//           QuoteLoaded(:final quote) => Padding(
//               padding: const EdgeInsets.all(24),
//               child: Text('"${quote.content}"\n— ${quote.author}', textAlign: TextAlign.center),
//             ),
//         },
//       ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () => context.read<QuoteCubit>().loadQuote(),
//       child: const Icon(Icons.refresh),
//     ),
//   ),
// );
