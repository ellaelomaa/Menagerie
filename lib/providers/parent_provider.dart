import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/parent_model.dart';

class ParentProvider extends ChangeNotifier {
  List<ParentModel> _checklists = [];
  late DatabaseHelper _databaseHelper;

  List<ParentModel> get checklists => _checklists;

  ParentProvider() {
    _databaseHelper = DatabaseHelper();
  }

  Future<void> _getAllChecklists() async {
    _checklists = await _databaseHelper.getParents("checklist");
    notifyListeners();
  }

  // SETTERS

  Future<void> addItem(ParentModel parent) async {
    await _databaseHelper.addParent(parent);
    if (parent.type == "checklist") {
      _getAllChecklists();
    }
  }

  Future<void> editParent(ParentModel parent) async {
    await _databaseHelper.updateParent(parent);
    if (parent.type == "checklist") {
      _getAllChecklists();
    }
  }

  Future deleteParent(int id) async {
    _checklists.removeWhere((element) => element.id == id);
    await _databaseHelper.deleteParent(id);
    _getAllChecklists();
  }
}
