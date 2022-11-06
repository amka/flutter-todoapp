import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';

import '../services/todo.dart';
import '../models/todo.dart';

class TodoPage extends StatefulWidget {
  TodoPage({super.key, required this.todoId});

  int todoId;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoService todoService = Get.find();
  final titleController = TextEditingController();
  final decriptionController = TextEditingController();
  Todo? todo;

  @override
  void initState() {
    super.initState();
    todo = todoService.getTodoSync(widget.todoId);
    if (todo != null) {
      titleController.text = todo!.title;
      decriptionController.text = todo!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        leading: BackButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.goNamed('home'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: titleController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: decriptionController,
                        minLines: 4,
                        maxLines: 8,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await todoService.toggleDoneState(widget.todoId);
                              setState(() {
                                todo!.state = (todo!.state != TodoState.done)
                                    ? TodoState.done
                                    : TodoState.open;
                              });
                            },
                            icon: todo!.state == TodoState.done
                                ? LineIcon.checkSquare()
                                : LineIcon.square(),
                          ),
                          const Expanded(
                            child: Text(
                              'Done',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: MaterialButton(
                  onPressed: () => context.goNamed('home'),
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Save',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
