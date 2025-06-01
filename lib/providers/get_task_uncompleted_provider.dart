import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/providers/date_provider.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class TaskUncompletedProvider
    extends StateNotifier<List<Map<String, dynamic>>> {
  TaskUncompletedProvider(this.ref) : super([]) {
    ref.listen(dateProvider, (previous, next) {
      getUncompletedTasks();
    });

    getUncompletedTasks(); // Busca inicial
  }
  final Ref ref;

  Future<void> getUncompletedTasks() async {
    final date = ref.read(dateProvider);
    final db = DatabaseService.instance;
    final result = await db.getUncompletedTasks(date);
    state = [...result];
  }
}

final taskUncompletedProvider =
    StateNotifierProvider<TaskUncompletedProvider, List<Map<String, dynamic>>>(
      (ref) => TaskUncompletedProvider(ref),
    );
