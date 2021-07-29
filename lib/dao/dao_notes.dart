import 'package:sqflite/sqflite.dart';

import '../models/note.dart';
import '../utils/database.dart';
import 'dao_base.dart';

class DaoNotes implements IDaoBase<Note> {
  DaoNotes(this._appDb);

  final AppDatabase _appDb;
  final String _tableName = 'Notes';

  @override
  Future<int> create(Note entity) async {
    final db = await _appDb.db;
    return db.insert(_tableName, entity.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> delete(int id) async {
    final db = await _appDb.db;
    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Note?> read(int id) async {
    final db = await _appDb.db;
    final res = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Note.fromJson(res.first) : null;
  }

  @override
  Future<int> update(Note entity) async {
    final db = await _appDb.db;
    return db.update(_tableName, entity.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Note>> getAllNotes() async {
    final db = await _appDb.db;
    final result = await db.query(_tableName);
    return Note.listFromJson(result);
  }
}
