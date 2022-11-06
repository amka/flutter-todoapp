import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';

import '../components/todo_list.dart';
import '../models/todo.dart';
import '../services/todo.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            onPressed: () => context.goNamed('settings'),
            icon: LineIcon.cog(),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Expanded(
                child: TodoList(
                  onTodoTap: (int todoId) async =>
                      await showTodoPopup(context, todoId),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextField(
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showTodoPopup(BuildContext context, int todoId) async {
    context.goNamed('todo', params: {'todoId': '$todoId'});
    // final todo = await todoService.getTodo(todoId);
    // if (mounted) {
    //   Scaffold.of(context).showBottomSheet(
    //     (context) => Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Column(
    //         children: [
    //           Text(
    //             '${todo?.title}',
    //             style: const TextStyle(fontWeight: FontWeight.w400),
    //           ),
    //         ],
    //       ),
    //     ),
    //     elevation: 4,
    //     backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    //     constraints: BoxConstraints(
    //       minWidth: double.infinity,
    //       maxHeight: MediaQuery.of(context).size.height * 0.8,
    //     ),
    //   );
    // }
  }
}
