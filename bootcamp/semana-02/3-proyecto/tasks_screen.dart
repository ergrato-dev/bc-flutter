// lib/screens/tasks_screen.dart

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_manager.dart';

/// Pantalla de Gestión de Tareas
///
/// ¿Qué hace?
/// Permite ver, crear, editar y eliminar tareas
///
/// ¿Para qué?
/// Proporcionar una interfaz completa para gestionar tareas diarias
///
/// ¿Cómo funciona?
/// - Muestra lista de tareas con filtros
/// - Permite cambiar estado con tap
/// - Formulario para agregar/editar tareas
/// - Estadísticas en tiempo real
class TasksScreen extends StatefulWidget {
  final TaskManager taskManager;

  const TasksScreen({super.key, required this.taskManager});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskStatus? _filterStatus;
  Priority? _filterPriority;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Obtener tareas filtradas
    var tasks = widget.taskManager.tasks;

    // Aplicar filtros
    if (_filterStatus != null) {
      tasks = tasks.where((task) => task.status == _filterStatus).toList();
    }
    if (_filterPriority != null) {
      tasks = tasks.where((task) => task.priority == _filterPriority).toList();
    }
    if (_searchQuery.isNotEmpty) {
      tasks = widget.taskManager.searchTasks(_searchQuery);
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mis Tareas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
            tooltip: 'Filtros',
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

          // Filtros activos
          if (_filterStatus != null || _filterPriority != null)
            _buildActiveFilters(),

          // Lista de tareas
          Expanded(
            child: tasks.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return _buildTaskCard(tasks[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewTask,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Tarea'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar tareas...',
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

  Widget _buildActiveFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: [
          if (_filterStatus != null)
            Chip(
              label: Text(_filterStatus!.label),
              onDeleted: () {
                setState(() {
                  _filterStatus = null;
                });
              },
            ),
          if (_filterPriority != null)
            Chip(
              label: Text(_filterPriority!.label),
              onDeleted: () {
                setState(() {
                  _filterPriority = null;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => _editTask(task),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera con checkbox y prioridad
              Row(
                children: [
                  // Checkbox para completar
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          task.complete();
                        } else {
                          task.reset();
                        }
                      });
                    },
                  ),

                  // Título
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted ? Colors.grey : null,
                      ),
                    ),
                  ),

                  // Badge de prioridad
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(task.priorityColor).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      task.priority.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(task.priorityColor),
                      ),
                    ),
                  ),

                  // Menú de opciones
                  PopupMenuButton(
                    itemBuilder: (context) => [
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
                        _editTask(task);
                      } else if (value == 'delete') {
                        _deleteTask(task);
                      }
                    },
                  ),
                ],
              ),

              // Descripción
              if (task.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              // Fecha y tags
              const SizedBox(height: 12),
              Row(
                children: [
                  // Estado
                  _buildInfoChip(
                    icon: Icons.circle,
                    label: task.status.label,
                    color: _getStatusColor(task.status),
                  ),

                  const SizedBox(width: 8),

                  // Fecha de vencimiento
                  if (task.dueDate != null)
                    _buildInfoChip(
                      icon: task.isOverdue
                          ? Icons.warning
                          : Icons.calendar_today,
                      label: _formatDate(task.dueDate!),
                      color: task.isOverdue ? Colors.red : Colors.blue,
                    ),

                  const Spacer(),

                  // Tags
                  if (task.tags.isNotEmpty)
                    Chip(
                      label: Text(
                        '${task.tags.length} tags',
                        style: const TextStyle(fontSize: 11),
                      ),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No hay tareas',
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
                : 'Crea tu primera tarea',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.orange;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.cancelled:
        return Colors.red;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);

    final difference = dateToCheck.difference(today).inDays;

    if (difference == 0) return 'Hoy';
    if (difference == 1) return 'Mañana';
    if (difference == -1) return 'Ayer';
    if (difference > 1 && difference < 7) return 'En $difference días';
    if (difference < -1) return 'Hace ${-difference} días';

    return '${date.day}/${date.month}/${date.year}';
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filtros',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Filtro por estado
              const Text(
                'Estado:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Todos'),
                    selected: _filterStatus == null,
                    onSelected: (selected) {
                      setModalState(() {
                        _filterStatus = null;
                      });
                    },
                  ),
                  ...TaskStatus.values.map(
                    (status) => FilterChip(
                      label: Text(status.label),
                      selected: _filterStatus == status,
                      onSelected: (selected) {
                        setModalState(() {
                          _filterStatus = selected ? status : null;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Filtro por prioridad
              const Text(
                'Prioridad:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Todas'),
                    selected: _filterPriority == null,
                    onSelected: (selected) {
                      setModalState(() {
                        _filterPriority = null;
                      });
                    },
                  ),
                  ...Priority.values.map(
                    (priority) => FilterChip(
                      label: Text(priority.label),
                      selected: _filterPriority == priority,
                      onSelected: (selected) {
                        setModalState(() {
                          _filterPriority = selected ? priority : null;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setModalState(() {
                        _filterStatus = null;
                        _filterPriority = null;
                      });
                    },
                    child: const Text('Limpiar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text('Aplicar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStatistics() {
    final stats = widget.taskManager.getStatistics();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Estadísticas de Tareas'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatRow('Total de tareas:', '${stats['total']}'),
              _buildStatRow('Completadas:', '${stats['completed']}'),
              _buildStatRow('Pendientes:', '${stats['pending']}'),
              _buildStatRow('Atrasadas:', '${stats['overdue']}'),
              _buildStatRow(
                'Tasa de completitud:',
                '${stats['completionRate']}%',
              ),

              const Divider(height: 30),

              const Text(
                'Por Prioridad:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildStatRow('Baja:', '${stats['byPriority']['low']}'),
              _buildStatRow('Media:', '${stats['byPriority']['medium']}'),
              _buildStatRow('Alta:', '${stats['byPriority']['high']}'),
              _buildStatRow('Crítica:', '${stats['byPriority']['critical']}'),
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

  void _addNewTask() {
    _showTaskForm();
  }

  void _editTask(Task task) {
    _showTaskForm(task: task);
  }

  void _deleteTask(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Tarea'),
        content: Text('¿Estás seguro de eliminar "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.taskManager.removeTask(task.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Tarea eliminada')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showTaskForm({Task? task}) {
    final isEditing = task != null;
    final titleController = TextEditingController(text: task?.title ?? '');
    final descriptionController = TextEditingController(
      text: task?.description ?? '',
    );
    Priority selectedPriority = task?.priority ?? Priority.medium;
    DateTime? selectedDate = task?.dueDate;

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
              Text(
                isEditing ? 'Editar Tarea' : 'Nueva Tarea',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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

              // Descripción
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              // Prioridad
              DropdownButtonFormField<Priority>(
                value: selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Prioridad',
                  border: OutlineInputBorder(),
                ),
                items: Priority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setModalState(() {
                      selectedPriority = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // Fecha de vencimiento
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  selectedDate == null
                      ? 'Sin fecha de vencimiento'
                      : 'Vence: ${_formatDate(selectedDate!)}',
                ),
                trailing: selectedDate != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setModalState(() {
                            selectedDate = null;
                          });
                        },
                      )
                    : null,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setModalState(() {
                      selectedDate = date;
                    });
                  }
                },
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
                          final updated = task.copyWith(
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            priority: selectedPriority,
                            dueDate: selectedDate,
                          );
                          widget.taskManager.updateTask(task.id, updated);
                        } else {
                          final newTask = Task(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            priority: selectedPriority,
                            dueDate: selectedDate,
                          );
                          widget.taskManager.addTask(newTask);
                        }
                      });

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isEditing ? 'Tarea actualizada' : 'Tarea creada',
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
