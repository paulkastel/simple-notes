import 'dart:developer';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static Database? _database;

  final _tag = '$AppDatabase';

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    } else {
      log('Database is being initialized!', name: _tag);
      return _database = await _initDb();
    }
  }

  Future<Database> _initDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final path = join(docsPath.path, 'simplenotesdb.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    log('Database init started!', name: _tag);
    await db.execute(
      'CREATE TABLE IF NOT EXISTS Notes (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, content TEXT NOT NULL, creationdate INTEGER NOT NULL)',
    );
    log('Database init finished!', name: _tag);
  }
}
