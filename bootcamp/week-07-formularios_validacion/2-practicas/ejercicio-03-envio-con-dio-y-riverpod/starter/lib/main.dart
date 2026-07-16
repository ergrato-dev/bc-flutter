/// Ejercicio 03 — Envío con Dio y Riverpod
/// Qué: modelar el envío de un formulario como una acción de Riverpod
/// (AsyncNotifier<void> disparado por un método), con loading/éxito/error.
/// Para qué: es el patrón exacto del proyecto de esta semana — crear un
/// elemento de tu dominio con feedback visual completo.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dio/dio.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 03: Envío con Dio y Riverpod ---');
  runApp(const ProviderScope(child: MyApp()));
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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // TODO temporal: en el PASO 3 agrega aquí, al inicio de build():
    // final submitState = ref.watch(createNotifierProvider);
    // final isLoading = submitState.isLoading;
    //
    // ref.listen(createNotifierProvider, (previous, next) {
    //   if (next.hasError && !next.isLoading) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${next.error}')));
    //   }
    //   if (previous?.isLoading == true && !next.isLoading && !next.hasError) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Enviado con éxito')),
    //     );
    //     _formKey.currentState?.reset();
    //   }
    // });

    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 03')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: 'Título'),
                validator: FormBuilderValidators.required(errorText: 'El título es obligatorio'),
                // TODO temporal: en el PASO 3 agrega aquí `enabled: !isLoading,`
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                // TODO temporal: en el PASO 3 reemplaza este onPressed por:
                // isLoading
                //     ? null
                //     : () {
                //         if (_formKey.currentState!.saveAndValidate()) {
                //           final values = _formKey.currentState!.value;
                //           ref.read(createNotifierProvider.notifier).create(values['title'] as String);
                //         }
                //       },
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final values = _formKey.currentState!.value;
                    debugPrint('$values');
                  }
                },
                // TODO temporal: en el PASO 3 reemplaza este child por:
                // isLoading
                //     ? const SizedBox(
                //         width: 20,
                //         height: 20,
                //         child: CircularProgressIndicator(strokeWidth: 2),
                //       )
                //     : const Text('Enviar'),
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: dioProvider + CreateNotifier idle
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas, luego corre build_runner:
// @Riverpod(keepAlive: true)
// Dio dio(Ref ref) {
//   return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
// }
//
// @riverpod
// class CreateNotifier extends _$CreateNotifier {
//   @override
//   Future<void> build() async {
//     // idle — no hace nada hasta que se llama create()
//   }
// }

// ============================================
// PASO 2: create() con AsyncValue.guard()
// ============================================
// Agrega este método dentro de la clase CreateNotifier del PASO 1:
//
// Future<void> create(String title) async {
//   state = const AsyncLoading();
//   state = await AsyncValue.guard(() async {
//     try {
//       await ref.read(dioProvider).post('/posts', data: {'title': title});
//     } on DioException catch (e) {
//       throw Exception(
//         e.type == DioExceptionType.connectionError
//             ? 'Sin conexión a internet'
//             : 'No se pudo enviar el formulario',
//       );
//     }
//   });
// }
//
// Regenera con build_runner después de agregar el método.

// ============================================
// PASO 3: UI reactiva al estado del envío
// ============================================
// Sigue las instrucciones de los comentarios TODO temporal dentro de
// _HomeScreenState.build() — descomenta el bloque de ref.watch/ref.listen
// al inicio, agrega `enabled: !isLoading` al campo, y reemplaza el
// onPressed/child del botón por las versiones comentadas.
