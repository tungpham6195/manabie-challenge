import 'package:flutter/material.dart';
import 'package:manabie_todo_app/models/models.dart';

class TodoItem extends StatelessWidget {
  final Todo item;
  final ValueChanged<bool> onChanged;

  TodoItem({this.item, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: item.isCompleted,
      onChanged: onChanged,
      title: Text(item.description),
    );
  }
}
