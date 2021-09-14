import 'dart:convert';

class User {
  final User user;
  final String token;
  User({
    required this.user,
    required this.token,
  });

  User copyWith({
    required User user,
    required String token,
  }) {
    return User(
      user: user,
      token: token,
    );
  }

  User merge(User model) {
    return User(
      user: model.user,
      token: model.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
  
    return User(
      user: User.fromMap(map['user']),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(user: $user, token: $token)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.user == user &&
      o.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}