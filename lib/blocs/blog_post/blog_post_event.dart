import 'package:equatable/equatable.dart';

// Extends Equatable so that we can compare instances.
// https://pub.dev/packages/equatable
abstract class BlogPostEvent extends Equatable {
  const BlogPostEvent();

  @override
  List<Object> get props => [];
}

class BlogPostEventFetch extends BlogPostEvent {}
