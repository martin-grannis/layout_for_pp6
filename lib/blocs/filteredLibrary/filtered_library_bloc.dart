import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pp6_layout/blocs/library/library_bloc.dart';
import 'package:pp6_layout/models/library.dart';
import 'package:pp6_layout/models/library.dart';

part 'filtered_library_event.dart';
part 'filtered_library_state.dart';

class FilteredLibraryBloc
    extends Bloc<FilteredLibraryEvent, FilteredLibraryState> {
  final LibraryBloc myLibraryBloc;
  late StreamSubscription librarySubscription;

  FilteredLibraryBloc({required this.myLibraryBloc})
      : super(myLibraryBloc.state is LibraryLoaded
            ? FilteredLibraryLoadSuccess(
                (myLibraryBloc.state as LibraryLoaded).library, "", "")
            : FilteredLibraryLoadInProgress()) {
// listening
    librarySubscription = myLibraryBloc.stream.listen((state) {
      if (state is LibraryLoaded) {
        add(LibraryUpdated((myLibraryBloc.state as LibraryLoaded).library));
      }
    });

// eventHandlers
    on<FilterUpdated>((FilterUpdated event, emit) {
      if (myLibraryBloc.state is LibraryLoaded) {
        // do the filtering here
        //var s = myLibraryBloc.state as LibraryLoaded;
        var s = myLibraryBloc.state as LibraryLoaded;
        var nLib = s.library.lib;
        var nLib2 = nLib
            .where((e) =>
                e.itemName!.toLowerCase().contains(event.filter.toLowerCase()))
            .toList();
        Library l = Library(lib: nLib2 as List<LibraryItems>);
        emit(FilteredLibraryLoadSuccess(l, event.filter, s.currentSong));
        String stopme = "here";
      }
    });
    on<LibraryUpdated>((LibraryUpdated event, emit) {
      emit(FilteredLibraryLoadSuccess(event.library, "",""));
    });
  }
}
