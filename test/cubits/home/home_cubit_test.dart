import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_notes/cubits/home/home_cubit.dart';
import 'package:simple_notes/dao/dao_notes.dart';
import 'package:simple_notes/models/note.dart';

class MockDaoNotes extends Mock implements DaoNotes {}

class FakeNote extends Fake implements Note {}

void main() {
  late HomeCubit testedCubit;
  late MockDaoNotes mockDao;

  group('HomeCubit', () {
    setUp(() {
      mockDao = MockDaoNotes();
      testedCubit = HomeCubit(mockDao);
    });

    setUpAll(() {
      registerFallbackValue(FakeNote());
    });

    tearDown(() {
      testedCubit.close();
    });

    test('WHEN created THEN cubit emit initial state and none interaction with db', () {
      expect(testedCubit.state, isA<HomeInitial>());
      verifyZeroInteractions(mockDao);
    });

    blocTest<HomeCubit, HomeState>(
      'WHEN read notes THEN state is success',
      build: () {
        when(() => mockDao.getAllNotes()).thenAnswer((_) async => []);
        return testedCubit;
      },
      act: (cubit) => cubit.getNotes(),
      expect: () => [HomeLoading(), const HomeSuccess([])],
    );

    blocTest<HomeCubit, HomeState>(
      'WHEN read notes throw exception THEN state is error',
      build: () {
        when(() => mockDao.getAllNotes()).thenThrow((_) => Exception('error'));
        return testedCubit;
      },
      act: (cubit) => cubit.getNotes(),
      expect: () => [HomeLoading(), HomeError(Exception('error'))],
    );
  });
}
