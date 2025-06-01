import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/helpers/date_format.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
  });
  final String title;
  final String description;
  final String date;
  final int isCompleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Tarefa')),
      body: Container(
        padding: const EdgeInsets.all(35),
        width: double.infinity,
        child: Column(
          spacing: 20,
          children: [
            Container(
              width: 250,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(title),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(description, softWrap: true),
            ),
            Container(
              alignment: Alignment.center,
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                formatDate(date),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Status: ${isCompleted == 1 ? 'Concluída' : 'Não Concluida'}',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCompleted == 1 ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
