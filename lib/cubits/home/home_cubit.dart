import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dao/dao_notes.dart';
import '../../models/note.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._daoNotes) : super(HomeInitial());

  final DaoNotes _daoNotes;

  Future<void> getNotes() async {
    emit(HomeLoading());
    try {
      final notes = await _daoNotes.getAllNotes();
      emit(HomeSuccess(notes));
    } on Exception catch (ex) {
      emit(HomeError(ex));
    }
  }
}
