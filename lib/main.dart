import 'package:beamer/beamer.dart';
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

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TodoHippo',
      theme: ThemeData(
        // useMaterial3: true,
        colorSchemeSeed: const Color(0xff9d9df8), // Color(0xFFEC511E),
        textTheme: GoogleFonts.comfortaaTextTheme(),
        appBarTheme: AppBarTheme.of(context).copyWith(
          toolbarTextStyle: GoogleFonts.berkshireSwash(),
          elevation: 4,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // routerConfig: router,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
        alwaysBeamBack: true,
      ),
    );
  }
}
