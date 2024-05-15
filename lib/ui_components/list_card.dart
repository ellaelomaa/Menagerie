// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lists/database/models/parent_model.dart';
import 'package:lists/providers/parent_provider.dart';
import 'package:provider/provider.dart';

class ListCard extends StatelessWidget {
  final ParentModel parent;
  const ListCard({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentProvider>(context, listen: false);

    void deleteList(BuildContext context, int id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to delete this list? This cannot be undone."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  parentProvider.deleteParent(id);
                  Navigator.pop(context);
                },
                child: Text("Delete"),
              ),
            ],
          );
        },
      );
    }

    return Consumer<ParentProvider>(
      builder: (context, provider, child) => SizedBox(
        width: double.infinity,
        child: ListTile(
          title: Text(parent.title),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Edit")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Delete")
                  ],
                ),
              ),
            ],
            offset: Offset(30, 10),
            onSelected: (value) {
              if (value == 2) {
                deleteList(context, parent.id!);
              }
            },
          ),
        ),
      ),
    );
  }
}
