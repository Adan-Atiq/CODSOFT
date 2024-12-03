import 'package:flutter/material.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/TaskPage.dart';
import '../Screens/CreateTaskPage.dart'; // Import CreateTaskPage

// Define routes here
class Routes {
  static const String home = '/';
  static const String taskPage = '/taskPage';
  static const String createTaskPage = '/createTaskPage'; // Add route for CreateTaskPage
}

// Define a function to get the routes
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case Routes.taskPage:
      return MaterialPageRoute(builder: (_) => TaskPage());
    case Routes.createTaskPage:
      return MaterialPageRoute(builder: (_) => CreateTaskPage()); // Add route for CreateTaskPage
    default:
      return MaterialPageRoute(builder: (_) => HomeScreen()); // Default route
  }
}
