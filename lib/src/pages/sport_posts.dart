import 'package:flutter/material.dart';
// import 'package:dw_app/src/resources/news_api_provider.dart';
import 'package:dw_app/src/widgets/post_list.dart';
// import 'package:dw_app/src/providers/posts_provider.dart';
import 'package:dw_app/src/blocs/posts_provider.dart';

class SportPosts extends StatelessWidget {
  Widget build(context) {
    // NewsApiProvider apiProvider = NewsApiProvider();

    //postsProvider.getAllPosts("catagory");
    //  print(postsProvider.posts.length);
    return Flex(
      children: <Widget>[
        PostsProvider(child: PostList([131]))
      ],
      direction: Axis.vertical,
    );
  }
}
