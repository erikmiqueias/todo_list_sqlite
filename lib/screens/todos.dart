import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list_sqlite/helpers/date_format.dart';
import 'package:todo_list_sqlite/providers/date_provider.dart';
import 'package:todo_list_sqlite/widgets/list_completed_tasks.dart';
import 'package:todo_list_sqlite/widgets/list_uncompleted_tasks.dart';
import 'package:todo_list_sqlite/widgets/title.dart';

class TodosScreen extends ConsumerStatefulWidget {
  const TodosScreen({super.key, required this.title});
  final Widget title;

  @override
  ConsumerState<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends ConsumerState<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    final date = ref.watch(dateProvider);

    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          widget.title,
          const Spacer(),
          SvgPicture.asset('assets/avatar.svg', height: 35, width: 35),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 18,
          children: [
            TodoTitle(todoDateTitle: 'Hoje', date: formatDate(date)),
            const ListUncompletedTasks(),
            const TodoTitle(todoDateTitle: 'Completas Hoje'),
            const ListCompletedTasks(),
          ],
        ),
      ),
    );
  }
}
