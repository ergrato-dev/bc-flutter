/// Ejercicio 01 — FormBuilder Básico
/// Qué: practicar el wiring mínimo de FormBuilder — GlobalKey, campos de
/// texto, un validador simple por campo, y lectura de valores al enviar.
/// Para qué: es la base de todo formulario del resto del bootcamp —
/// AsyncNotifier de semana 5-6 se combina con esto recién en el ejercicio 03.
library;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  debugPrint('--- Ejercicio 01: FormBuilder Básico ---');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      // TODO temporal: en el PASO 1 reemplaza este Placeholder por el
      // FormBuilder — ver instrucciones abajo.
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: FormBuilder con GlobalKey
// ============================================
// 1. Descomenta el `GlobalKey<FormBuilderState>` arriba, dentro de
//    _HomeScreenState.
// 2. Reemplaza el `body:` de HomeScreen por:
//
// Padding(
//   padding: const EdgeInsets.all(16),
//   child: FormBuilder(
//     key: _formKey,
//     child: Column(
//       children: [
//         FormBuilderTextField(
//           name: 'name',
//           decoration: const InputDecoration(labelText: 'Nombre'),
//         ),
//       ],
//     ),
//   ),
// ),

// ============================================
// PASO 2: Validadores simples
// ============================================
// Reemplaza el FormBuilderTextField del PASO 1 por estos dos campos:
//
// FormBuilderTextField(
//   name: 'name',
//   decoration: const InputDecoration(labelText: 'Nombre'),
//   validator: FormBuilderValidators.required(errorText: 'El nombre es obligatorio'),
// ),
// const SizedBox(height: 12),
// FormBuilderTextField(
//   name: 'email',
//   decoration: const InputDecoration(labelText: 'Correo'),
//   keyboardType: TextInputType.emailAddress,
//   validator: FormBuilderValidators.email(errorText: 'Formato de correo inválido'),
// ),

// ============================================
// PASO 3: Leer los valores con saveAndValidate()
// ============================================
// Agrega este botón como último hijo del Column (después del campo email):
//
// const SizedBox(height: 24),
// ElevatedButton(
//   onPressed: () {
//     if (_formKey.currentState!.saveAndValidate()) {
//       final values = _formKey.currentState!.value;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('${values['name']} — ${values['email']}')),
//       );
//     }
//   },
//   child: const Text('Enviar'),
// ),
