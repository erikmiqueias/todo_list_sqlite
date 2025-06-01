import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo_list_sqlite/models/todo.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class DeleteTaskNotifier extends StateNotifier<void> {
  DeleteTaskNotifier() : super(null);

  Future<void> deleteTask(int id) async {
    final db = DatabaseService.instance;
    await db.deleteTask(id);
    db.closeDatabase();
  }
}

final deleteTaskProvider = StateNotifierProvider((ref) => DeleteTaskNotifier());
