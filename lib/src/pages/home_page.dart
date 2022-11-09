import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool showResolved = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'TodoHippo',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 4),
            LineIcon.hippo(color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.beamToNamed('/settings'),
            icon: LineIcon.cog(),
          ),
          SizedBox(width: 8),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 219, 79, 224),
                Colors.blue,
              ],
              transform: GradientRotation(1.2),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Todo',
            icon: LineIcon.alternateList(),
          ),
          BottomNavigationBarItem(
            label: 'Resolved',
            icon: LineIcon.envelopeSquare(),
          )
        ],
        onTap: (value) => setState(() {
          showResolved = value == 1;
          currentIndex = value;
        }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Expanded(
                child: TodoList(
                  showResolved: showResolved,
                  onTodoTap: (int todoId) =>
                      context.beamToNamed('/todo/$todoId'),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
}
