/// Ejercicio 02 — Widget Test de un Formulario
/// Qué: probar un formulario simple con pumpWidget, enterText y tap.
/// Para qué: verificar el comportamiento de una pantalla completa, sin
/// necesitar un emulador ni tocarla manualmente en cada cambio.
/// Tu trabajo esta semana está en test/widget_test.dart, no aquí.
library;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FormScreen());
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _controller = TextEditingController();
  String? _message;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        _error = 'El nombre es obligatorio';
        _message = null;
      });
      return;
    }
    setState(() {
      _message = '¡Hola, ${_controller.text.trim()}!';
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('name-field'),
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nombre', errorText: _error),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('submit-button'),
              onPressed: _submit,
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 16),
            if (_message != null) Text(_message!),
          ],
        ),
      ),
    );
  }
}
