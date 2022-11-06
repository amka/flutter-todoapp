import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:todoapp/src/services/todo.dart';

import '../models/todo.dart';

class TodoList extends StatefulWidget {
  TodoList({super.key, this.onTodoTap});

  Function(int)? onTodoTap;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TodoService todoService = Get.find();
  late Stream<void> todoChanged;
  List<Todo>? todos;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    todoChanged = todoService.isar.todos.watchLazy();
    todoChanged.listen((event) {
      setState(() {
        print('Todos changed');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data;
            return ListView.builder(
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    tileColor: item.state == TodoState.done
                        ? Theme.of(context)
                            .colorScheme
                            .surfaceVariant
                            .withAlpha(78)
                        : Theme.of(context).colorScheme.surfaceVariant,
                    onTap: widget.onTodoTap != null
                        ? () => widget.onTodoTap!(item.id!)
                        : null,
                    leading: Checkbox(
                      value: item.state == TodoState.done,
                      onChanged: (bool? value) async {
                        await toggleDoneState(item.id!);
                      },
                    ),
                    title: Text(
                      item.title,
                      style: item.state == TodoState.done
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            )
                          : null,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<Todo>?> loadTodos() async {
    return await todoService.getTodos();
  }

  Future toggleDoneState(int todoId) async {
    await todoService.toggleDoneState(todoId);
  }
}
