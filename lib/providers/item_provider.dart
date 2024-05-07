// Works as an intermediary between the user interface and the database.

import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/item_model.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemModel> _notes = [];
  List<ItemModel> _pinnedNotes = [];
  late DatabaseHelper _databaseHelper;

  List<ItemModel> get notes => _notes;
  List<ItemModel> get pinnedNotes => _pinnedNotes;

  ItemProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllNotes();
  }

  // GETTERS

  Future<void> _getAllNotes() async {
    _notes = await _databaseHelper.getItems("note");
    notifyListeners();
  }

  Future<void> getPinned(String type) async {
    _pinnedNotes = await _databaseHelper.getPinned("note");
    notifyListeners();
  }

  // SETTERS

  Future<void> addItem(ItemModel item) async {
    await _databaseHelper.addItem(item);
    if (item.type == "note") {
      _getAllNotes();
    }
  }

  Future<void> markAsPinned(ItemModel item) async {
    await _databaseHelper.pinItem(item);
    _getAllNotes();
  }

  Future deleteItem(int id) async {
    _notes.removeWhere((element) => element.id == id);
    await _databaseHelper.deleteItem(id);
    _getAllNotes();
  }
}
