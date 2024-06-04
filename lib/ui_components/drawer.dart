import 'package:flutter/material.dart';
import 'package:lists/ui_components/drawer_button.dart';

class DrawerNav extends StatelessWidget {
  const DrawerNav({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              child: Center(
                child: Text("Choose your fate"),
              ),
            ),
          ),
          CustomDrawerButton("Home", "home", 2),
          CustomDrawerButton("Notes", "notes", 2),
          CustomDrawerButton("Folders", "folders", 2),
          CustomDrawerButton("Tarot", "tarot", 2),
          CustomDrawerButton("Ordered", "ordered", 2),
          CustomDrawerButton("Checklists", "checklist", 2),
          CustomDrawerButton("About", "about", 1),
        ],
      ),
    );
  }
}
