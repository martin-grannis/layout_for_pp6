part of 'library_bloc.dart';

@immutable
abstract class LibraryState extends Equatable {
  const LibraryState();
  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final Library library;
  final String currentSong;

  const LibraryLoaded({
    required this.library,
    required this.currentSong,
  });

  @override
  List<Object> get props => [library, currentSong];
}

class LibraryError extends LibraryState {}
