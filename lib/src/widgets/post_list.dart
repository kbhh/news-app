import 'package:flutter/material.dart';
import 'package:dw_app/src/widgets/post_tile.dart';
import 'package:dw_app/src/blocs/posts_provider.dart';

class PostList extends StatelessWidget {
  List<int> categories;
  PostList(this.categories);

  Widget build(context) {
    final bloc = PostsProvider.of(context);
    bloc.fetchPosts(categories);

    return Expanded(
      child: SizedBox(
        child: StreamBuilder(
          stream: bloc.posts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: PostTile(snapshot.data[index]),
                      onTap: () {
                        Navigator.pushNamed(context, '/postDetail',
                            arguments: snapshot.data[index]);
                      },
                    );
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
