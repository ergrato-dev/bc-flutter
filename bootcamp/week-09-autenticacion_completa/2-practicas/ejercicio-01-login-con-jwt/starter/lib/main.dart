/// Ejercicio 01 — Login con JWT
/// Qué: hacer POST de login contra una API JWT real y mostrar el token o el
/// error traducido.
/// Para qué: es el mismo AuthRepository.login() que completarás en el
/// proyecto de esta semana, aquí sin la capa de Riverpod para enfocarse en
/// el request en sí.
library;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dio/dio.dart';

void main() {
  debugPrint('--- Ejercicio 01: Login con JWT ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 01',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO temporal: descomenta esta línea como parte del PASO 1.
  // final _formKey = GlobalKey<FormBuilderState>();
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      // TODO temporal: en el PASO 1 reemplaza este Placeholder por el
      // FormBuilder — ver instrucciones abajo.
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Placeholder(fallbackHeight: 120),
            const SizedBox(height: 16),
            Text(_result),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: FormBuilder con usuario y contraseña
// ============================================
// 1. Descomenta el `GlobalKey<FormBuilderState>` arriba, dentro de
//    _HomeScreenState.
// 2. Reemplaza el `Placeholder` del body por:
//
// FormBuilder(
//   key: _formKey,
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       FormBuilderTextField(
//         name: 'username',
//         decoration: const InputDecoration(labelText: 'Usuario'),
//         validator: FormBuilderValidators.required(errorText: 'El usuario es obligatorio'),
//       ),
//       FormBuilderTextField(
//         name: 'password',
//         decoration: const InputDecoration(labelText: 'Contraseña'),
//         obscureText: true,
//         validator: FormBuilderValidators.required(errorText: 'La contraseña es obligatoria'),
//       ),
//     ],
//   ),
// ),

// ============================================
// PASO 2: POST de login con Dio
// ============================================
// Agrega esta función fuera de cualquier clase (nivel de archivo):
//
// Future<String> login(String username, String password) async {
//   try {
//     final response = await Dio(BaseOptions(baseUrl: 'https://dummyjson.com')).post(
//       '/auth/login',
//       data: {'username': username, 'password': password},
//     );
//     return response.data['accessToken'] as String;
//   } on DioException catch (e) {
//     if (e.response?.statusCode == 400) {
//       throw Exception('Usuario o contraseña incorrectos');
//     }
//     throw Exception('No se pudo iniciar sesión');
//   }
// }

// ============================================
// PASO 3: conectar el botón y mostrar el resultado
// ============================================
// Agrega este botón como último hijo del Column del PASO 1:
//
// const SizedBox(height: 24),
// ElevatedButton(
//   onPressed: () async {
//     if (_formKey.currentState!.saveAndValidate()) {
//       final values = _formKey.currentState!.value;
//       try {
//         final token = await login(values['username'] as String, values['password'] as String);
//         setState(() => _result = 'Token recibido: ${token.substring(0, 20)}...');
//       } catch (e) {
//         setState(() => _result = '$e');
//       }
//     }
//   },
//   child: const Text('Iniciar sesión'),
// ),
