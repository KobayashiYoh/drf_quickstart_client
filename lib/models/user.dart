import 'package:flutter/foundation.dart';

@immutable
class User {
  final String url;
  final String? userName;
  final String email;
  final List groups;

  const User({
    required this.url,
    required this.userName,
    required this.email,
    required this.groups,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      url: json['url'],
      userName: json['username'] ?? '',
      email: json['email'],
      groups: json['groups'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'username': userName,
      'email': email,
      'groups': groups,
    };
  }
}
