import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_notes/cubits/add_note/add_note_cubit.dart';
import 'package:simple_notes/dao/dao_notes.dart';
import 'package:simple_notes/models/note.dart';

class MockDaoNotes extends Mock implements DaoNotes {}

class FakeNote extends Fake implements Note {}

void main() {
  late AddNoteCubit testedCubit;
  late MockDaoNotes mockDao;

  group('AddNoteCubit', () {
    setUp(() {
      mockDao = MockDaoNotes();
      testedCubit = AddNoteCubit(mockDao);
    });

    setUpAll(() {
      registerFallbackValue(FakeNote());
    });

    tearDown(() {
      testedCubit.close();
    });

    test('WHEN created THEN cubit emit initial state and none interaction with db', () {
      expect(testedCubit.state, isA<AddNoteInitial>());
      verifyZeroInteractions(mockDao);
    });

    blocTest<AddNoteCubit, AddNoteState>(
      'WHEN note is saved THEN state is success',
      build: () {
        when(() => mockDao.create(any())).thenAnswer((_) async => 0);
        return testedCubit;
      },
      act: (cubit) => cubit.saveNote('anyContent'),
      expect: () => [AddNoteLoading(), AddNoteSuccess()],
    );

    blocTest<AddNoteCubit, AddNoteState>(
      'WHEN note is saved THEN state is error',
      build: () {
        when(() => mockDao.create(any())).thenThrow((_) => Exception('error'));
        return testedCubit;
      },
      act: (cubit) => cubit.saveNote('anyContent'),
      expect: () => [AddNoteLoading(), AddNoteError(Exception('error'))],
    );
  });
}
