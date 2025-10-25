class TaskModel {
  int id;
  String title;
  String description;
  String category;
  DateTime startDate;
  DateTime endDate;
  String startTime;
  String endTime;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'startTime': startTime,
    'endTime': endTime,
    'isDone': isDone,
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    category: json['category'],
    startDate: DateTime.parse(json['startDate']),
    endDate: DateTime.parse(json['endDate']),
    startTime: json['startTime'],
    endTime: json['endTime'],
    isDone: json['isDone'],
  );
}
