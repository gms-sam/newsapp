import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });


  User merge(User model) {
    return User(
      id: model.id,
      name: model.name,
      email: model.email,
      emailVerifiedAt: model.emailVerifiedAt,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
  
    return User(
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'],
      emailVerifiedAt: map['email_verified_at']??"",
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.id == id &&
      o.name == name &&
      o.email == email &&
      o.emailVerifiedAt == emailVerifiedAt &&
      o.createdAt == createdAt &&
      o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      emailVerifiedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}