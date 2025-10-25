import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskService {
  static const String TASKS_KEY = 'tasks';

  static Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString(TASKS_KEY);
    if (tasksString != null) {
      List decoded = jsonDecode(tasksString);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List encoded = tasks.map((e) => e.toJson()).toList();
    await prefs.setString(TASKS_KEY, jsonEncode(encoded));
  }

  static Future<void> addTask(TaskModel task) async {
    List<TaskModel> tasks = await getTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  static Future<void> updateTask(TaskModel task) async {
    List<TaskModel> tasks = await getTasks();
    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      await saveTasks(tasks);
    }
  }

  static Future<void> deleteTask(int id) async {
    List<TaskModel> tasks = await getTasks();
    tasks.removeWhere((t) => t.id == id);
    await saveTasks(tasks);
  }
}
