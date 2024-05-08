// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lists/assets/ui_components/folder_dropdown.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({Key? key, this.item}) : super(key: key);
  final ItemModel? item;

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  // CONTROLLERS
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  bool editable = false;

  // DATA DO BE SAVED
  final title = "";
  final content = "";
  final cardColor = Color.fromARGB(255, 240, 232, 219);

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _titleController.text = widget.item!.title;
      _contentController.text = widget.item!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final folderProvider = Provider.of<FolderProvider>(context, listen: false);
    final noteProvider = Provider.of<ItemProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: cardColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        leading: IconButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              if (widget.item != null) {
                noteProvider.editItem(
                  ItemModel(
                      id: widget.item?.id,
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                      added: widget.item!.added,
                      modified: DateTime.now().toString(),
                      pinned: widget.item!.pinned,
                      type: "note",
                      folderId: folderProvider.selectedFolder),
                );
              } else {
                noteProvider.addItem(
                  ItemModel(
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                      added: DateTime.now().toString(),
                      type: "note",
                      pinned: 0,
                      folderId: folderProvider.selectedFolder),
                );
              }

              Navigator.pop(context);
            }
            if (_titleController.text.isEmpty &&
                _contentController.text.isEmpty) {
              Navigator.pop(context);
            } else {
              const snackBar = SnackBar(
                content: Text("Please enter a title"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tell your story"),
            IconButton(
              onPressed: () {
                editable = !editable;
                setState(() {});
              },
              icon:
                  !editable == true ? Icon(Icons.edit) : Icon(Icons.visibility),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _titleController,
                  readOnly: !editable,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                Column(
                  children: const [
                    SizedBox(
                      height: 15,
                    ),
                    Image(
                      image: AssetImage("lib/assets/icons/bottom_line.png"),
                    ),
                  ],
                ),
              ],
            ),
            CustomDropdown(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: cardColor,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Transform.flip(
                      flipX: true,
                      flipY: true,
                      child: Image(
                        image: AssetImage("lib/assets/icons/corner.png"),
                        width: 65,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Transform.flip(
                      flipY: true,
                      child: Image(
                        image: AssetImage("lib/assets/icons/corner.png"),
                        width: 65,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Transform.flip(
                      flipX: true,
                      child: Image(
                        image: AssetImage("lib/assets/icons/corner.png"),
                        width: 65,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image(
                      image: AssetImage("lib/assets/icons/corner.png"),
                      width: 65,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: TextField(
                        readOnly: !editable,
                        controller: _contentController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(20),
                            // ),
                            hintText: "Start typing!",
                            hintStyle: TextStyle(color: Colors.grey)),
                        minLines: 1,
                        maxLines: null,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
