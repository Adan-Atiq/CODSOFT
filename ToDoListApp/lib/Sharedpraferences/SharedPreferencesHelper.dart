import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/taskModel.dart';

class SharedPreferencesHelper {
  static const String tasksKey = "tasks";

  // Save tasks list to SharedPreferences
  static Future<void> saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(tasksKey, jsonString);
  }

  // Load tasks list from SharedPreferences
  static Future<List<Task>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(tasksKey);

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Task.fromJson(json)).toList();
    }

    return []; // Return an empty list if no tasks are found
  }
}
