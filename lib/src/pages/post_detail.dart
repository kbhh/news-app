import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/Post.dart';

class PostDetail extends StatelessWidget {
  Post post;
  PostDetail(this.post);

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 10,
            valueColor: AlwaysStoppedAnimation(Colors.redAccent)),
      ),
    );

    final postDate = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        getDate(),
        style: TextStyle(color: Colors.white),
      ),
    );
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 80.0),
        Text(
          post.postCatagories.cats[0].toString(),
          style: TextStyle(color: Colors.white, fontSize: 19.0),
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          post.postTitle,
          style: TextStyle(color: Colors.white, fontSize: 28.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 2, child: levelIndicator),
            Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(
              flex: 5,
              child: postDate,
            )
          ],
        ),
      ],
    );

    final topContent = SliverAppBar(
      expandedHeight: 350.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        background: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10.0),
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new CachedNetworkImageProvider(
                      post.postFeaturedMedia.thumbnail,
                    ),
                    fit: BoxFit.fill,
                  ),
                )),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.fromLTRB(30.0, 5.0, 20.0, 0.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
              child: Center(
                child: topContentText,
              ),
            ),
          ],
        ),
      ),
    );

    final bottomContentText = Expanded(
      flex: 0,
      child: SingleChildScrollView(
        child: Html(
          useRichText: true,
          data: post.postContent,
          renderNewlines: true,
          defaultTextStyle: TextStyle(fontSize: 16),
        ),
      ),
    );

    final bottomContent = SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  bottomContentText,
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Copyright ©" + DateTime.now().year.toString() + " DW",
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[topContent, bottomContent]),
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
