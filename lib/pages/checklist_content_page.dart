// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:lists/ui_components/app_bar.dart';
import 'package:lists/ui_components/checklist_item_card.dart';
import 'package:provider/provider.dart';

class ChecklistContent extends StatelessWidget {
  final int parentId;
  final String listName;
  const ChecklistContent(
      {super.key, required this.parentId, required this.listName});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);
    itemProvider.setParent(parentId, "checklist");

    void editNote(BuildContext context, ItemModel item) {
      titleController.text = item.title;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit item"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await itemProvider.editItem(
                          ItemModel(
                              id: item.id,
                              title: titleController.text,
                              added: item.added,
                              modified: DateTime.now().toString(),
                              type: "checklist",
                              checked: item.checked,
                              parentId: item.parentId),
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    void deleteNote(BuildContext context, ItemModel item) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to delete the note? This cannot be undone."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  itemProvider.deleteItem(item);
                  Navigator.pop(context);
                },
                child: Text("Delete"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: CustomAppBar(listName),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add new item"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (titleController.text.isNotEmpty) {
                              await itemProvider.addItem(
                                ItemModel(
                                    title: titleController.text,
                                    added: DateTime.now().toString(),
                                    type: "checklist",
                                    checked: 0,
                                    parentId: parentId),
                              );
                            }

                            Navigator.pop(context);
                          },
                          child: Text("Save"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, provider, child) {
          var items = provider.checklistItems;

          if (items.isEmpty) {
            return Center(
              child: Text("No items yet. Go ahead, create one!"),
            );
          } else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index];
                      //return ChecklistItemCard(item: item, parentId: parentId);
                      return Card(
                        child: ListTile(
                          onTap: () {
                            provider.markAsChecked(item);
                          },
                          leading: item.checked == 0
                              ? Icon(Icons.check_box_outline_blank_rounded)
                              : Icon(Icons.check_box_outlined),
                          title: Text(item.title),
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
                            offset: Offset(30, -10),
                            onSelected: (value) {
                              if (value == 1) {
                                editNote(context, item);
                              }
                              if (value == 2) {
                                deleteNote(context, item);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
