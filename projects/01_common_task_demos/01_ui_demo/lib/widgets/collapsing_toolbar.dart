import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget collapsingToolbar(title, BuildContext context) {
  return Scaffold(
    body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.lightBlueAccent,
            expandedHeight: 200.0,
            floating: true,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                collapseMode: CollapseMode.pin,
                title: Text(title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  "https://miro.medium.com/max/870/0*6B6Wm6ObfZLSNn5y.jpg",
                  fit: BoxFit.cover,
                )),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
        child: Text(sliverAppBarDocs),
      ),
    ),
  );
}

final sliverAppBarDocs = '''SliverAppBar class


A material design app bar that integrates with a CustomScrollView.

An app bar consists of a toolbar and potentially other widgets, such as a TabBar and a FlexibleSpaceBar. App bars typically expose one or more common actions with IconButtons which are optionally followed by a PopupMenuButton for less common operations.


Sliver app bars are typically used as the first child of a CustomScrollView, which lets the app bar integrate with the scroll view so that it can vary in height according to the scroll offset or float above the other content in the scroll view. For a fixed-height app bar at the top of the screen see AppBar, which is used in the Scaffold.appBar slot.

The AppBar displays the toolbar widgets, leading, title, and actions, above the bottom (if any). If a flexibleSpace widget is specified then it is stacked behind the toolbar and the bottom widget.''';
