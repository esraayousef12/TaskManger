import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TaskMangerApp());
}

class TaskMangerApp extends StatefulWidget {
  const TaskMangerApp({super.key});

  @override
  State<TaskMangerApp> createState() => _TaskMangerAppState();
}

class _TaskMangerAppState extends State<TaskMangerApp> {
  bool isDarkMode = false;
  bool isEnglish = false;

  void toggleTheme() {
    setState(() => isDarkMode = !isDarkMode);
  }

  void toggleLanguage() {
    setState(() => isEnglish = !isEnglish);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manger',
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: HomeScreen(
        toggleTheme: toggleTheme,
        isEnglish: isEnglish,
        toggleLanguage: toggleLanguage,
      ),
    );
  }
}
