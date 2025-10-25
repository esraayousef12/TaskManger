import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import 'add_edit_task_screen.dart';
import 'settings_screen.dart';
import '../widgets/task_card.dart';
import '../localization/app_localization.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isEnglish;
  final VoidCallback toggleLanguage;

  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isEnglish,
    required this.toggleLanguage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];
  List<TaskModel> filteredTasks = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    tasks = await TaskService.getTasks();
    setState(() => filteredTasks = tasks);
  }

  void filterTasks(String query) {
    setState(() {
      filteredTasks = tasks
          .where((t) => t.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleDone(TaskModel task) async {
    task.isDone = !task.isDone;
    await TaskService.updateTask(task);
    loadTasks();
  }

  void deleteTask(TaskModel task) async {
    await TaskService.deleteTask(task.id);
    loadTasks();
  }

  void navigateToAddTask([TaskModel? task]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditTaskScreen(task: task)),
    );
    loadTasks();
  }

  void navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          toggleTheme: widget.toggleTheme,
          isEnglish: widget.isEnglish,
          toggleLanguage: widget.toggleLanguage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalization(isEnglish: widget.isEnglish);
    int completedCount = tasks.where((t) => t.isDone).length;
    int pendingCount = tasks.length - completedCount;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.taskManager),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: navigateToSettings),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: loc.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: filterTasks,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${loc.tasksCompleted}: $completedCount'),
                Text('${loc.tasksPending}: $pendingCount'),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filteredTasks.isEmpty
                  ? Center(child: Text(loc.noTasks))
                  : ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return TaskCard(
                    task: task,
                    onToggleDone: () => toggleDone(task),
                    onDelete: () => deleteTask(task),
                    onEdit: () => navigateToAddTask(task),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddTask(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
