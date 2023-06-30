import 'package:intl/intl.dart';

class Post {
  final String author;
  final String text;
  final DateTime createdAt;
  final String? image;

  Post({
    required this.author,
    required this.text,
    required this.createdAt,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      author: json['author'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
      image: json['image'],
    );
  }
}

extension PostExtension on Post {
  String get createdAtText {
    DateTime adjustedDateTime = createdAt.toUtc().add(const Duration(hours: 9));
    DateFormat dateFormat = DateFormat('yyyy/M/d H時m分');
    return dateFormat.format(adjustedDateTime);
  }
}
