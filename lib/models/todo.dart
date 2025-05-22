class Todo {
  final int isChecked;
  final String title;
  final String todoDate;
  final int? id;
  final String description;
  final int isFavorite;

  const Todo({
    this.id,
    required this.description,
    required this.isChecked,
    required this.title,
    required this.todoDate,
    required this.isFavorite,
  });
}
