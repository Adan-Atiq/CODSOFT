import 'package:flutter/material.dart';
import 'package:quizapp/routes/routes.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'QuickQuiz',
theme: ThemeData(primarySwatch: Colors.deepPurple),
initialRoute: Routes.home,
onGenerateRoute: Routes.generateRoute,
);
}
}
