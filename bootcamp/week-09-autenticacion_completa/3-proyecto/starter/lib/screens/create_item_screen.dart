import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../models/item.dart';
import '../providers/create_item_provider.dart';
import '../providers/items_provider.dart';

// ============================================
// SCREEN: CreateItemScreen
// Formulario para crear un nuevo elemento de tu dominio — valida con
// FormBuilder y envía con CreateItemNotifier (POST real vía repository).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo (semana 7) — adapta los campos a tu dominio
// si quieres (mínimo 3, coherentes con tu dominio; ver teoría de semana 7).
// El trabajo de esta semana está en favorites_provider.dart e
// items_repository.dart, no aquí.
class CreateItemScreen extends ConsumerStatefulWidget {
  const CreateItemScreen({super.key});

  @override
  ConsumerState<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends ConsumerState<CreateItemScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(createItemProvider);
    final isLoading = submitState.isLoading;

    ref.listen(createItemProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${next.error}')));
      }
      if (previous?.isLoading == true && !next.isLoading && !next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Elemento creado con éxito')),
        );
        ref.invalidate(itemsProvider);
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo elemento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Nombre'),
                enabled: !isLoading,
                validator: FormBuilderValidators.required(errorText: 'El nombre es obligatorio'),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(labelText: 'Descripción'),
                enabled: !isLoading,
                maxLines: 3,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'La descripción es obligatoria'),
                  FormBuilderValidators.minLength(10, errorText: 'Mínimo 10 caracteres'),
                ]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final values = _formKey.currentState!.value;
                          final item = Item(
                            id: '',
                            name: values['name'] as String,
                            description: values['description'] as String,
                          );
                          ref.read(createItemProvider.notifier).create(item);
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Crear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
