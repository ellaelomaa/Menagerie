// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/vanhat/pages/homepage.dart';
import 'package:lists/vanhat/pages/notes.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Otsikko"),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.adobe),
            title: Text("Notes"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Notes(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
