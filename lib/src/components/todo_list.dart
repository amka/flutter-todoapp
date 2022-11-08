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
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: widget.onTodoTap != null
                        ? () => widget.onTodoTap!(item.id!)
                        : null,
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async =>
                              await toggleDoneState(item.id!),
                          icon: item.resolved
                              ? LineIcon.checkSquare()
                              : LineIcon.square(),
                          color: item.resolved
                              ? Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(100)
                              : null,
                          splashRadius: 6,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  item.title,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: item.resolved
                                      ? TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withAlpha(100))
                                      : null,
                                ),
                              ),
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
