import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:uscisquiz/models/models.dart';

class BlogPostApiClient {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client httpClient;

  BlogPostApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<BlogPost>> fetchBlogPosts(int startIndex, int limit) async {
    // This API has 100 blog posts.
    final response =
        await httpClient.get('$baseUrl/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode != 200) {
      throw Exception('Error fetching blog posts');
    }
    final data = json.decode(response.body) as List;
    return data.map((rawBlogPost) => BlogPost.fromJson(rawBlogPost)).toList();
  }
}
