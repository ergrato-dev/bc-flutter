/// Ejercicio 02 — Validadores Compuestos y Tipos de Campo
/// Qué: agregar dropdown, checkbox, validación compuesta y autovalidateMode
/// a un FormBuilder ya wireado (ejercicio 01).
/// Para qué: es el nivel de formulario que construirás en el proyecto de
/// esta semana, con varios tipos de campo y reglas combinadas.
library;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  debugPrint('--- Ejercicio 02: Validadores Compuestos y Tipos de Campo ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 02',
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
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          // TODO temporal: en el PASO 3 agrega
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: FormBuilderValidators.required(errorText: 'El nombre es obligatorio'),
              ),
              // TODO temporal: en el PASO 1 agrega el FormBuilderDropdown
              // 'category' aquí (ver README).
              // TODO temporal: en el PASO 2 agrega el FormBuilderTextField
              // 'price' (con validación compuesta) y el FormBuilderCheckbox
              // 'inStock' aquí (ver README).
              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final values = _formKey.currentState!.value;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$values')),
                        );
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                  // TODO temporal: en el PASO 3 agrega el botón "Limpiar"
                  // aquí, junto al de "Enviar".
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: FormBuilderDropdown
// ============================================
// Agrega esto dentro del Column, justo después del campo 'name':
//
// const SizedBox(height: 12),
// FormBuilderDropdown<String>(
//   name: 'category',
//   decoration: const InputDecoration(labelText: 'Categoría'),
//   validator: FormBuilderValidators.required(errorText: 'Selecciona una categoría'),
//   items: const [
//     DropdownMenuItem(value: 'a', child: Text('Categoría A')),
//     DropdownMenuItem(value: 'b', child: Text('Categoría B')),
//     DropdownMenuItem(value: 'c', child: Text('Categoría C')),
//   ],
// ),

// ============================================
// PASO 2: Validación compuesta + FormBuilderCheckbox
// ============================================
// Agrega esto dentro del Column, justo después del dropdown del PASO 1:
//
// const SizedBox(height: 12),
// FormBuilderTextField(
//   name: 'price',
//   decoration: const InputDecoration(labelText: 'Precio'),
//   keyboardType: const TextInputType.numberWithOptions(decimal: true),
//   validator: FormBuilderValidators.compose([
//     FormBuilderValidators.required(errorText: 'El precio es obligatorio'),
//     FormBuilderValidators.numeric(errorText: 'Debe ser un número'),
//     FormBuilderValidators.min(0, errorText: 'No puede ser negativo'),
//   ]),
// ),
// const SizedBox(height: 12),
// FormBuilderCheckbox(
//   name: 'inStock',
//   title: const Text('Disponible en inventario'),
//   initialValue: true,
// ),

// ============================================
// PASO 3: autovalidateMode + reset
// ============================================
// 1. Descomenta `autovalidateMode: AutovalidateMode.onUserInteraction,`
//    dentro del FormBuilder, arriba.
// 2. Agrega este botón dentro del Row, junto al de "Enviar":
//
// const SizedBox(width: 12),
// OutlinedButton(
//   onPressed: () => _formKey.currentState?.reset(),
//   child: const Text('Limpiar'),
// ),
