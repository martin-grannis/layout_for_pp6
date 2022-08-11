part of 'filtered_library_bloc.dart';

abstract class FilteredLibraryState extends Equatable {
  const FilteredLibraryState();

  @override
  List<Object> get props => [];

  
}

class FilteredLibraryLoadInProgress extends FilteredLibraryState {}

class FilteredLibraryLoadSuccess extends FilteredLibraryState {
  final Library filteredLibrary;
  final String activeFilter;
  final String currentSong;

  const FilteredLibraryLoadSuccess(
    this.filteredLibrary,
    this.activeFilter,
    this.currentSong,
  );

  @override
  List<Object> get props => [filteredLibrary, activeFilter, currentSong];

  @override
  String toString() {
    return 'FilteredLibraryLoadSuccess { filteredTodos: $filteredLibrary, activeFilter: $activeFilter }';
  }
}
