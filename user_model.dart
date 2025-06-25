class UserModel {
  final String uid;
  final String role; // Professor, CR, Student
  final String name;
  final String email;
  final String department;
  final String? rollNumber;

  UserModel({
    required this.uid,
    required this.role,
    required this.name,
    required this.email,
    required this.department,
    this.rollNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'role': role,
      'name': name,
      'email': email,
      'department': department,
      'rollNumber': rollNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      role: map['role'],
      name: map['name'],
      email: map['email'],
      department: map['department'],
      rollNumber: map['rollNumber'],
    );
  }
}
