import 'package:flutter/material.dart';
import 'package:menagerie_provider/assets/ui_components/app_bar.dart';
import 'package:menagerie_provider/assets/ui_components/drawer.dart';
import 'package:menagerie_provider/database/db_helper.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Homepage"),
      drawer: DrawerNav(),
      body: Column(children: [
        ElevatedButton(
          child: const Text("Delete db"),
          onPressed: () {
            DatabaseHelper().deleteDB();
          },
        ),
      ]),
    );
  }
}
