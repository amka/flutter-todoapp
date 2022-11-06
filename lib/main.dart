import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/router.dart';

void main() {
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
