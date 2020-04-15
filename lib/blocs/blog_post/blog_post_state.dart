part of 'blog_post_bloc.dart';

@immutable
abstract class BlogPostState extends Equatable {
  const BlogPostState();

  @override
  List<Object> get props => [];
}

class BlogPostStateUninitialized extends BlogPostState {}

class BlogPostStateError extends BlogPostState {}

class BlogPostStateLoaded extends BlogPostState {
  final List<BlogPost> blogPosts;
  final bool hasReachedMax;

  const BlogPostStateLoaded({
    this.blogPosts,
    this.hasReachedMax,
  });

  // A utility that duplicates an instance with overrides.
  BlogPostStateLoaded copyWith({
    List<BlogPost> blogPost,
    bool hasReachedMax,
  }) {
    return BlogPostStateLoaded(
      blogPosts: blogPosts ?? this.blogPosts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [blogPosts, hasReachedMax];

  @override
  String toString() =>
      'BlogPostStateLoaded { blogPosts: ${blogPosts.length}, hasReachedMax: $hasReachedMax }';
}
