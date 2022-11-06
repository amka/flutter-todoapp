import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../models/todo.dart';

class TodoService extends GetxService {
  Isar isar = Get.find();

  TodoService() {
    if (isar.todos.countSync() < 1) {
      isar.writeTxnSync(
        () => isar.todos.putAllSync([
          Todo('Mark me as done'),
          Todo('Find out how to create a new todo'),
        ]),
      );
    }
  }

  Future<List<Todo>> getTodos() async {
    return await isar.todos.where().sortByState().findAll();
  }

  Future<Todo?> getTodo(int todoId) async {
    return await isar.todos.get(todoId);
  }

  Todo? getTodoSync(int todoId) {
    return isar.todos.getSync(todoId);
  }

  Future<int> putTodo(Todo todo) async {
    todo.createdAt = DateTime.now();
    todo.updatedAt = DateTime.now();
    return await isar.writeTxn(() async => await isar.todos.put(todo));
  }

  Future<int> updateTodo(Todo todo) async {
    todo.updatedAt = DateTime.now();
    return await isar.writeTxn(() async => await isar.todos.put(todo));
  }

  Future toggleDoneState(int todoId) async {
    final todo = await getTodo(todoId);
    if (todo != null) {
      switch (todo.state) {
        case TodoState.open:
          todo.state = TodoState.done;
          break;
        default:
          todo.state = TodoState.open;
      }
      await putTodo(todo);
    }
  }

  Future<bool> deleteTodo(int todoId) async {
    return await isar.todos.delete(todoId);
  }
}
