import 'package:drf_quickstart_client/models/post.dart';
import 'package:drf_quickstart_client/models/user.dart';
import 'package:drf_quickstart_client/repository/repository.dart';
import 'package:drf_quickstart_client/ui_components/post_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<User> users;
  late final List<Post> posts;
  bool _isLoading = false;

  void _fetchUsers() async {
    users = await Repository.fetchUsers();
  }

  void _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    posts = await Repository.fetchPosts();
    setState(() {
      _isLoading = false;
    });
  }

  void _createPost() async {
    await Repository.createPost();
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PostTile(post: posts[index]);
                    },
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPost,
        child: const Icon(Icons.add),
      ),
    );
  }
}
