import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list_sqlite/widgets/list_completed_tasks.dart';
import 'package:todo_list_sqlite/widgets/list_uncompleted_tasks.dart';
import 'package:todo_list_sqlite/widgets/todos_date_title.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key, required this.title});
  final Widget title;

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
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
            const TodosDateTitle(todoDateTitle: 'Today', date: '07-08-2025'),
            const ListUncompletedTasks(),
            const TodosDateTitle(todoDateTitle: 'Completed Today'),
            const ListCompletedTasks(),
          ],
        ),
      ),
    );
  }
}
