import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'routes/routes.dart'; // Import your AppColors file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.secondaryColor,
      ),
      initialRoute: Routes.home,
      onGenerateRoute: generateRoute, // Use the generateRoute function
    );
  }
}
