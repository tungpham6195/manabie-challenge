import 'package:flutter/material.dart';

class EnterNewTodoDialog extends StatefulWidget {
  final ValueSetter<String> onSubmitted;

  EnterNewTodoDialog({
    this.onSubmitted,
  });

  @override
  _EnterNewTodoDialogState createState() => _EnterNewTodoDialogState();
}

class _EnterNewTodoDialogState extends State<EnterNewTodoDialog> {
  final todoTfController = TextEditingController();

  @override
  void dispose() {
    todoTfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
          child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              TextField(
                controller: todoTfController,
                decoration:
                    InputDecoration(hintText: 'Input your description here!'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      widget.onSubmitted?.call(todoTfController.text);
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
