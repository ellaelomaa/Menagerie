// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/ui_components/app_bar.dart';

class TarotPage extends StatelessWidget {
  const TarotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Tarot page"),
      body: SafeArea(
        top: false,
        child: Center(
          child: Text("TAROT PAGE"),
        ),
      ),
    );
  }
}
