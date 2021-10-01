import 'dart:convert';
import 'package:newsapp/model/user_2.dart';

class UserModel {
  final User user;
  final String token;
  UserModel({
    required this.user,
    required this.token,
  });

   Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
  
    return UserModel(
      user: User.fromMap(map['user']),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(user: $user, token: $token)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserModel &&
      o.user == user &&
      o.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}