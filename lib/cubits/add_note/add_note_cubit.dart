import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dao/dao_notes.dart';
import '../../models/note.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this._daoNotes) : super(AddNoteInitial());

  final DaoNotes _daoNotes;

  Future<void> saveNote(String content) async {
    emit(AddNoteLoading());
    try {
      await _daoNotes.create(Note(content, DateTime.now()));
    } on Exception catch (ex) {
      emit(AddNoteError(ex));
    }
  }
}
