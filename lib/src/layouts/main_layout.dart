import 'package:flutter/material.dart';

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
      ),
      body: widget.child,
    );
  }
}
