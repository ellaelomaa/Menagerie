// ignore_for_file: avoid_print

import 'dart:async';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/database/models/parent_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lists/consts/db_consts.dart' as consts;

class DatabaseHelper {
  // TABLE CONSTANTS
  static const itemTable = "items";
  static const folderTable = "folders";
  static const parentTable = "parents";

  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseHelper;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, "men.dart");

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute("PRAGMA foreign_keys = ON"),
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS folders (
        id INTEGER PRIMARY KEY,
        title TEXT UNIQUE,
        added TEXT NOT NULL,
        modified TEXT
      )
    """);
    print("created $folderTable");
    await db.execute("""
      CREATE TABLE IF NOT EXISTS parents (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        added TEXT NOT NULL,
        modified TEXT,
        type TEXT NOT NULL,
        folderId INTEGER DEFAULT 1,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET DEFAULT
        )
      """);
    print("created $parentTable");
    await db.execute("""
      CREATE TABLE IF NOT EXISTS items (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        added TEXT NOT NULL,
        modified TEXT,
        type TEXT NOT NULL,
        folderId INTEGER NOT NULL DEFAULT 1,
        content TEXT,
        pinned INTEGER NOT NULL DEFAULT 0,
        checked INTEGER DEFAULT 0,
        parentId INTEGER,
        judgement INTEGER,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET DEFAULT,
        FOREIGN KEY (parentId) REFERENCES parents(id) ON DELETE CASCADE
      )
    """);

    print("created $itemTable");
    await _createDefaultFolders(db);
  }

  Future<void> _createDefaultFolders(Database db) async {
    // print("creating default folders");
    await db.insert(
      "folders",
      FolderModel(title: "Miscellaneous", added: DateTime.now().toString())
          .toMap(),
    );
  }

  /*
  CREATE ITEM
  */

  Future<void> addFolder(FolderModel folder) async {
    final db = await _databaseHelper.database;
    await db.insert(folderTable, folder.toMap());
  }

  Future<void> addParent(ParentModel parent) async {
    final db = await _databaseHelper.database;
    await db.insert(parentTable, parent.toMap());
  }

  Future<void> addItem(ItemModel item) async {
    final db = await _databaseHelper.database;
    await db.insert(itemTable, item.toMap());
  }

  /*
  UPDATE
  */

  Future<void> updateFolder(FolderModel folder) async {
    final db = await _databaseHelper.database;
    await db.update(folderTable, folder.toMap(),
        where: "id = ?", whereArgs: [folder.id]);
  }

  Future<void> updateParent(ParentModel parent) async {
    final db = await _databaseHelper.database;
    await db.update(parentTable, parent.toMap(),
        where: "id = ?", whereArgs: [parent.id]);
  }

  Future<void> updateItem(ItemModel item) async {
    final db = await _databaseHelper.database;
    await db
        .update(itemTable, item.toMap(), where: "id = ?", whereArgs: [item.id]);
  }

  Future<void> pinItem(ItemModel item) async {
    final db = await _databaseHelper.database;
    late int pinned;
    if (item.pinned == 1) {
      pinned = 0;
    } else {
      pinned = 1;
    }
    await db.update(itemTable, {"pinned": pinned},
        where: "id = ?", whereArgs: [item.id]);
    print(item.pinned);
  }

  /*
  GETTERS
  */

  Future<List<FolderModel>> getFolders() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> folders = await db.query(folderTable);
    return List.generate(
      folders.length,
      (index) => FolderModel.fromMap(
        folders[index],
      ),
    );
  }

  Future<List<ParentModel>> getParents(String type) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> parents = await db.query(
      parentTable,
      where: "type = ?",
      whereArgs: [type],
    );
    return List.generate(
      parents.length,
      (index) => ParentModel.fromMap(
        parents[index],
      ),
    );
  }

  Future<List<ItemModel>> getItems(
      String table, String sort, String order) async {
    final db = await _databaseHelper.database;
    String sortBy = "";
    if (sort == consts.ABC_SORT) {
      sortBy = "title";
    }
    if (sort == consts.ADDED_SORT) {
      sortBy = "added";
    } else if (sort == consts.MODIFIED_SORT) {
      sortBy = "modified";
    }
    List<Map<String, dynamic>> items = await db.rawQuery("""
      SELECT *
      FROM $itemTable
      WHERE type = "note"
      ORDER BY pinned DESC, $sortBy $order
""");
    List<ItemModel> itemList = items.isNotEmpty
        ? items.map((item) => ItemModel.fromMap(item)).toList()
        : [];
    return itemList;
  }

  Future<FolderModel> getFolderById(int id) async {
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> results =
        await db.query(folderTable, where: "id = ?", whereArgs: [id]);
    return FolderModel.fromMap(results[0]);
  }

  Future<ParentModel> getParentById(int id) async {
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> results =
        await db.query(parentTable, where: "id = ?", whereArgs: [id]);
    return ParentModel.fromMap(results[0]);
  }

  Future<ItemModel> getItemById(int id) async {
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> results =
        await db.query(itemTable, where: "id = ?", whereArgs: [id]);
    return ItemModel.fromMap(results[0]);
  }

  Future<List<ItemModel>> getPinned(String type) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> items = await db.rawQuery("""
      SELECT *
      FROM $itemTable
      WHERE type = "note" AND pinned = 1
      ORDER BY pinned, added
""");
    List<ItemModel> itemList =
        items.isNotEmpty ? items.map((e) => ItemModel.fromMap(e)).toList() : [];
    return itemList;
  }

  // DELETE

  Future<void> deleteFolder(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(folderTable, where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteParent(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(parentTable, where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteItem(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(itemTable, where: "id = ?", whereArgs: [id]);
  }

  // DROP ALL TABLES
  Future<void> deleteDB() async {
    var dbpath = await getDatabasesPath();
    final path = join(dbpath, "men.dart");
    databaseFactory.deleteDatabase(path);
  }
}
