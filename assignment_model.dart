class AssignmentModel {
  final String id;
  final String subject;
  final String title;
  final String description;
  final String fileUrl;
  final DateTime dueDate;
  final List<Map<String, dynamic>> submissions; // {studentId, fileUrl, timestamp}

  AssignmentModel({
    required this.id,
    required this.subject,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.dueDate,
    required this.submissions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'dueDate': dueDate.toIso8601String(),
      'submissions': submissions,
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['id'],
      subject: map['subject'],
      title: map['title'],
      description: map['description'],
      fileUrl: map['fileUrl'],
      dueDate: DateTime.parse(map['dueDate']),
      submissions: List<Map<String, dynamic>>.from(map['submissions']),
    );
  }
}
