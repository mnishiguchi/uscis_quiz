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

  // Creates an instance from the API response JSON.
  static BlogPost fromJson(dynamic json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
