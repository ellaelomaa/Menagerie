import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/parent_model.dart';

class ParentProvider extends ChangeNotifier {
  List<ParentModel> _checklists = [];
  List<ParentModel> _tarotHands = [];
  late DatabaseHelper _databaseHelper;

  List<ParentModel> get checklists => _checklists;
  List<ParentModel> get tarotHands => _tarotHands;

  ParentProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllChecklists();
    _getAllHands();
  }

  Future<void> _getAllChecklists() async {
    _checklists = await _databaseHelper.getParents("checklist");
    notifyListeners();
  }

  Future<void> _getAllHands() async {
    _tarotHands = await _databaseHelper.getParents("tarot");
    notifyListeners();
  }

  // SETTERS

  Future<void> addItem(ParentModel parent) async {
    await _databaseHelper.addParent(parent);
    if (parent.type == "checklist") {
      _getAllChecklists();
    }
    if (parent.type == "tarot") {
      _getAllHands();
    }
  }

  Future<void> editParent(ParentModel parent) async {
    await _databaseHelper.updateParent(parent);
    if (parent.type == "checklist") {
      _getAllChecklists();
    }
    if (parent.type == "tarot") {
      _getAllHands();
    }
  }

  Future deleteParent(int id) async {
    _checklists.removeWhere((element) => element.id == id);
    await _databaseHelper.deleteParent(id);
    _getAllChecklists();
    _getAllHands();
  }
}
