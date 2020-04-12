import 'package:flutter/material.dart';

import '../models/models.dart';

class BlogPostWidget extends StatelessWidget {
  final BlogPost blogPost;

  const BlogPostWidget({Key key, @required this.blogPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${blogPost.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(blogPost.title),
      isThreeLine: true,
      subtitle: Text(blogPost.body),
      dense: true,
    );
  }
}
