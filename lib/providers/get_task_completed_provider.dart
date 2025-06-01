import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/providers/date_provider.dart';
// import 'package:todo_list_sqlite/models/todo.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class TaskCompletedProvider extends StateNotifier<List<Map<String, dynamic>>> {
  TaskCompletedProvider(this.ref) : super([]) {
    ref.listen(dateProvider, (prev, nex) {
      getCompletedTasks();
    });
  }

  final Ref ref;

  Future<void> getCompletedTasks() async {
    final date = ref.read(dateProvider);
    final db = DatabaseService.instance;
    final result = await db.getCompletedTasks(date);
    state = result.toList();
    db.closeDatabase();
  }
}

final taskCompletedProvider =
    StateNotifierProvider<TaskCompletedProvider, List<Map<String, dynamic>>>(
      (ref) => TaskCompletedProvider(ref),
    );
