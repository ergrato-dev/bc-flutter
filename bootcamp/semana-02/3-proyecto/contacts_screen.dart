// lib/screens/contacts_screen.dart

import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/contact_manager.dart';

/// Pantalla de Gestión de Contactos
///
/// ¿Qué hace?
/// Permite ver, crear, editar y eliminar contactos
///
/// ¿Para qué?
/// Proporcionar una agenda personal completa
///
/// ¿Cómo funciona?
/// - Lista de contactos con avatar e información
/// - Búsqueda por nombre, teléfono o email
/// - Vista detallada de cada contacto
/// - Formulario completo para gestionar contactos
class ContactsScreen extends StatefulWidget {
  final ContactManager contactManager;

  const ContactsScreen({super.key, required this.contactManager});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  String _searchQuery = '';
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    // Obtener contactos filtrados
    var contacts = _showFavoritesOnly
        ? widget.contactManager.favoriteContacts
        : widget.contactManager.contacts;

    // Aplicar búsqueda
    if (_searchQuery.isNotEmpty) {
      contacts = widget.contactManager.searchContacts(_searchQuery);
    }

    // Ordenar alfabéticamente
    contacts.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mis Contactos'),
        actions: [
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.star : Icons.star_border,
              color: _showFavoritesOnly ? Colors.amber : null,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
            tooltip: 'Favoritos',
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: _showStatistics,
            tooltip: 'Estadísticas',
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          _buildSearchBar(),

          // Lista de contactos
          Expanded(
            child: contacts.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      // Mostrar separador de letra si cambia la inicial
                      final showHeader =
                          index == 0 ||
                          contacts[index].name[0].toUpperCase() !=
                              contacts[index - 1].name[0].toUpperCase();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showHeader)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                bottom: 8,
                                left: 16,
                              ),
                              child: Text(
                                contacts[index].name[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          _buildContactCard(contacts[index]),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewContact,
        icon: const Icon(Icons.person_add),
        label: const Text('Nuevo Contacto'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar contactos...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildContactCard(Contact contact) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: contact.avatarUrl != null
              ? ClipOval(
                  child: Image.network(
                    contact.avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        contact.initials,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    },
                  ),
                )
              : Text(
                  contact.initials,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                contact.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            if (contact.isFavorite)
              const Icon(Icons.star, size: 18, color: Colors.amber),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact.phone != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.phone, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(contact.phone!),
                ],
              ),
            ],
            if (contact.email != null) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.email, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      contact.email!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'favorite',
              child: Row(
                children: [
                  Icon(Icons.star, size: 20),
                  SizedBox(width: 8),
                  Text('Alternar favorito'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Eliminar', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'favorite') {
              setState(() {
                contact.toggleFavorite();
              });
            } else if (value == 'edit') {
              _editContact(contact);
            } else if (value == 'delete') {
              _deleteContact(contact);
            }
          },
        ),
        onTap: () => _showContactDetail(contact),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.contacts, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No hay contactos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'No se encontraron resultados'
                : 'Agrega tu primer contacto',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _showContactDetail(Contact contact) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar y nombre
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                contact.initials,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              contact.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Información de contacto
            if (contact.phone != null)
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Teléfono'),
                subtitle: Text(contact.phone!),
              ),
            if (contact.email != null)
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(contact.email!),
              ),
            if (contact.address != null)
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Dirección'),
                subtitle: Text(contact.address!),
              ),

            const SizedBox(height: 16),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _editContact(contact);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      contact.toggleFavorite();
                    });
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    contact.isFavorite ? Icons.star : Icons.star_border,
                  ),
                  label: Text(
                    contact.isFavorite ? 'Quitar favorito' : 'Favorito',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: contact.isFavorite
                        ? Colors.amber
                        : Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showStatistics() {
    final stats = widget.contactManager.getStatistics();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Estadísticas de Contactos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatRow('Total de contactos:', '${stats['total']}'),
            _buildStatRow('Favoritos:', '${stats['favorites']}'),
            _buildStatRow('Con teléfono:', '${stats['withPhone']}'),
            _buildStatRow('Con email:', '${stats['withEmail']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _addNewContact() {
    _showContactForm();
  }

  void _editContact(Contact contact) {
    _showContactForm(contact: contact);
  }

  void _deleteContact(Contact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Contacto'),
        content: Text('¿Estás seguro de eliminar a "${contact.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.contactManager.removeContact(contact.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contacto eliminado')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showContactForm({Contact? contact}) {
    final isEditing = contact != null;
    final nameController = TextEditingController(text: contact?.name ?? '');
    final phoneController = TextEditingController(text: contact?.phone ?? '');
    final emailController = TextEditingController(text: contact?.email ?? '');
    final addressController = TextEditingController(
      text: contact?.address ?? '',
    );
    bool isFavorite = contact?.isFavorite ?? false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditing ? 'Editar Contacto' : 'Nuevo Contacto',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite ? Colors.amber : Colors.grey,
                      ),
                      onPressed: () {
                        setModalState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Nombre
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre completo *',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Teléfono
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                // Email
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Dirección
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),

                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('El nombre es obligatorio'),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          if (isEditing) {
                            contact.name = nameController.text.trim();
                            contact.phone = phoneController.text.trim().isEmpty
                                ? null
                                : phoneController.text.trim();
                            contact.email = emailController.text.trim().isEmpty
                                ? null
                                : emailController.text.trim();
                            contact.address =
                                addressController.text.trim().isEmpty
                                ? null
                                : addressController.text.trim();
                            contact.isFavorite = isFavorite;
                          } else {
                            final newContact = Contact(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim().isEmpty
                                  ? null
                                  : phoneController.text.trim(),
                              email: emailController.text.trim().isEmpty
                                  ? null
                                  : emailController.text.trim(),
                              address: addressController.text.trim().isEmpty
                                  ? null
                                  : addressController.text.trim(),
                              isFavorite: isFavorite,
                            );
                            widget.contactManager.addContact(newContact);
                          }
                        });

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEditing
                                  ? 'Contacto actualizado'
                                  : 'Contacto creado',
                            ),
                          ),
                        );
                      },
                      child: Text(isEditing ? 'Actualizar' : 'Crear'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
