import 'dart:convert';

class User {
  final String name;
  final String email;
  final String updatedAt;
  final String createdAt;
  final int id;
  User({
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  User copyWith({
    String? name,
    String? email,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  User merge(User model) {
    return User(
      name: model.name,
      email: model.email,
      updatedAt: model.updatedAt,
      createdAt: model.createdAt,
      id: model.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {

  
    return User(
      name: map['name'],
      email: map['email'],
      updatedAt: map['updated_at'],
      createdAt: map['created_at'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, email: $email, updatedAt: $updatedAt, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.name == name &&
      o.email == email &&
      o.updatedAt == updatedAt &&
      o.createdAt == createdAt &&
      o.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode ^
      id.hashCode;
  }
}