// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lists/assets/ui_components/app_bar.dart';
import 'package:lists/assets/ui_components/fab.dart';
import 'package:lists/assets/ui_components/folder_dropdown.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/database/models/list_model.dart';
import 'package:lists/forms/new_folder_form.dart';
import 'package:lists/forms/new_note_form.dart';
import 'package:path/path.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _folderNameController = TextEditingController();
  late List<DropdownMenuItem<String>> list;
  int? currentFolderId = 1;

  void updatePage() {
    setState(() {});
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                DatabaseHelper.instance.addFolder(
                  Folder(
                    name: _folderNameController.text,
                    added: DateTime.now().toString(),
                  ),
                );
                setState(
                  () {
                    _folderNameController.clear();
                    FoldersDropdown(onClicked: (id) {});
                  },
                );
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
          title: Text("Add a new folder"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _folderNameController,
                  decoration: InputDecoration(
                      hintText: "Write folder name", labelText: "Folder"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    NewFolderForm().updateDropdownmenu();
    super.initState();
  }

  // updateDropdownmenu() {
  //   list = [];
  //   DatabaseHelper.instance.getFolders().then(
  //     (value) {
  //       value.map((map) {
  //         return getDropdownWidget(map);
  //       }).forEach(
  //         (element) {
  //           list.add(element);
  //         },
  //       );
  //     },
  //   );
  //   setState(() {});
  // }

  DropdownMenuItem<String> getDropdownWidget(Folder folder) {
    return DropdownMenuItem<String>(
      value: folder.id.toString(),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(folder.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Notes"),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 6,
        spaceBetweenChildren: 6,
        children: [
          SpeedDialChild(
            child: Icon(Icons.folder),
            label: "New folder",
          ),
          SpeedDialChild(
            child: Icon(Icons.note),
            label: "New note",
            onTap: () {
              // await _showFormDialog(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const NewNoteForm(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: FoldersDropdown(
                onClicked: (id) {
                  currentFolderId = id;
                  debugPrint("Notes");
                  debugPrint(
                    currentFolderId.toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
