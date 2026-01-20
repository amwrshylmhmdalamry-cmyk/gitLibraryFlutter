class UserModel {
  String id;
  String email;
  String name;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  // من Map إلى UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? 'مستخدم',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'].toString())
          : DateTime.now(),
    );
  }

  // من UserModel إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}