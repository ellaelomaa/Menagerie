// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/pages/about_page.dart';
import 'package:lists/pages/checklists_page.dart';
import 'package:lists/pages/folder_page.dart';
import 'package:lists/pages/homepage.dart';
import 'package:lists/pages/notes_page.dart';
import 'package:lists/pages/ordered_page.dart';
import 'package:lists/pages/tarot_decks_page.dart';

class CustomDrawerButton extends StatelessWidget {
  const CustomDrawerButton(this.text, this.destination, this.flexSize,
      {super.key});

  final String text;
  final String destination;
  final int flexSize;

  final double borderRadiusSize = 12;

  _routeTo(String destination, BuildContext context) {
    if (destination == "home") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
      );
    }
    if (destination == "notes") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotesPage(),
        ),
      );
    }
    if (destination == "folders") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FolderPage(),
        ),
      );
    }
    if (destination == "tarot") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TarotDecksPage(),
        ),
      );
    }
    if (destination == "ordered") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderedPage(),
        ),
      );
    }
    if (destination == "checklist") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChecklistsPage(),
        ),
      );
    }
    if (destination == "about") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AboutPage(),
        ),
      );
    }
  }

  AssetImage _drawerImage(String destination) {
    if (destination == "home") {
      return AssetImage("assets/images/forepaugh.jpg");
    }
    if (destination == "notes") {
      return AssetImage("assets/images/gentry.jpg");
    }
    if (destination == "folders") {
      return AssetImage("assets/images/floating.jpg");
    }
    if (destination == "tarot") {
      return AssetImage("assets/images/yucca.jpg");
    }
    if (destination == "ordered") {
      return AssetImage("assets/images/trampolin.jpg");
    } else if (destination == "checklist") {
      return AssetImage("assets/images/watercircus.jpg");
    } else {
      return AssetImage("assets/images/tarot.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexSize,
      child: InkWell(
        onTap: () => _routeTo(destination, context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 6, 6, 6),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderRadiusSize),
                    bottomRight: Radius.circular(borderRadiusSize),
                  ),
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: _drawerImage(destination),
                      // image: AssetImage("lib/assets/images/trapeze.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderRadiusSize),
                    bottomRight: Radius.circular(borderRadiusSize),
                  ),
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
              Positioned.fill(
                left: 20,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
