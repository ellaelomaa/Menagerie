// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:menagerie_provider/database/models/folder_model.dart';
import 'package:menagerie_provider/providers/folder_provider.dart';
import 'package:provider/provider.dart';

class FolderRow extends StatelessWidget {
  final FolderModel folder;
  const FolderRow({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    return Consumer<FolderProvider>(
      builder: (context, provider, child) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            tileColor: Color.fromARGB(224, 212, 164, 198),
            title: Text(folder.title),
            subtitle: Text(folder.id.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                provider.deleteFolder(folder.id!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
