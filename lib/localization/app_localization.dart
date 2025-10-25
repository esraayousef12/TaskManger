class AppLocalization {
  final bool isEnglish;

  AppLocalization({required this.isEnglish});

  String get taskManager => isEnglish ? 'TASK MANAGER' : 'إدارة المهام';
  String get addTask => isEnglish ? 'Add Task' : 'إضافة مهمة';
  String get editTask => isEnglish ? 'Edit Task' : 'تعديل مهمة';
  String get title => isEnglish ? 'Title' : 'العنوان';
  String get description => isEnglish ? 'Description' : 'الوصف';
  String get category => isEnglish ? 'Category' : 'الفئة';
  String get startDate => isEnglish ? 'Start Date' : 'تاريخ البداية';
  String get endDate => isEnglish ? 'End Date' : 'تاريخ النهاية';
  String get startTime => isEnglish ? 'Start Time' : 'وقت البداية';
  String get endTime => isEnglish ? 'End Time' : 'وقت النهاية';
  String get saveTask => isEnglish ? 'Save Task' : 'حفظ المهمة';
  String get searchHint => isEnglish ? 'Search Task' : 'ابحث عن مهمة';
  String get settings => isEnglish ? 'Settings' : 'الإعدادات';
  String get darkLightMode => isEnglish ? 'Dark / Light Mode' : 'الوضع الداكن / الفاتح';
  String get language => isEnglish ? 'Language' : 'اللغة';
  String get tasksCompleted => isEnglish ? 'Tasks Completed' : 'المهام المكتملة';
  String get tasksPending => isEnglish ? 'Tasks Pending' : 'المهام الغير مكتملة';
  String get noTasks => isEnglish ? 'No Tasks' : 'لا توجد مهام';
}
