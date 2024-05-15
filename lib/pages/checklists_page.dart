// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/database/models/parent_model.dart';
import 'package:lists/pages/checklist_content_page.dart';
import 'package:lists/providers/parent_provider.dart';
import 'package:lists/ui_components/app_bar.dart';
import 'package:lists/ui_components/drawer.dart';
import 'package:lists/ui_components/list_card.dart';
import 'package:provider/provider.dart';

class ChecklistsPage extends StatelessWidget {
  const ChecklistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listNameController = TextEditingController();
    final parentProvider = Provider.of<ParentProvider>(context, listen: false);

    return Scaffold(
        appBar: CustomAppBar("Checklists"),
        drawer: const DrawerNav(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Create a new list"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: listNameController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await parentProvider.addItem(
                            ParentModel(
                                title: listNameController.text,
                                added: DateTime.now().toString(),
                                type: "checklist",
                                folderId: 1),
                          );
                          listNameController.clear();
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<ParentProvider>(
          builder: (context, provider, child) {
            var parents = provider.checklists;
            if (parents.isEmpty) {
              return Center(
                child: Text("No lists yet. Go ahead, create one!"),
              );
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: parents.length,
                      itemBuilder: (context, index) {
                        var parent = parents[index];
                        return GestureDetector(
                          child: ListCard(parent: parent),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChecklistContent(
                                  parentId: parent.id!,
                                  listName: parent.title,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
