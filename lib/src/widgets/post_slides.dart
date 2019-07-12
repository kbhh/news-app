import 'package:flutter/material.dart';
import './post_slide.dart';
import '../blocs/posts_provider.dart';

class PostSlides extends StatelessWidget {
  Widget build(context) {
    final bloc = PostsProvider.of(context);
    bloc.fetchPosts([107]);
    return Expanded(
      flex: 0,
      child: SizedBox(
        height: 225,
        child: StreamBuilder(
          stream: bloc.posts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child: new PostSlide(snapshot.data[index]),
                        onTap: () {
                          Navigator.pushNamed(context, '/postDetail',
                              arguments: snapshot.data[index]);
                        });
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
