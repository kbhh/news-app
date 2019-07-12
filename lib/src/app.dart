import 'package:flutter/material.dart';
import 'package:dw_app/src/localization/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:dw_app/src/pages/post_detail.dart';
import 'package:dw_app/src/models/Post.dart';
import 'package:dw_app/src/pages/home_posts.dart';
import 'package:dw_app/src/pages/sport_posts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: [const Locale('tr', 'TR'), const Locale('en', 'US')],
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      title: 'Flutter Internationalization',
      onGenerateRoute: routes,
      home: DefaultTabController(
        length: 4,
        child: new HomePage(),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    Post post;

    if (settings.arguments != null) {
      post = settings.arguments;
    }

    if (settings.name == "/postDetail") {
      return MaterialPageRoute(
        builder: (context) {
          return PostDetail(post);
        },
      );
    } else {
      return MaterialPageRoute(builder: (context) {
        // return
      });
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).trans("news")),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(text: "Home"),
            Tab(text: "Home"),
            Tab(text: "Home"),
            Tab(text: "Home"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            title: new Text("news"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            title: Text("DApp"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            title: Text("Radio"),
          ),
        ],
        currentIndex: 1,
      ),
      body: TabBarView(
        children: <Widget>[
          HomePosts(),
          SportPosts(),
          // Text("hello"),
          Text("hello"),
          Text("hello"),
        ],
      ),
    );
  }
}
