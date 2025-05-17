import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
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
              title: const Text('Invalid input!'),
              content: const Text(
                'Please provide valid title, description and date.',
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
    final db = DatabaseService.instance;
    await db.createTask(
      _titleController.text,
      _descriptionController.text,
      _selectedDate.toString().substring(0, 10),
    );
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title Task',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description Task',
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
                          : 'No Date Selected',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(child: Text('Save'), onPressed: () => _submitForm()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
