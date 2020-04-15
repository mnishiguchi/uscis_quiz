import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import 'package:uscisquiz/models/models.dart';
import 'package:uscisquiz/repositories/repositories.dart';

part 'blog_post_event.dart';
part 'blog_post_state.dart';

class BlogPostBloc extends Bloc<BlogPostEvent, BlogPostState> {
  static const FETCH_LIMIT = 20;

  final BlogPostRepository blogPostRepository;

  BlogPostBloc({@required this.blogPostRepository});

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
    if (event is BlogPostEventFetch && !_hasReachedMax(state)) {
      yield* onFetch(event);
    }
  }

  Stream<BlogPostState> onFetch(BlogPostEventFetch event) async* {
    try {
      if (state is BlogPostStateUninitialized) {
        final List<BlogPost> blogPosts =
            await blogPostRepository.getBlogPosts(0, FETCH_LIMIT);
        yield BlogPostStateLoaded(blogPosts: blogPosts, hasReachedMax: false);
        return;
      }
      if (state is BlogPostStateLoaded) {
        final currentState = state as BlogPostStateLoaded;
        final List<BlogPost> blogPosts = await blogPostRepository.getBlogPosts(
            currentState.blogPosts.length, FETCH_LIMIT);
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

  bool _hasReachedMax(BlogPostState state) =>
      state is BlogPostStateLoaded && state.hasReachedMax;
}
