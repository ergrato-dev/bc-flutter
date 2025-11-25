// lib/screens/notes_screen.dart

import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_manager.dart';

/// Pantalla de Gestión de Notas
///
/// ¿Qué hace?
/// Permite ver, crear, editar y eliminar notas con categorías
///
/// ¿Para qué?
/// Proporcionar un bloc de notas organizado por categorías
///
/// ¿Cómo funciona?
/// - Lista de notas con vista previa
/// - Filtro por categoría
/// - Búsqueda en contenido
/// - Editor de notas con formato
class NotesScreen extends StatefulWidget {
  final NoteManager noteManager;

  const NotesScreen({super.key, required this.noteManager});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  NoteCategory? _filterCategory;
  String _searchQuery = '';
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    // Obtener notas filtradas
    var notes = widget.noteManager.notes;

    // Aplicar filtros
    if (_filterCategory != null) {
      notes = notes.where((note) => note.category == _filterCategory).toList();
    }
    if (_showFavoritesOnly) {
      notes = notes.where((note) => note.isFavorite).toList();
    }
    if (_searchQuery.isNotEmpty) {
      notes = widget.noteManager.searchNotes(_searchQuery);
    }

    // Ordenar por fecha de actualización (más reciente primero)
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mis Notas'),
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
            tooltip: 'Favoritas',
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

          // Filtro de categorías
          _buildCategoryFilter(),

          // Lista de notas
          Expanded(
            child: notes.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return _buildNoteCard(notes[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewNote,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Nota'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar en notas...',
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

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCategoryChip(
            label: 'Todas',
            isSelected: _filterCategory == null,
            onTap: () {
              setState(() {
                _filterCategory = null;
              });
            },
          ),
          const SizedBox(width: 8),
          ...NoteCategory.values.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildCategoryChip(
                label: category.label,
                color: Color(category.colorValue),
                isSelected: _filterCategory == category,
                onTap: () {
                  setState(() {
                    _filterCategory = category;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String label,
    Color? color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: color?.withOpacity(0.1),
      selectedColor:
          color?.withOpacity(0.3) ??
          Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: color,
      labelStyle: TextStyle(
        color: isSelected
            ? (color ?? Theme.of(context).colorScheme.primary)
            : null,
        fontWeight: isSelected ? FontWeight.bold : null,
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      elevation: 2,
      color: Color(note.category.colorValue).withOpacity(0.05),
      child: InkWell(
        onTap: () => _editNote(note),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera con categoría y favorito
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Badge de categoría
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(note.category.colorValue).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      note.category.label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(note.category.colorValue),
                      ),
                    ),
                  ),

                  // Favorito
                  IconButton(
                    icon: Icon(
                      note.isFavorite ? Icons.star : Icons.star_border,
                      color: note.isFavorite ? Colors.amber : Colors.grey,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        note.toggleFavorite();
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Título
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Vista previa del contenido
              Expanded(
                child: Text(
                  note.content.isEmpty ? 'Sin contenido' : note.content,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 8),

              // Footer con fecha y menú
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Fecha de actualización
                  Text(
                    _formatDate(note.updatedAt),
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),

                  // Menú de opciones
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              'Eliminar',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editNote(note);
                      } else if (value == 'delete') {
                        _deleteNote(note);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No hay notas',
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
                : 'Crea tu primera nota',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'Ahora';
    if (difference.inHours < 1) return 'Hace ${difference.inMinutes} min';
    if (difference.inDays < 1) return 'Hace ${difference.inHours}h';
    if (difference.inDays < 7) return 'Hace ${difference.inDays}d';

    return '${date.day}/${date.month}/${date.year}';
  }

  void _showStatistics() {
    final stats = widget.noteManager.getStatistics();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Estadísticas de Notas'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatRow('Total de notas:', '${stats['total']}'),
              _buildStatRow('Favoritas:', '${stats['favorites']}'),

              const Divider(height: 30),

              const Text(
                'Por Categoría:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...NoteCategory.values.map(
                (category) => _buildStatRow(
                  '${category.label}:',
                  '${stats['byCategory'][category.name]}',
                ),
              ),
            ],
          ),
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

  void _addNewNote() {
    _showNoteForm();
  }

  void _editNote(Note note) {
    _showNoteForm(note: note);
  }

  void _deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Nota'),
        content: Text('¿Estás seguro de eliminar "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.noteManager.removeNote(note.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Nota eliminada')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showNoteForm({Note? note}) {
    final isEditing = note != null;
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');
    NoteCategory selectedCategory = note?.category ?? NoteCategory.personal;
    bool isFavorite = note?.isFavorite ?? false;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? 'Editar Nota' : 'Nueva Nota',
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

              // Título
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Título *',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // Categoría
              DropdownButtonFormField<NoteCategory>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                items: NoteCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color(category.colorValue),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(category.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setModalState(() {
                      selectedCategory = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // Contenido
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
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
                      if (titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('El título es obligatorio'),
                          ),
                        );
                        return;
                      }

                      setState(() {
                        if (isEditing) {
                          note.title = titleController.text.trim();
                          note.content = contentController.text.trim();
                          note.category = selectedCategory;
                          note.isFavorite = isFavorite;
                          note.updatedAt = DateTime.now();
                        } else {
                          final newNote = Note(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            title: titleController.text.trim(),
                            content: contentController.text.trim(),
                            category: selectedCategory,
                            isFavorite: isFavorite,
                          );
                          widget.noteManager.addNote(newNote);
                        }
                      });

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isEditing ? 'Nota actualizada' : 'Nota creada',
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
    );
  }
}
