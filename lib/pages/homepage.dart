import 'package:flutter/material.dart';
import 'package:lists/assets/ui_components/app_bar.dart';
import 'package:lists/assets/ui_components/drawer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Homepage"),
      drawer: DrawerNav(),
      body: Center(
        child: Text("Homepage"),
      ),
    );
  }
}
