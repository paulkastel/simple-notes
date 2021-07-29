import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_notes/dao/dao_base.dart';
import 'package:simple_notes/dao/dao_notes.dart';
import 'package:simple_notes/models/note.dart';
import 'package:simple_notes/utils/database.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

void main() {
  group('DaoNotes', () {
    late DaoNotes testedDao;
    final mockDb = MockAppDatabase();

    setUpAll(() {
      testedDao = DaoNotes(mockDb);
    });

    test('DaoNotes implements IDaoBase', () {
      expect(testedDao, isA<IDaoBase<Note>>());
    });
  });
}
