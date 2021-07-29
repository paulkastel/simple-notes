part of 'add_note_cubit.dart';

abstract class AddNoteState extends Equatable {
  const AddNoteState();
}

class AddNoteInitial extends AddNoteState {
  @override
  List<Object> get props => [];
}

class AddNoteLoading extends AddNoteState {
  @override
  List<Object> get props => [];
}

class AddNoteSuccess extends AddNoteState {
  @override
  List<Object> get props => [];
}

class AddNoteError extends AddNoteState {
  const AddNoteError(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
