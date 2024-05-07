// Works as an intermediary between the user interface and the database.

import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/item_model.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemModel> _notes = [];
  String _selectedSort = "Alphabetically";
  String _order = "ASC";
  late DatabaseHelper _databaseHelper;

  List<ItemModel> get notes => _notes;
  String get selectedSort => _selectedSort;
  String get order => _order;

  ItemProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllNotes();
  }

  // GETTERS

  Future<void> _getAllNotes() async {
    _notes = await _databaseHelper.getItems("note", _selectedSort, _order);
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

  changeSort(String method) {
    _selectedSort = method;
    _getAllNotes();
  }

  changeOrder(String order) {
    _order = order;
    _getAllNotes();
  }

  Future deleteItem(int id) async {
    _notes.removeWhere((element) => element.id == id);
    await _databaseHelper.deleteItem(id);
    _getAllNotes();
  }
}
