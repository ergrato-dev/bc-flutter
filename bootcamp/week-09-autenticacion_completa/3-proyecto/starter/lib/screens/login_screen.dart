import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../providers/auth_provider.dart';

// ============================================
// SCREEN: LoginScreen
// Formulario de login — valida con FormBuilder y llama a
// AuthNotifier.login(). El guard de rutas (app_router.dart) navega solo a
// HomeScreen cuando el login termina con éxito.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. El trabajo de
// esta semana está en auth_provider.dart y dio_provider.dart, no aquí.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    ref.listen(authProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${next.error}')));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Usa las credenciales de prueba: emilys / emilyspass',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'username',
                decoration: const InputDecoration(labelText: 'Usuario'),
                enabled: !isLoading,
                validator: FormBuilderValidators.required(errorText: 'El usuario es obligatorio'),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                enabled: !isLoading,
                validator:
                    FormBuilderValidators.required(errorText: 'La contraseña es obligatoria'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final values = _formKey.currentState!.value;
                          ref.read(authProvider.notifier).login(
                                values['username'] as String,
                                values['password'] as String,
                              );
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
