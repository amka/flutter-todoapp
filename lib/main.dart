import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import 'src/services/todo.dart';
import 'src/models/todo.dart';
import 'src/router.dart';

void main() async {
  final isar = await Isar.open([TodoSchema]);
  Get.put(isar);
  Get.lazyPut(() => TodoService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TodoApp',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 28, 75, 125),
        textTheme: GoogleFonts.comfortaaTextTheme(),
        appBarTheme: AppBarTheme.of(context).copyWith(
          toolbarTextStyle: GoogleFonts.berkshireSwash(),
        ),
      ),
      routerConfig: router,
    );
  }
}
