import 'dart:convert';
import 'dart:io';

import 'package:drf_quickstart_client/models/post.dart';
import 'package:drf_quickstart_client/models/user.dart';
import 'package:http/http.dart' as http;

class Repository {
  static User? _authenticatedUser;

  static void _setAuthenticatedUser(User user) {
    print(user.url);
    print(user.email);
    print(user.userName);
    _authenticatedUser = user;
  }

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/users/'),
    );
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      final List<dynamic> results = parsedJson['results'];
      final List<User> users =
          results.map((json) => User.fromJson(json)).toList();
      _setAuthenticatedUser(users.first);
      print('authenticated user: $_authenticatedUser');
      return users;
    } else {
      print('statuc code: ${response.statusCode}');
      throw Exception(response.body);
    }
  }

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/posts/'),
    );
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final parsedJson = jsonDecode(decodedBody);
      final List<dynamic> results = parsedJson['results'];
      final List<Post> posts =
          results.map((json) => Post.fromJson(json)).toList();
      return posts;
    } else {
      print('statuc code: ${response.statusCode}');
      throw Exception(response.body);
    }
  }

  static Future<void> createPost() async {
    const User author = User(
      url: 'http://localhost:8000/api/users/6/',
      userName: 'yo', // userNameを指定する場合は適切な値を入れてください
      email: 'admin@example.com', // emailを指定する場合は適切な値を入れてください
      groups: [],
    );
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/posts/'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'author': author.url,
        'text': 'text',
        'created_at': DateTime.now().toString(),
        'image': null,
      }),
    );
    if (response.statusCode != 200) {
      print('statuc code: ${response.statusCode}');
      print(response.reasonPhrase);
      throw Exception(response.body);
    }
  }
}
