import 'package:isar/isar.dart';

part 'todo.g.dart';

enum TodoState {
  open,
  inprogress,
  verify,
  done,
}

@collection
class Todo {
  Id? id;
  String title;
  String? description;

  @enumerated
  TodoState state;

  late DateTime createdAt;
  late DateTime updatedAt;
  DateTime? deadline;

  Todo(
    this.title, {
    this.description,
    this.state = TodoState.open,
    this.deadline,
  }) {
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }
}
