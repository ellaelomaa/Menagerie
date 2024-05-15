// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lists/ui_components/app_bar.dart';
import 'package:lists/ui_components/drawer.dart';
import 'package:lists/ui_components/fab.dart';
import 'package:lists/providers/item_provider.dart';
import 'package:lists/ui_components/note_card.dart';
import 'package:provider/provider.dart';
import 'package:lists/consts/db_consts.dart' as consts;

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sortingMethods = [
      consts.ADDED_SORT,
      consts.ABC_SORT,
      consts.MODIFIED_SORT
    ];
    final List<String> orders = ["ASC", "DESC"];

    return Scaffold(
      appBar: CustomAppBar("Notes"),
      drawer: const DrawerNav(),
      floatingActionButton: FAB(),
      body: Consumer<ItemProvider>(
        builder: (context, provider, child) {
          var notes = provider.notes;
          if (notes.isEmpty) {
            return Center(
              child: Text("No notes yet. Go ahead, create one!"),
            );
          } else {
            return Column(
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text("Sort"),
                    items: sortingMethods
                        .map((String method) => DropdownMenuItem<String>(
                              value: method,
                              child: Text(
                                method,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      print("CHANGE SORT");
                      print(value);
                      provider.changeSort(value!);
                    },
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text("Order"),
                    items: orders
                        .map((String method) => DropdownMenuItem<String>(
                              value: method,
                              child: Text(
                                method,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      print("CHANGE ORDER");
                      print(value);
                      provider.changeOrder(value!);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      var note = notes[index];
                      return NoteCard(note: note);
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
