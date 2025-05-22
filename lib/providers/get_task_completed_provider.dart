import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo_list_sqlite/models/todo.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class TaskCompletedProvider extends StateNotifier<List<Map<String, dynamic>>> {
  TaskCompletedProvider() : super([]);

  Future<void> getCompletedTasks() async {
    final db = DatabaseService.instance;
    final result = await db.getCompletedTasks();
    state = result.toList();
    db.closeDatabase();
  }
}

final taskCompletedProvider =
    StateNotifierProvider<TaskCompletedProvider, List<Map<String, dynamic>>>(
      (ref) => TaskCompletedProvider(),
    );
