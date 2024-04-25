// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lists/pages/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final textController = TextEditingController();
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: SafeArea(
    //     child: Scaffold(
    //       appBar: CustomAppBar(),
    //       drawer: DrawerNav(),
    //       floatingActionButton: FloatingActionButton(
    //         onPressed: () async {
    //           selectedId != null
    //               ? await DatabaseHelper.instance.update(
    //                   Folder(id: selectedId, name: textController.text),
    //                 )
    //               : await DatabaseHelper.instance.addFolder(
    //                   Folder(name: textController.text),
    //                 );
    //           setState(
    //             () {
    //               textController.clear();
    //               selectedId = null;
    //             },
    //           );
    //         },
    //         child: Icon(Icons.save),
    //       ),
    //       body: Center(
    //         child: Text("HOME"),
    //       ),
    //     ),
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
