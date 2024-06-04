// Works as an intermediary between the user interface and the database.

import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/item_model.dart';

class ItemProvider extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  int _parentId = 1;
  int get parentId => _parentId;

  List<ItemModel> _notes = [];
  List<ItemModel> get notes => _notes;

  List<ItemModel> _checklistItems = [];
  List<ItemModel> get checklistItems => _checklistItems;

  List<ItemModel> _tarotCards = [];
  List<ItemModel> get tarotCards => _tarotCards;

  String _selectedSort = "Alphabetically";
  String _order = "ASC";
  String get selectedSort => _selectedSort;
  String get order => _order;

  ItemProvider() {
    _databaseHelper = DatabaseHelper();
  }

  // GETTERS

  Future<void> _getAllNotes() async {
    _notes = await _databaseHelper.getItems("note", _selectedSort, _order);
    notifyListeners();
  }

  Future<void> _getChecklistItems(int parentId) async {
    _checklistItems = await _databaseHelper.getChecklistItems(parentId);
    notifyListeners();
  }

  Future<void> _getTarotCards(int parentId) async {
    _tarotCards = await _databaseHelper.getChildren(parentId);
    notifyListeners();
  }

  // SETTERS

  Future<void> addItem(ItemModel item) async {
    await _databaseHelper.addItem(item);
    if (item.type == "note") {
      _getAllNotes();
    }
    if (item.type == "checklist") {
      _getChecklistItems(item.parentId!);
    }
    if (item.type == "tarot") {
      _getTarotCards(item.parentId!);
    }
  }

  Future<void> editItem(ItemModel item) async {
    await _databaseHelper.updateItem(item);
    if (item.type == "note") {
      _getAllNotes();
    }
    if (item.type == "checklist") {
      _getChecklistItems(item.parentId!);
    }
    if (item.type == "tarot") {
      _getTarotCards(item.parentId!);
    }
  }

  Future<void> markAsPinned(ItemModel item) async {
    await _databaseHelper.pinItem(item);
    _getAllNotes();
  }

  Future<void> markAsChecked(ItemModel item) async {
    await _databaseHelper.checkItem(item);
    _getChecklistItems(parentId);
  }

  changeSort(String method) {
    _selectedSort = method;
    _getAllNotes();
  }

  changeOrder(String order) {
    _order = order;
    _getAllNotes();
  }

  setParent(int id, String type) async {
    _parentId = id;
    if (type == "checklist") {
      _getChecklistItems(id);
    }
    if (type == "tarot") {
      _getTarotCards(id);
    }
  }

  Future deleteItem(ItemModel item) async {
    _notes.removeWhere((element) => element.id == item.id!);
    await _databaseHelper.deleteItem(item.id!);
    if (item.type == "note") {
      _getAllNotes();
    }
    if (item.type == "checklist") {
      _getChecklistItems(item.parentId!);
    }
    if (item.type == "tarot") {
      _getTarotCards(item.parentId!);
    }
  }

  Future deleteAllNotes() async {
    _notes = [];
    await _databaseHelper.deleteAllNotes();
    _getAllNotes();
  }
}
