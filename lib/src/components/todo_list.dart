import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../models/todo.dart';

class TodoList extends StatefulWidget {
  TodoList({super.key, this.onTodoTap});

  Function(int)? onTodoTap;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Isar isar = Get.find();
  late Stream<void> todoChanged;
  List<Todo>? todos;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    todoChanged = isar.todos.watchLazy();
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
                    tileColor: Theme.of(context).colorScheme.surfaceVariant,
                    onTap: widget.onTodoTap != null
                        ? () => widget.onTodoTap!(item.id!)
                        : null,
                    title: Text(item.title),
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
    return await isar.todos.where().findAll();
  }
}
