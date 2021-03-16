import 'package:flutter/material.dart';
import 'package:manabie_todo_app/models/models.dart';

class TodoItem extends StatelessWidget {
  final Todo item;
  final ValueChanged<bool> onChanged;
  final VoidCallback onDeleted;

  TodoItem({
    this.item,
    this.onChanged,
    this.onDeleted,
  }) : super(key: ValueKey(item.id));

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        onDeleted?.call();
      },
      child: CheckboxListTile(
        value: item.isCompleted,
        onChanged: onChanged,
        title: Text(item.description),
      ),
    );
  }
}
