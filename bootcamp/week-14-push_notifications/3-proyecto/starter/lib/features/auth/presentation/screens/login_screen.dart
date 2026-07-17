import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

// ============================================
// SCREEN: LoginScreen
// Formulario de login — mismo patrón de semana 9, ahora con AuthCubit en
// vez de AuthNotifier. El guard de rutas (app/app_router.dart) navega solo
// a HomeScreen cuando el login termina con éxito.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. El trabajo de
// esta semana está en
// features/notifications/data/repositories/notification_repository_impl.dart,
// no aquí.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Padding(
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
                    validator:
                        FormBuilderValidators.required(errorText: 'El usuario es obligatorio'),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    enabled: !isLoading,
                    validator: FormBuilderValidators.required(
                        errorText: 'La contraseña es obligatoria'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              final values = _formKey.currentState!.value;
                              context.read<AuthCubit>().login(
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
          );
        },
      ),
    );
  }
}
