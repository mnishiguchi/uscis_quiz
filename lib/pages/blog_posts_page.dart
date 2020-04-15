import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/widgets/blog_post_widget.dart';
import 'package:uscisquiz/widgets/bottom_loader.dart';

// This page is stateful because it needs to maintain a scroll controller.
class BlogPostsPage extends StatefulWidget {
  static const routeName = '/blog_posts';

  @override
  BlogPostsPageState createState() => BlogPostsPageState();
}

class BlogPostsPageState extends State<BlogPostsPage> {
  static const SCROLL_THRESHOLD = 200.0;

  final _scrollController = ScrollController();
  BlogPostBloc _blogPostBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _blogPostBloc = BlocProvider.of<BlogPostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    print('[BlogPostsPage] build');

    return BlocBuilder<BlogPostBloc, BlogPostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Blog Posts Page'),
          ),
          body: _buildContent(context, state),
        );
      },
    );
  }

  Widget _buildContent(context, state) {
    if (state is BlogPostStateUninitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is BlogPostStateError) {
      return Center(
        child: Text('failed to fetch blog posts'),
      );
    }
    if (state is BlogPostStateLoaded) {
      if (state.blogPosts.isEmpty) {
        return Center(
          child: Text('no posts'),
        );
      }
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return index >= state.blogPosts.length
              ? BottomLoader()
              : BlogPostWidget(blogPost: state.blogPosts[index]);
        },
        itemCount: state.hasReachedMax
            ? state.blogPosts.length
            : state.blogPosts.length + 1,
        controller: _scrollController,
      );
    }

    return Center(
      child: Text('Something went wrong'),
    );
  }

  // We need to remember to clean up after ourselves and dispose of our
  // ScrollController when the StatefulWidget is disposed.
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Whenever the user scrolls, we calculate how far away from the bottom of the
  // page they are. If the distance is greater than or equal to our threshold,
  // we load more items.
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= SCROLL_THRESHOLD) {
      _blogPostBloc.add(BlogPostEventFetch());
    }
  }
}
