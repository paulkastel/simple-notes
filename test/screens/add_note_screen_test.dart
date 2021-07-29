import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_notes/cubits/add_note/add_note_cubit.dart';
import 'package:simple_notes/screens/add_note_screen.dart';

class MockAddNoteCubit extends MockCubit<AddNoteState> implements AddNoteCubit {}

class FakeAddNoteState extends Fake implements AddNoteState {}

void main() {
  late AddNoteCubit testedCubitMock;

  late Widget testedWidget;

  tearDown(() {
    testedCubitMock.close();
  });

  setUpAll(() {
    registerFallbackValue(FakeAddNoteState());
  });

  setUp(() {
    testedCubitMock = MockAddNoteCubit();
    testedWidget = BlocProvider.value(
      value: testedCubitMock,
      child: const MaterialApp(
        home: AddNoteScreen(),
      ),
    );
  });

  group('AddNoteScreen', () {
    testWidgets('add note view initial values', (tester) async {
      when(() => testedCubitMock.state).thenReturn(AddNoteInitial());
      await tester.pumpWidget(testedWidget);
      await tester.pumpAndSettle();

      expect(
        find.text('Add note'),
        findsOneWidget,
        reason: 'missing add note text',
      );

      expect(
        find.byType(TextFormField),
        findsOneWidget,
        reason: 'missing textfield',
      );

      expect(
        find.text('Save'),
        findsOneWidget,
        reason: 'missing save text',
      );
    });
  });
}
