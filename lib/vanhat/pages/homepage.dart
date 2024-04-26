import 'package:flutter/material.dart';
import 'package:lists/vanhat/assets/drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testi"),
      ),
      drawer: const DrawerNavigation(),
    );
  }
}