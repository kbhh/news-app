import 'package:flutter/material.dart';
import '../models/Post.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostTile extends StatelessWidget {
  Post post;
  PostTile(this.post);

  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: SizedBox(
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.7,
                child: Center(
                  child: new CachedNetworkImage(
                    imageUrl: post.postFeaturedMedia.thumbnail,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 2.0, 5.0),
                  child: postDesc(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget postDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.postTitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getDate(),
                style: const TextStyle(fontSize: 12.0, color: Colors.black54),
              ),
              Text(
                post.postCatagories.cats[0],
                style: const TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
              Icon(
                Icons.bookmark_border,
                size: 35.0,
              ),
            ],
          ),
        )
      ],
    );
  }

  String getDate() {
    var parsed_date = DateTime.parse(post.postDate);
    var hours_from_now = DateTime.now().difference(parsed_date).inHours;
    hours_from_now =
        hours_from_now.isNegative ? hours_from_now * -1 : hours_from_now;
    var post_date;

    if (hours_from_now > 24) {
      post_date = parsed_date.difference(DateTime.now()).inDays.isNegative
          ? ((parsed_date.difference(DateTime.now()).inDays * -1).toString() +
              " Days ago")
          : parsed_date.difference(DateTime.now()).inDays.toString() +
              "Days ago";
    } else {
      post_date = hours_from_now.toString() + " hours ago";
    }

    return post_date;
  }
}
