import 'package:equatable/equatable.dart';

class BlogPost extends Equatable {
  final int id;
  final String title;
  final String body;

  const BlogPost({this.id, this.title, this.body});

  @override
  List<Object> get props => [id, title, body];

  @override
  String toString() => 'BlogPost { id: $id }';
}
