class Todo {
  final int id;
  final String description;
  final ToDoStatus status;

  Todo({this.id, this.description, this.status = ToDoStatus.incomplete});

  bool get isCompleted => status == ToDoStatus.completed;

  Todo copyWith({
    int id,
    String description,
    ToDoStatus status,
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}

enum ToDoStatus {
  completed,
  incomplete,
}
