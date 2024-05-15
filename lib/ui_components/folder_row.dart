// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/providers/folder_provider.dart';
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
              trailing: folder.id! != 1
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.deleteFolder(folder.id!);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                      ],
                    )
                  : null),
        ),
      ),
    );
  }
}
