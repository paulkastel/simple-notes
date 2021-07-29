import '../models/note.dart';
import '../utils/database.dart';
import 'dao_base.dart';

class DaoNotes implements IDaoBase<Note> {
  DaoNotes(this._appDb);

  final AppDatabase _appDb;

  @override
  Future<int> create(Note entity) async {
    return 0;
  }

  @override
  Future<int> delete(String id) async {
    return 0;
  }

  @override
  Future<Note?> read(String id) async {
    return null;
  }

  @override
  Future<int> update(Note entity) async {
    return 0;
  }

  Future<List<Note>> getAllNotes() async {
    return [];
  }
}
