import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/providers/delete_task_provider.dart';
import 'package:todo_list_sqlite/providers/get_task_completed_provider.dart';
import 'package:todo_list_sqlite/providers/get_task_uncompleted_provider.dart';
import 'package:todo_list_sqlite/widgets/todo.dart';

class ListUncompletedTasks extends ConsumerWidget {
  const ListUncompletedTasks({super.key});

  Future<void> deleteTask(BuildContext context, WidgetRef ref, int id) async {
    await ref.read(deleteTaskProvider.notifier).deleteTask(id);
  }

  Future<void> _refreshTasks(WidgetRef ref) async {
    await ref.read(taskUncompletedProvider.notifier).getUncompletedTasks();
    await ref.read(taskCompletedProvider.notifier).getCompletedTasks();
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskUncompletedProvider);

    return SizedBox(
      height: 250,
      child:
          tasks.isEmpty
              ? Center(
                child: Text(
                  'No tasks to do!',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              )
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (ctx, index) {
                  final task = tasks[index];
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
                            key: ValueKey(task['id']),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (_) async {
                              await deleteTask(context, ref, task['id']);
                              await _refreshTasks(ref);
                              showSnackBar(context);
                            },
                            child: TodoWidget(
                              id: task['id'],
                              title: task['title'],
                              date: task['date'],
                              description: task['description'],
                              isChecked: task['isCompleted'],
                              isFavorite: task['isFavorite'],
                              onRefresh: () => _refreshTasks(ref),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                    ],
                  );
                },
              ),
    );
  }
}
