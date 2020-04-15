part of 'blog_post_bloc.dart';

@immutable
abstract class BlogPostEvent extends Equatable {
  const BlogPostEvent();

  @override
  List<Object> get props => [];
}

class BlogPostEventFetch extends BlogPostEvent {}
