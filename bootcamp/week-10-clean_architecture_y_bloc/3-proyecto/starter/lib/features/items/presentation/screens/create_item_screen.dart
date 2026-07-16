import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../domain/entities/item.dart';
import '../cubit/create_item_cubit.dart';
import '../cubit/create_item_state.dart';
import '../cubit/items_cubit.dart';

// ============================================
// SCREEN: CreateItemScreen
// Formulario para crear un nuevo elemento de tu dominio — valida con
// FormBuilder y envía con CreateItemCubit. Mismo patrón de semana 7-9.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. El trabajo de
// esta semana está en CreateItemCubit (presentation/cubit/), no aquí.
class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo elemento')),
      body: BlocConsumer<CreateItemCubit, CreateItemState>(
        listener: (context, state) {
          if (state is CreateItemFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is CreateItemSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Elemento creado con éxito')),
            );
            context.read<ItemsCubit>().fetchItems();
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final isLoading = state is CreateItemSubmitting;

          return Padding(
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
                    validator:
                        FormBuilderValidators.required(errorText: 'El nombre es obligatorio'),
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
                              context.read<CreateItemCubit>().submit(item);
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
          );
        },
      ),
    );
  }
}
