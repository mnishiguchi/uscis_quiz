import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/models/models.dart';

class BlogPostBloc extends Bloc<BlogPostEvent, BlogPostState> {
  static const FETCH_LIMIT = 20;

  // TODO: Use repository pattern instead
  //  https://bloclibrary.dev/#/./architecture
  final http.Client httpClient;

  BlogPostBloc({@required this.httpClient});

  @override
  BlogPostState get initialState => BlogPostStateUninitialized();

  @override
  Stream<BlogPostState> transformEvents(
    Stream<BlogPostEvent> events,
    Stream<BlogPostState> Function(BlogPostEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      next,
    );
  }

  // Fired every time an event is added.
  @override
  Stream<BlogPostState> mapEventToState(BlogPostEvent event) async* {
    final currentState = state;
    if (event is BlogPostEventFetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is BlogPostStateUninitialized) {
          final blogPosts = await _fetchBlogPost(0, FETCH_LIMIT);
          yield BlogPostStateLoaded(blogPosts: blogPosts, hasReachedMax: false);
          return;
        }
        if (currentState is BlogPostStateLoaded) {
          final blogPosts =
              await _fetchBlogPost(currentState.blogPosts.length, FETCH_LIMIT);
          yield blogPosts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : BlogPostStateLoaded(
                  blogPosts: currentState.blogPosts + blogPosts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield BlogPostStateError();
      }
    }
  }

  bool _hasReachedMax(BlogPostState state) =>
      state is BlogPostStateLoaded && state.hasReachedMax;

  Future<List<BlogPost>> _fetchBlogPost(int startIndex, int limit) async {
    // This API has 100 blog posts.
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawBlogPost) {
        return BlogPost(
          id: rawBlogPost['id'],
          title: rawBlogPost['title'],
          body: rawBlogPost['body'],
        );
      }).toList();
    } else {
      throw Exception('Error fetching blog posts');
    }
  }
}
