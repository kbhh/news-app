import 'package:flutter/material.dart';
import 'package:dw_app/src/blocs/posts_provider.dart';
import 'package:dw_app/src/widgets/post_list.dart';
import 'package:dw_app/src/widgets/post_slides.dart';

class HomePosts extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Center(
          child: Container(
            child: Flex(
              children: <Widget>[
                PostsProvider(child: PostSlides()),
                PostsProvider(child: PostList([137, 160])),
              ],
              direction: Axis.vertical,
            ),
          ),
        );
      },
    );
  }
}
