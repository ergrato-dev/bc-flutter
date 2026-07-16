/// Ejercicio 02 — flutter_secure_storage
/// Qué: leer, escribir y borrar un valor cifrado en disco.
/// Para qué: es el mismo mecanismo que usarás para guardar el token de
/// sesión en el proyecto de esta semana.
library;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  debugPrint('--- Ejercicio 02: flutter_secure_storage ---');
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
  // TODO temporal: descomenta estas líneas como parte del PASO 1.
  // static const _storage = FlutterSecureStorage();
  // static const _key = 'demo_token';
  String? _storedValue;

  @override
  void initState() {
    super.initState();
    // TODO temporal: en el PASO 1 reemplaza este cuerpo por:
    // _storage.read(key: _key).then((value) => setState(() => _storedValue = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_storedValue ?? '(nada guardado)'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // TODO temporal: en el PASO 2 reemplaza este onPressed por `_save`.
                  onPressed: () {},
                  child: const Text('Guardar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  // TODO temporal: en el PASO 3 reemplaza este onPressed por `_delete`.
                  onPressed: () {},
                  child: const Text('Borrar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: instancia de FlutterSecureStorage + leer al iniciar
// ============================================
// Descomenta `_storage` y `_key` arriba, dentro de _HomeScreenState, y
// reemplaza el cuerpo de initState() (después de `super.initState();`) por:
//
// _storage.read(key: _key).then((value) => setState(() => _storedValue = value));

// ============================================
// PASO 2: guardar un valor
// ============================================
// Agrega este método dentro de _HomeScreenState:
//
// Future<void> _save() async {
//   await _storage.write(key: _key, value: 'token-de-ejemplo-${DateTime.now().second}');
//   final value = await _storage.read(key: _key);
//   setState(() => _storedValue = value);
// }
//
// Reemplaza el `onPressed: () {}` del botón "Guardar" por `_save`.

// ============================================
// PASO 3: borrar el valor
// ============================================
// Agrega este método dentro de _HomeScreenState:
//
// Future<void> _delete() async {
//   await _storage.delete(key: _key);
//   setState(() => _storedValue = null);
// }
//
// Reemplaza el `onPressed: () {}` del botón "Borrar" por `_delete`.
