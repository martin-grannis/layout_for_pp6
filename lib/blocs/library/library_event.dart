part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LoadLibraryfromAPI extends LibraryEvent {}

class ResetLibraryToInitial extends LibraryEvent {}



class LibraryCurrentlyShowingChanged extends LibraryEvent {
  late final String currentSongPath;
  LibraryCurrentlyShowingChanged({
    required this.currentSongPath,
  });
}

class SearchLibrary extends LibraryEvent {
  final String value;

  const SearchLibrary(this.value);
//@override
 // List<Object> get props => [value];
}
