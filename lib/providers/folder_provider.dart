import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/folder_model.dart';

class FolderProvider extends ChangeNotifier {
  List<FolderModel> _folders = [];
  late DatabaseHelper _databaseHelper;

  List<FolderModel> get folders => _folders;

  FolderProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllFolders();
  }

  Future<void> _getAllFolders() async {
    _folders = await _databaseHelper.getFolders();
    notifyListeners();
  }

  int _selectedFolder = 1;
  int get selectedFolder => _selectedFolder;

  Future<void> addFolder(FolderModel folder) async {
    await _databaseHelper.addFolder(folder);
    _getAllFolders();
  }

  setSelectedItem(int id) {
    _selectedFolder = id;
    notifyListeners();
  }

  Future deleteFolder(int id) async {
    if (id == 1) {
      print("Can't delete default folders!");
    } else {
      _folders.removeWhere((element) => element.id == id);
      await _databaseHelper.deleteFolder(id);
      _getAllFolders();
    }
  }
}
