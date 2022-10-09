import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  static const String routeName = '/createPost';

  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Create Post'),
      ),
    );
  }
}
