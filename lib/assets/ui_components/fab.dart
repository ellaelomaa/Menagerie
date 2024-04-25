import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FAB extends StatefulWidget {
  const FAB({super.key});

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      spacing: 6,
      spaceBetweenChildren: 6,
      openCloseDial: isDialOpen,
      children: [
        SpeedDialChild(
          child: Icon(Icons.folder),
          label: "New folder",
        ),
        SpeedDialChild(
          child: Icon(Icons.note),
          label: "New note",
        ),
      ],
    );
  }
}