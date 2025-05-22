import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/providers/delete_task_provider.dart';
import 'package:todo_list_sqlite/widgets/todo.dart';

import 'package:todo_list_sqlite/providers/get_task_completed_provider.dart';
import 'package:todo_list_sqlite/providers/get_task_uncompleted_provider.dart';

class ListUncompletedTasks extends ConsumerStatefulWidget {
  const ListUncompletedTasks({super.key});

  @override
  ConsumerState<ListUncompletedTasks> createState() =>
      _ListUncompletedTasksState();
}

class _ListUncompletedTasksState extends ConsumerState<ListUncompletedTasks> {
  Future<void> _getUncompletedTasks() async {
    await ref.read(taskUncompletedProvider.notifier).getUncompletedTasks();
    await ref.read(taskCompletedProvider.notifier).getCompletedTasks();
  }

  Future<void> deleteTask(int id) async {
    await ref.read(deleteTaskProvider.notifier).delteTask(id);
    await _getUncompletedTasks();
    showSnackBar();
  }

  @override
  void initState() {
    super.initState();
    _getUncompletedTasks();
  }

  Widget _buildNoTasks() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No tasks to do!',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted'), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskUncompletedProvider);
    return SizedBox(
      height: 250,
      child: RefreshIndicator(
        onRefresh: _getUncompletedTasks,
        child:
            tasks.isEmpty
                ? ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [_buildNoTasks()],
                    ),
                  ],
                )
                : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 10),
                                child: const Icon(Icons.delete, size: 30),
                              ),
                            ),
                            Dismissible(
                              key: ValueKey(tasks[index]['id']),
                              background: Icon(Icons.delete, size: 30),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                deleteTask(tasks[index]['id']);
                              },
                              child: TodoWidget(
                                id: tasks[index]['id'],
                                title: tasks[index]['title'],
                                date: tasks[index]['date'],
                                description: tasks[index]['description'],
                                isChecked: tasks[index]['isCompleted'],
                                isFavorite: tasks[index]['isFavorite'],
                                onRefresh: _getUncompletedTasks,
                              ),
                            ),
                          ],
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
