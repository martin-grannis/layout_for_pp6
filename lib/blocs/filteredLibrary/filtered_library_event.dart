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

  const LibraryUpdated(this.library);

  @override
  List<Object> get props => [library];

  @override
  String toString() => 'TodosUpdated { library: $library }';
}