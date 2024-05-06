import 'package:flutter/material.dart';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:provider/provider.dart';

class FoldersDropdown extends StatelessWidget {
  const FoldersDropdown({super.key});

  DropdownMenuItem<String> getDropdownWidget(FolderModel folder) {
    return DropdownMenuItem<String>(
      value: folder.id.toString(),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(folder.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FolderProvider>(
      builder: (context, provider, child) {
        return DropdownButton<String>(
          hint: const Text("Select folder"),
          value: provider.selectedFolder.toString(),
          onChanged: (String? v) {
            provider.setSelectedItem(int.parse(v!));
          },
          items: provider.folders.map((map) => getDropdownWidget(map)).toList(),
          isExpanded: true,
          itemHeight: null,
        );
      },
    );
  }
}
