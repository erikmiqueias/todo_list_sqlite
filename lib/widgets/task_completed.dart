import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/helpers/date_format.dart';
import 'package:todo_list_sqlite/screens/task_details.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class TaskCompleted extends StatefulWidget {
  const TaskCompleted({
    super.key,
    required this.date,
    required this.title,
    required this.isChecked,
    required this.id,
    required this.onRefresh,
    required this.description,
  });

  final String date;
  final String title;
  final String description;
  final int isChecked;
  final int id;
  final Future<void> Function() onRefresh;

  @override
  State<TaskCompleted> createState() => _TaskCompletedState();
}

class _TaskCompletedState extends State<TaskCompleted> {
  bool? _isChecked;

  void _setIsChecked(bool? value) async {
    final db = DatabaseService.instance;
    if (value!) {
      await db.updateTask(widget.id, 1);
      await widget.onRefresh.call();
      setState(() {
        _isChecked = value;
      });
      return;
    }

    await db.updateTask(widget.id, 0);
    await widget.onRefresh.call();

    setState(() {
      _isChecked = value;
    });
    db.closeDatabase();
  }

  void _changeToTaskDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => TaskDetailsScreen(
              title: widget.title,
              description: widget.description,
              date: widget.date.toString(),
              isCompleted: widget.isChecked,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _changeToTaskDetailsScreen,
      child: Container(
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
        width: 330,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        formatDate(widget.date),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                child: Row(
                  children: [
                    const Text('Completed'),
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: _isChecked ?? widget.isChecked == 1,
                        onChanged: (value) {
                          _setIsChecked(value);
                        },
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
