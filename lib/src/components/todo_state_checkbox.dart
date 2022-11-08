import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class TodoStateCheckbox extends StatefulWidget {
  TodoStateCheckbox({super.key, this.checked = false, this.onPressed});

  Function()? onPressed;
  bool checked;

  @override
  State<TodoStateCheckbox> createState() => _TodoStateCheckboxState();
}

class _TodoStateCheckboxState extends State<TodoStateCheckbox> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: widget.checked ? LineIcon.checkSquare() : LineIcon.square(),
      color: widget.checked
          ? Theme.of(context).colorScheme.onSurface.withAlpha(100)
          : null,
      splashRadius: 6,
    );
  }
}
