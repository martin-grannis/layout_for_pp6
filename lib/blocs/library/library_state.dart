part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  get library => this.library;

  get currentSong => this.currentSong;
}

class LibraryInitial extends LibraryState {
  @override
  List<Object> get props => [];
}

class LibraryLoading extends LibraryState {
  @override
  List<Object> get props => [];
}

class LibraryLoaded extends LibraryState {
  @override
  Library library;
  @override
  String currentSong = "";

  LibraryLoaded({
    required this.library,
    required this.currentSong,
  }) {
    this.library = library;
    this.currentSong = currentSong;
  }

  @override
  List<Object> get props => [library];
}

class LibraryError extends LibraryState {
  @override
  List<Object> get props => [];
}
