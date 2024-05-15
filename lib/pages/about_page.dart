// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/ui_components/app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Ordered lists"),
      body: SafeArea(
        top: false,
        child: Center(
          child: Text("ORDERED LISTS"),
        ),
      ),
    );
  }
}
