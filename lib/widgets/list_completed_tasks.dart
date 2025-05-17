import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/services/database_service.dart';
import 'package:todo_list_sqlite/widgets/task_completed.dart';

class ListCompletedTasks extends StatefulWidget {
  const ListCompletedTasks({super.key, this.onRefresh});
  final Future<void> Function()? onRefresh;

  @override
  State<ListCompletedTasks> createState() => _ListCompletedTasksState();
}

class _ListCompletedTasksState extends State<ListCompletedTasks> {
  List<Map<String, dynamic>> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
  }

  Future<void> _getCompletedTasks() async {
    final db = DatabaseService.instance;
    final result = await db.getCompletedTasks();
    setState(() {
      completedTasks = result.toList();
      return;
    });
  }

  Widget _buildNoTasks() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No tasks completed',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    completedTasks.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: RefreshIndicator(
        onRefresh: _getCompletedTasks,
        child:
            completedTasks.isEmpty
                ? ListView(children: [_buildNoTasks()])
                : ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (ctx, index) {
                    return completedTasks.isEmpty
                        ? _buildNoTasks()
                        : Column(
                          children: [
                            TaskCompleted(
                              onRefresh: _getCompletedTasks,
                              date: completedTasks[index]['date'],
                              title: completedTasks[index]['title'],
                              isChecked: completedTasks[index]['isCompleted'],
                              id: completedTasks[index]['id'],
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
