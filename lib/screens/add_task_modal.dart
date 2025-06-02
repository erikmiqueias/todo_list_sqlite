import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/models/todo.dart';
import 'package:todo_list_sqlite/providers/create_task_provider.dart';
import 'package:todo_list_sqlite/providers/get_task_completed_provider.dart';
import 'package:todo_list_sqlite/providers/get_task_uncompleted_provider.dart';
import 'package:todo_list_sqlite/widgets/modal_button.dart';

class AddTaskModalScreen extends ConsumerStatefulWidget {
  const AddTaskModalScreen({super.key});

  @override
  ConsumerState<AddTaskModalScreen> createState() => _AddTaskModalScreenState();
}

class _AddTaskModalScreenState extends ConsumerState<AddTaskModalScreen> {
  DateTime? _selectedDate;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitForm() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: const Text('Alguns campos estão vazios'),
              content: const Text(
                'Por favor preencha todos os campos obrigatórios.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }
    _addTask();
    Navigator.pop(context);
  }

  void _addTask() async {
    await ref
        .read(createTaskProvider.notifier)
        .createTask(
          Todo(
            title: _titleController.text,
            description: _descriptionController.text,
            todoDate: _selectedDate.toString(),
            isChecked: 0,
            isFavorite: 0,
          ),
          ref,
        );

    await ref.read(taskUncompletedProvider.notifier).getUncompletedTasks();
    await ref.read(taskCompletedProvider.notifier).getCompletedTasks();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Título da tarefa',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Descrição da tarefa',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: TextButton.icon(
                    onPressed: _presentDatePicker,
                    icon: Icon(Icons.calendar_month_sharp),
                    label: Text(
                      _selectedDate != null
                          ? '${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}'
                          : 'Nenhuma data selecionada',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ModalButton(
                  onPress: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                ModalButton(
                  onPress: () => _submitForm(),
                  child: Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
