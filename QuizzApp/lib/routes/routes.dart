import 'package:flutter/material.dart';
import '../Screens/CreateQuizPage.dart';
import '../Screens/home_page.dart';


class Routes {
  static const String home = '/';
  static const String createQuiz = '/createQuiz';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case createQuiz:
        return MaterialPageRoute(builder: (_) => const CreateQuizPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
