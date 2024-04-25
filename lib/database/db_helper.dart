import 'package:flutter/material.dart';
import 'package:lists/database/models/folder_model.dart';
import 'package:lists/database/models/list_model.dart';
import 'package:lists/database/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, "folders.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE folders(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        added TEXT NOT NULL,
        modified TEXT,

      )
    """);
    await db.execute("""
      CREATE TABLE lists(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        added TEXT NOT NULL,
        modified TEXT,
        folderId INTEGER DEFAULT 1,
        FOREIGN KEY (folderId) REFERENCES folders(id)
        ON DELETE SET DEFAULT
      )
""");
    await db.execute("""
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        added TEXT NOT NULL,
        modified TEXT,
        folderId INTEGER DEFAULT 1,
        FOREIGN KEY (folderId) REFERENCES folders(id)
        ON DELETE SET DEFAULT
      )
""");
    await _createDefaultFolders(db);
  }

  Future<void> _createDefaultFolders(Database database) async {
    await database.insert(
      "folders",
      Folder(
        name: "Miscellaneous notes",
        added: DateTime.now().toString(),
      ).toMap(), // FolderId 1
    );
  }

  Future _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  /*
  SETTERS
  */

  Future<int> addFolder(Folder folder) async {
    Database db = await instance.database;
    return await db.insert("folders", folder.toMap());
  }

  Future<int> addList(ListModel list) async {
    Database db = await instance.database;
    return await db.insert("lists", list.toMap());
  }

  Future<int> addNote(NoteModel note) async {
    Database db = await instance.database;
    return await db.insert("notes", note.toMap());
  }

  /*
  GETTERS
  */

  Future<List<Folder>> getFolders() async {
    Database db = await instance.database;
    var folders = await db.rawQuery("""
      SELECT *
      FROM folders
      ORDER BY name
""");
    List<Folder> folderList = folders.isNotEmpty
        ? folders.map((c) => Folder.fromMap(c)).toList()
        : [];
    return folderList;
  }

  Future<List<ListModel>> getLists(int type) async {
    Database db = await instance.database;
    var lists = await db.rawQuery(
      """
      SELECT * 
      FROM lists 
      WHERE folderId = ? 
      ORDER BY name
      """,
      [type],
    );
    List<ListModel> listList =
        lists.isNotEmpty ? lists.map((c) => ListModel.fromMap(c)).toList() : [];
    return listList;
  }

  Future<List<NoteModel>> getNotes() async {
    Database db = await instance.database;
    var notes = await db.rawQuery("""
      SELECT *
      FROM notes
      ORDER BY name
      """);
    List<NoteModel> noteList =
        notes.isNotEmpty ? notes.map((c) => NoteModel.fromMap(c)).toList() : [];
    return noteList;
  }

  /*
  DELETE.
  DO NOT DELETE DEFAULT FOLDERS. 
  */

  Future<int> removeFolder(int id) async {
    Database db = await instance.database;
    if (id != 1) {
      return await db.delete("folders", where: "id = ?", whereArgs: [id]);
    } else {
      debugPrint("Cannot delete default folder ");
      return 0;
    }
  }

  Future<int> removeList(int id) async {
    Database db = await instance.database;
    return await db.delete("lists", where: "id = ?", whereArgs: [id]);
  }

  Future<int> removeNote(int id) async {
    Database db = await instance.database;
    return await db.delete("notes", where: "id = ?", whereArgs: [id]);
  }

  Future<int> removeItem(String table, int id) async {
    Database db = await instance.database;
    if (table == "folders" && id == 1) {
      return 0;
    }
    return await db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  /*
  UPDATE
  */

  Future<int> updateFolder(Folder folder) async {
    Database db = await instance.database;
    return await db.update("folders", folder.toMap(),
        where: "id = ?", whereArgs: [folder.id]);
  }

  Future<int> updateList(ListModel list) async {
    Database db = await instance.database;
    return await db.rawUpdate("""
        UPDATE lists 
        SET name = ? 
        WHERE id = ?
        """, [list.name, list.id]);
  }
}
