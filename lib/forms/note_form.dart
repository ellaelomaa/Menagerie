// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lists/ui_components/folder_dropdown.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/providers/folder_provider.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:provider/provider.dart';
import 'package:lists/consts/color_consts.dart' as color_consts;

class NoteForm extends StatefulWidget {
  const NoteForm({Key? key, this.item, required this.newItem})
      : super(key: key);
  final ItemModel? item;
  final bool newItem;

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  // CONTROLLERS
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  late bool editable; // Controls readOnly-value with TextFields.

  // DATA TO BE SAVED
  final title = "";
  final content = "";
  final cardColor = Color.fromARGB(255, 240, 232, 219);

  @override
  void initState() {
    super.initState();
    editable = widget.newItem;
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
      backgroundColor: color_consts.cardColor,
      appBar: AppBar(
        backgroundColor: color_consts.cardColor,
        leading: IconButton(
          onPressed: () {
            // If the item is being edited or not
            if (widget.item != null) {
              // Item is edited
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
              // New item
              if (_titleController.text.isNotEmpty &&
                  _contentController.text.isNotEmpty) {
                // All fields filled
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
              if (_titleController.text.isEmpty &&
                  _contentController.text.isNotEmpty) {
                final f = DateFormat("dd.M.yyyy");
                // Title missing
                noteProvider.addItem(
                  ItemModel(
                      title: f.format(DateTime.now()),
                      content: _contentController.text.trim(),
                      added: DateTime.now().toString(),
                      type: "note",
                      pinned: 0,
                      folderId: folderProvider.selectedFolder),
                );
              }
              if (_titleController.text.isNotEmpty &&
                  _contentController.text.isEmpty) {
                noteProvider.addItem(
                  ItemModel(
                      title: _titleController.text,
                      content: "",
                      added: DateTime.now().toString(),
                      type: "note",
                      pinned: 0,
                      folderId: folderProvider.selectedFolder),
                );
              }
            }
            Navigator.pop(context);
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
                      image: AssetImage("assets/icons/bottom_line.png"),
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
                        image: AssetImage("assets/icons/corner.png"),
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
                        image: AssetImage("assets/icons/corner.png"),
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
                        image: AssetImage("assets/icons/corner.png"),
                        width: 65,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image(
                      image: AssetImage("assets/icons/corner.png"),
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
