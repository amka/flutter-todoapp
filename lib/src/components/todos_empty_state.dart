import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class TodosEmptyState extends StatelessWidget {
  const TodosEmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LineIcon.hippo(
          size: 64,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(height: 12),
        Text(
          'No todos',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ],
    );
  }
}
