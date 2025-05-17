import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/services/database_service.dart';

class Todo extends StatefulWidget {
  const Todo({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.id,
    required this.isChecked,
    required this.isFavorite,
    this.onRefresh,
  });
  final String title;
  final String date;
  final String description;
  final int id;
  final int isChecked;
  final int isFavorite;
  final Future<void> Function()? onRefresh;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool? _isChecked;
  bool? _isFavorite;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked == 1;
    _isFavorite = widget.isFavorite == 1;
  }

  void _setIsChecked(bool? value) async {
    final db = DatabaseService.instance;
    if (value!) {
      await db.updateTask(widget.id, 1);
      setState(() {
        _isChecked = value;
      });
      await widget.onRefresh?.call();
      return;
    }

    await db.updateTask(widget.id, 0);
    setState(() {
      _isChecked = value;
    });
  }

  void _setIsFavorite(bool? value) async {
    final db = DatabaseService.instance;
    if (value!) {
      await db.updateFavorite(widget.id, 1);
      await widget.onRefresh?.call();

      setState(() {
        _isFavorite = value;
      });

      db.closeDatabase();
      return;
    }

    await db.updateFavorite(widget.id, 0);
    await widget.onRefresh?.call();
    setState(() {
      _isFavorite = value;
    });
    db.closeDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 4),
        ],
      ),
      width: 330,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: _isChecked ?? widget.isChecked == 1,
                    onChanged: (value) {
                      _setIsChecked(value);
                    },
                    shape: const CircleBorder(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.yellow.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              child: Icon(
                widget.isFavorite == 1 ? Icons.star : Icons.star_border,
                size: 23,
              ),
              onTap: () {
                _setIsFavorite(!(_isFavorite ?? widget.isFavorite == 1));
              },
            ),
          ],
        ),
      ),
    );
  }
}
