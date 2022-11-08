import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class TodoBottomBar extends StatefulWidget {
  const TodoBottomBar({super.key});

  @override
  State<TodoBottomBar> createState() => _TodoBottomBarState();
}

class _TodoBottomBarState extends State<TodoBottomBar> {
  int currentItem = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      onTap: (value) {
        value == 0
            ? context.beamToNamed('/')
            : context.beamToNamed('/resolved');

        setState(() {
          currentItem = value;
        });
      },
    );
  }
}
