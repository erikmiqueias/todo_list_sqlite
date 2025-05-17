import 'package:flutter/material.dart';

class TodosDateTitle extends StatelessWidget {
  const TodosDateTitle({super.key, required this.todoDateTitle, this.date});
  final String todoDateTitle;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return date != null
        ? Row(
          spacing: 10,
          children: [
            Text(
              todoDateTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(date!, style: TextStyle(color: Colors.grey.shade500)),
          ],
        )
        : Row(
          children: [
            Text(
              todoDateTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        );
  }
}
