import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/todo_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/todo/:todoId',
      name: 'todo',
      builder: (context, state) => TodoPage(
        todoId: int.parse(
          state.params['todoId']!,
        ),
      ),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
