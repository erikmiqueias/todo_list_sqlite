import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/services/database_service.dart';
import 'package:todo_list_sqlite/widgets/todo.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  List<Map<String, dynamic>> tasks = [];

  Future<void> _getUncompletedTasks() async {
    final db = DatabaseService.instance;
    final result = await db.getUncompletedTasks();
    setState(() {
      tasks = result.toList();
      tasks.sort((a, b) => b['isFavorite'].compareTo(a['isFavorite']));
    });
  }

  @override
  void initState() {
    super.initState();
    _getUncompletedTasks();
  }

  Widget _buildNoTasks() {
    return const Center(
      child: Text(
        'No tasks to do!',
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }

  @override
  void dispose() {
    tasks.clear();
    super.dispose();
  }

  void deleteTask(int id) async {
    final db = DatabaseService.instance;
    await db.deleteTask(id);
    await _getUncompletedTasks();
    showSnackBar();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted'), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: RefreshIndicator(
        onRefresh: _getUncompletedTasks,
        child:
            tasks.isEmpty
                ? ListView(children: [_buildNoTasks()])
                : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Dismissible(
                          onDismissed: (direction) {
                            deleteTask(tasks[index]['id']);
                          },
                          key: ValueKey(tasks[index]['id']),
                          child: Todo(
                            id: tasks[index]['id'],
                            title: tasks[index]['title'],
                            date: tasks[index]['date'],
                            description: tasks[index]['description'],
                            isChecked: tasks[index]['isCompleted'],
                            isFavorite: tasks[index]['isFavorite'],
                            onRefresh: _getUncompletedTasks,
                          ),
                        ),
                        const SizedBox(height: 7),
                      ],
                    );
                  },
                ),
      ),
    );
  }
}
