import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

import '../models/todo.dart';
import '../services/todo.dart';

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
      if (mounted) {
        setState(() {
          debugPrint('Todos changed');
        });
      }
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
                  child: Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async =>
                              await toggleDoneState(item.id!),
                          icon: item.state == TodoState.done
                              ? LineIcon.checkSquare()
                              : LineIcon.square(),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: widget.onTodoTap != null
                                ? () => widget.onTodoTap!(item.id!)
                                : null,
                            child: Text(
                              item.title,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: item.state == TodoState.done
                                  ? const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // tileColor: item.state == TodoState.done
                  //     ? Theme.of(context)
                  //         .colorScheme
                  //         .surfaceVariant
                  //         .withAlpha(78)
                  //     : Theme.of(context).colorScheme.surfaceVariant,
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
