import 'package:beamer/beamer.dart';

import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/todo_page.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      // Return either Widgets or BeamPages if more customization is needed
      '/': (context, state, data) => HomePage(),
      '/settings': (context, state, data) => const SettingsPage(),
      '/todo/:todoId': (context, state, data) {
        // Take the path parameter of interest from BeamState
        final todoId = state.pathParameters['todoId']!;
        // Collect arbitrary data that persists throughout navigation
        // Use BeamPage to define custom behavior
        return TodoPage(todoId: int.parse(todoId));
      }
    },
  ),
);
