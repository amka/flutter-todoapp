import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key, required this.child});

  Widget child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApp'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.goNamed('settings'),
            icon: Icon(LineIcons.cog),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
