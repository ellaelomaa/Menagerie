// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/pages/homepage.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:lists/providers/parent_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FolderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ParentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ),
    );
  }
}
