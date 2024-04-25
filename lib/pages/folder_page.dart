// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/assets/ui_components/app_bar.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/folder_model.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  final _folderNameController = TextEditingController();
  late List<DropdownMenuItem<String>> list;

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
                setState(() {
                  _folderNameController.clear();
                  updateDropdownmenu();
                });
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
    super.initState();
    updateDropdownmenu();
  }

  updateDropdownmenu() {
    list = [];
    DatabaseHelper.instance.getFolders().then(
      (value) {
        value.map((map) {
          return getDropdownWidget(map);
        }).forEach(
          (element) {
            list.add(element);
          },
        );
        setState(() {});
      },
    );
  }

  // DropdownMenuItem<String> getDropdownWidget(Folder folder) {
  //   return DropdownMenuItem<String>(
  //     value: folder.name,
  //     child: Text(folder.name),
  //   );
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
      appBar: CustomAppBar("Folders"),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showFormDialog(context);
          setState(
            () {
              _folderNameController.clear();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<List<Folder>>(
                  future: DatabaseHelper.instance.getFolders(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Folder>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("Loading"),
                      );
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text("No folders yet"),
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.map((folder) {
                              return Center(
                                child: ListTile(
                                  title: Text(folder.name),
                                  subtitle: Text(folder.id.toString()),
                                  // onLongPress: () {
                                  //   setState(() {
                                  //     DatabaseHelper.instance
                                  //         .removeFolder(folder.id!);
                                  //   });
                                  // },
                                  onLongPress: () {
                                    setState(() {
                                      DatabaseHelper.instance
                                          .removeItem("folders", folder.id!);
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          );
                  },
                ),
                DropdownButtonFormField<String>(
                    hint: Text("Folders"), onChanged: (value) {}, items: list),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
