import 'package:go_router/go_router.dart';
import 'package:todoapp/src/layouts/main_layout.dart';
import 'package:todoapp/src/pages/home_page.dart';

final router = GoRouter(routes: [
  ShellRoute(
    builder: ((context, state, child) => MainLayout(child: child)),
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomePage(),
      ),
    ],
  )
]);
