import 'package:flutter/material.dart';
import 'package:lists/assets/ui_components/app_bar.dart';

class ChecklistsPage extends StatelessWidget {
  const ChecklistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Checklists"),
      body: SafeArea(
        top: false,
        child: Center(
          child: Text("CHECKLISTS"),
        ),
      ),
    );
  }
}
