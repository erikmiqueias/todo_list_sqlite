import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/models/todo.dart';
import 'package:todo_list_sqlite/providers/get_task_completed_provider.dart';
import 'package:todo_list_sqlite/providers/get_task_uncompleted_provider.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class CreateTaskNotifier extends StateNotifier<void> {
  CreateTaskNotifier() : super(null);

  Future<void> createTask(Todo todo, WidgetRef ref) async {
    final db = DatabaseService.instance;
    await db.createTask(todo.title, todo.description, todo.todoDate);
    await ref.read(taskUncompletedProvider.notifier).getUncompletedTasks();
    await ref.read(taskCompletedProvider.notifier).getCompletedTasks();
    db.closeDatabase();
  }
}

final createTaskProvider = StateNotifierProvider<CreateTaskNotifier, void>((
  ref,
) {
  return CreateTaskNotifier();
});
