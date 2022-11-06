import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
