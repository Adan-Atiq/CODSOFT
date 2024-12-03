class Task {
  String title;
  String description;
  String status;
  String endDate; // New field for end date
  String priority; // New field for priority

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.endDate,
    required this.priority,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'status': status,
    'endDate': endDate,
    'priority': priority,
  };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      status: json['status'],
      endDate: json['endDate'],
      priority: json['priority'],
    );
  }
}
