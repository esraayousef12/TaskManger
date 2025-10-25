import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../models/task_model.dart';
import '../localization/app_localization.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isEnglish;
  final VoidCallback toggleLanguage;

  const SettingsScreen({
    super.key,
    required this.toggleTheme,
    required this.isEnglish,
    required this.toggleLanguage,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int completedCount = 0;
  int pendingCount = 0;

  @override
  void initState() {
    super.initState();
    loadTaskCounts();
  }

  Future<void> loadTaskCounts() async {
    List<TaskModel> tasks = await TaskService.getTasks();
    setState(() {
      completedCount = tasks.where((t) => t.isDone).length;
      pendingCount = tasks.length - completedCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalization(isEnglish: widget.isEnglish);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              title: Text(loc.darkLightMode),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (val) => widget.toggleTheme(),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(loc.language),
              trailing: ElevatedButton(
                onPressed: widget.toggleLanguage,
                child: Text(widget.isEnglish ? 'English' : 'عربي'),
              ),
            ),
            const Divider(),
            ListTile(title: Text(loc.tasksCompleted), trailing: Text('$completedCount')),
            ListTile(title: Text(loc.tasksPending), trailing: Text('$pendingCount')),
          ],
        ),
      ),
    );
  }
}
