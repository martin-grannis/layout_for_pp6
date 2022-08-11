part of 'filtered_library_bloc.dart';

abstract class FilteredLibraryEvent extends Equatable {
  const FilteredLibraryEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends FilteredLibraryEvent {
  final String filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class LibraryUpdated extends FilteredLibraryEvent {
  final library;
  final activeFilter;

  final currentSong;
  
  //const LibraryUpdated(this.library, this.currentSong);
  const LibraryUpdated(this.library, this.activeFilter, this.currentSong);

  @override
  List<Object> get props => [library, currentSong, activeFilter];

  @override
  String toString() => 'TodosUpdated { library: }';
}
