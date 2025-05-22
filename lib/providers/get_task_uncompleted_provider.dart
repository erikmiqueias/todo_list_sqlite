import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo_list_sqlite/models/todo.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class TaskUncompletedProvider
    extends StateNotifier<List<Map<String, dynamic>>> {
  TaskUncompletedProvider() : super([]);

  Future<void> getUncompletedTasks() async {
    final db = DatabaseService.instance;
    final result = await db.getUncompletedTasks();
    state = [...result];
    db.closeDatabase();
  }
}

final taskUncompletedProvider =
    StateNotifierProvider<TaskUncompletedProvider, List<Map<String, dynamic>>>(
      (ref) => TaskUncompletedProvider(),
    );
