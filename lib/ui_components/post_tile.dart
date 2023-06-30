import 'package:drf_quickstart_client/models/post.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  const PostTile({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('@${post.author}'),
          Text(post.text),
          if (post.image != null) Image.network(post.image!),
          Text('投稿日時: ${post.createdAtText}'),
        ],
      ),
    );
  }
}
