import 'package:flutter/material.dart';
import 'package:lists/vanhat/database/models/folder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final DatabasePath = await getDatabasesPath();
    final path = join(DatabasePath, 'lists.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 3,
      onUpgrade: _upgradeDatabase,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE folders(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        added TEXT NOT NULL
      )
""");
  }

  /*
  SETTERS
  */

  Future<void> insertFolder(FolderVanha folder) async {
    final db = await _databaseService.database;

    await db.insert('folders', folder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /*
  GETTERS. First a database reference is retrieved,
  then the necessary tables are queried, and the result is
  converted into a List<entity>.
  */

  Future<List<FolderVanha>> folders() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> folders = await db.query("folders");
    return List.generate(
      folders.length,
      (index) => FolderVanha.fromMap(folders[index]),
    );
  }

  /* 
  MODIFY OR DELETE DATABASE
  */

  void _upgradeDatabase(Database database, int oldVersion, int newVersion) {
    debugPrint('Database Version onUpgrade: OLD: $oldVersion NEW: $newVersion');
  }
}
