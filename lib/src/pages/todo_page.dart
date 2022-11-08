import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:line_icons/line_icon.dart';

import '../components/todo_state_checkbox.dart';
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
  final deadlineController = TextEditingController();
  Todo? todo;

  @override
  void initState() {
    super.initState();
    todo = todoService.getTodoSync(widget.todoId);
    if (todo != null) {
      titleController.text = todo!.title;
      decriptionController.text = todo!.description ?? '';
      if (todo!.deadline != null) {
        deadlineController.text = Jiffy(todo!.deadline).yMMMd;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    decriptionController.dispose();
    deadlineController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
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
                          label: Text('Title'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                          label: Text('Description'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: deadlineController,
                        decoration: InputDecoration(
                          // prefixIcon: LineIcon.calendar(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: "Deadline",
                          suffix: todo!.deadline != null
                              ? InkWell(
                                  child: LineIcon.trash(
                                    size: 16,
                                  ),
                                  // borderRadius: BorderRadius.circular(18),
                                  onTap: () {
                                    todo!.deadline = null;
                                    setState(() {
                                      deadlineController.text = '';
                                    });
                                  },
                                )
                              : null,
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime
                                .now(), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              deadlineController.text = Jiffy(pickedDate).yMMMd;
                              todo!.deadline = pickedDate;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          TodoStateCheckbox(
                            checked: todo!.resolved,
                            onPressed: () async {
                              await todoService.toggleDoneState(todo!.id!);
                              setState(() {
                                todo!.state = todo!.resolved
                                    ? TodoState.open
                                    : TodoState.done;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Is Done',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: todo!.resolved
                                  ? TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(100))
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: MaterialButton(
                  onPressed: () async {
                    if (todo != null) {
                      todo!.title = titleController.text;
                      todo!.description = decriptionController.text;
                      await todoService.updateTodo(todo!);
                    }

                    if (mounted) {
                      context.beamToNamed('/');
                    }
                  },
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
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
