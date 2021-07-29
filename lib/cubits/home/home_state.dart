part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.notes);

  final List<Note> notes;

  @override
  List<Object> get props => notes;
}

class HomeError extends HomeState {
  const HomeError(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
