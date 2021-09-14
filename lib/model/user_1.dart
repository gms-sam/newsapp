// import 'dart:convert';

// import 'email__verified__at.dart';

// class User {
//   final int id;
//   final String name;
//   final String email;
//   final Email_verified_at emailVerifiedAt;
//   final String createdAt;
//   final String updatedAt;
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   User copyWith({
//     int id,
//     String name,
//     String email,
//     Email_verified_at emailVerifiedAt,
//     String createdAt,
//     String updatedAt,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   User merge(User model) {
//     return User(
//       id: model.id ?? this.id,
//       name: model.name ?? this.name,
//       email: model.email ?? this.email,
//       emailVerifiedAt: model.emailVerifiedAt ?? this.emailVerifiedAt,
//       createdAt: model.createdAt ?? this.createdAt,
//       updatedAt: model.updatedAt ?? this.updatedAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'email_verified_at': emailVerifiedAt?.toMap(),
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return User(
//       id: map['id']?.toInt(),
//       name: map['name'],
//       email: map['email'],
//       emailVerifiedAt: Email_verified_at.fromMap(map['email_verified_at']),
//       createdAt: map['created_at'],
//       updatedAt: map['updated_at'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'User(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is User &&
//       o.id == id &&
//       o.name == name &&
//       o.email == email &&
//       o.emailVerifiedAt == emailVerifiedAt &&
//       o.createdAt == createdAt &&
//       o.updatedAt == updatedAt;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       name.hashCode ^
//       email.hashCode ^
//       emailVerifiedAt.hashCode ^
//       createdAt.hashCode ^
//       updatedAt.hashCode;
//   }
// }