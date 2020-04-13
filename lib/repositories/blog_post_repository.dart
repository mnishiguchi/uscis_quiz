import 'dart:async' show Future;
import 'package:meta/meta.dart' show required;

import 'package:uscisquiz/models/models.dart' show BlogPost;
import 'package:uscisquiz/repositories/blog_post_api_client.dart';

class BlogPostRepository {
  final BlogPostApiClient blogPostClient;

  BlogPostRepository({@required this.blogPostClient})
      : assert(blogPostClient != null);

  Future<List<BlogPost>> getBlogPosts(int startIndex, int limit) async {
    return blogPostClient.fetchBlogPosts(startIndex, limit);
  }
}
