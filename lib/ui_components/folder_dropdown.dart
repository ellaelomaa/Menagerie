// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:provider/provider.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({super.key});

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
        return Stack(
          children: [
            Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Center(
                    child: Text(
                      "Folder",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  value: provider.selectedFolder.toString(),
                  onChanged: (String? v) {
                    provider.setSelectedItem(int.parse(v!));
                  },
                  items: provider.folders
                      .map(
                        (folder) => DropdownMenuItem(
                          value: folder.id.toString(),
                          child: Text(
                            folder.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: 160,
                    padding: const EdgeInsets.only(left: 14),
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: null,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: WidgetStateProperty.all<double>(6),
                      thumbVisibility: WidgetStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
            Column(
              children: const [
                SizedBox(
                  height: 30,
                ),
                Image(
                  image: AssetImage("assets/icons/bottom_line.png"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

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
          isExpanded: true,
          itemHeight: null,
          hint: const Text("Select folder"),
          icon: const Icon(Icons.arrow_drop_down),
          value: provider.selectedFolder.toString(),
          onChanged: (String? v) {
            provider.setSelectedItem(int.parse(v!));
          },
          items: provider.folders.map((map) => getDropdownWidget(map)).toList(),
        );
      },
    );
  }
}
