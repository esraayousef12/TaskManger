import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import 'package:intl/intl.dart';
import '../localization/app_localization.dart';

class AddEditTaskScreen extends StatefulWidget {
  final TaskModel? task;
  final bool? isEnglish;

  const AddEditTaskScreen({super.key, this.task, this.isEnglish});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'عمل';
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final List<String> categories = ['عمل', 'لعب', 'دراسة', 'نادي', 'أخرى'];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      selectedCategory = widget.task!.category;
      startDate = widget.task!.startDate;
      endDate = widget.task!.endDate;
      startTime = _stringToTimeOfDay(widget.task!.startTime);
      endTime = _stringToTimeOfDay(widget.task!.endTime);
    }
  }

  TimeOfDay _stringToTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> pickStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => startDate = picked);
  }

  Future<void> pickEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => endDate = picked);
  }

  Future<void> pickStartTime() async {
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: startTime ?? TimeOfDay.now());
    if (picked != null) setState(() => startTime = picked);
  }

  Future<void> pickEndTime() async {
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: endTime ?? TimeOfDay.now());
    if (picked != null) setState(() => endTime = picked);
  }

  Future<void> saveTask() async {
    if (_formKey.currentState!.validate()) {
      final newTask = TaskModel(
        id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: titleController.text,
        description: descriptionController.text,
        category: selectedCategory,
        startDate: startDate ?? DateTime.now(),
        endDate: endDate ?? DateTime.now(),
        startTime: _formatTimeOfDay(startTime ?? TimeOfDay.now()),
        endTime: _formatTimeOfDay(endTime ?? TimeOfDay.now()),
        isDone: widget.task?.isDone ?? false,
      );

      if (widget.task == null) {
        await TaskService.addTask(newTask);
      } else {
        await TaskService.updateTask(newTask);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalization(isEnglish: widget.isEnglish ?? false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? loc.addTask : loc.editTask),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: loc.title),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: loc.description),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedCategory = val);
                },
                decoration: InputDecoration(labelText: loc.category),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: pickStartDate,
                      child: Text(
                        startDate == null ? loc.startDate : DateFormat('yyyy-MM-dd').format(startDate!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: pickEndDate,
                      child: Text(endDate == null ? loc.endDate : DateFormat('yyyy-MM-dd').format(endDate!)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: pickStartTime,
                      child: Text(startTime == null ? loc.startTime : _formatTimeOfDay(startTime!)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: pickEndTime,
                      child: Text(endTime == null ? loc.endTime : _formatTimeOfDay(endTime!)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveTask,
                child: Text(loc.saveTask),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
