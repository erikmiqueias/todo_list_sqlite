import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/providers/get_task_completed_provider.dart';
import 'package:todo_list_sqlite/providers/get_task_uncompleted_provider.dart';
import 'package:todo_list_sqlite/widgets/task_completed.dart';

class ListCompletedTasks extends ConsumerStatefulWidget {
  const ListCompletedTasks({super.key, this.onRefresh});
  final Future<void> Function()? onRefresh;

  @override
  ConsumerState<ListCompletedTasks> createState() => _ListCompletedTasksState();
}

class _ListCompletedTasksState extends ConsumerState<ListCompletedTasks> {
  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
  }

  Future<void> _getCompletedTasks() async {
    await ref.read(taskCompletedProvider.notifier).getCompletedTasks();
    await ref.read(taskUncompletedProvider.notifier).getUncompletedTasks();
  }

  Widget _buildNoTasks() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No tasks completed!',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = ref.watch(taskCompletedProvider);
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
                              description: completedTasks[index]['description'],
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
