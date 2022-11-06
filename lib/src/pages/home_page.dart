import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todoapp/src/components/todo_list.dart';
import 'package:todoapp/src/services/todo.dart';

import '../models/todo.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoService todoService = Get.find();

  TextEditingController todoInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: TodoList(
                onTodoTap: (int todoId) async =>
                    await showTodoPopup(context, todoId),
              ),
            ),
            TextField(
              controller: todoInputController,
              onSubmitted: (value) async {
                final todo = Todo(todoInputController.text);
                try {
                  await todoService.putTodo(todo);
                  todoInputController.text = '';
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cannot add todo')),
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Put todo here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showTodoPopup(BuildContext context, int todoId) async {
    final todo = await todoService.getTodo(todoId);
    if (mounted) {
      Scaffold.of(context).showBottomSheet(
        (context) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: Expanded(
            child: Column(
              children: [
                Text(
                  '${todo?.title}',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        elevation: 1,
        constraints: BoxConstraints(
          minWidth: 360,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
      );
    }
  }
}
