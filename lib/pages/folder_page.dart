// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/assets/ui_components/app_bar.dart';
import 'package:lists/assets/ui_components/fab.dart';
import 'package:lists/assets/ui_components/folder_dropdown.dart';
import 'package:lists/assets/ui_components/folder_row.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:provider/provider.dart';

class FolderPage extends StatelessWidget {
  const FolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Folders"),
      floatingActionButton: FAB(),
      body: Consumer<FolderProvider>(
        builder: (context, provider, child) {
          var folders = provider.folders;
          return Column(
            children: <Widget>[
              FoldersDropdown(),
              Expanded(
                child: ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    var folder = folders[index];
                    return FolderRow(folder: folder);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
