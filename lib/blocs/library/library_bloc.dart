import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pp6_layout/models/library.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final ConnectionRepository _connectionRepository;
  LibraryBloc({required ConnectionRepository connectionRepository})
      : _connectionRepository = connectionRepository,
        super(LibraryInitial()) {
    /// listeners

    // StreamSubscription<PP6_ConnectionStatus>? _PP6_ConnectionStatusSubscription;
    //     _PP6_ConnectionStatusSubscription = _connectionRepository.statusREPO.listen(
    //       //(status) => add(PP6_ConnectionStatusChanged(status, Host.empty)),
    //       (status) {
    //     //catchMe();
    //      add(ResetLibraryToInitial());
    //   });

//final ConnectionRepository _connectionRepository;

    /// handlers
    on<LoadLibraryfromAPI>((event, emit) async {
      // one off load of data into Library
      dynamic lr = await _connectionRepository.getLibrary();
      Library processedLibData = process_library_request(lr);
      print("about to emit libraryLoaded");
      emit(LibraryLoaded(library: processedLibData, currentSong: ""));
      //emit(library);
    });
    on<ResetLibraryToInitial>((event, emit) async {
      emit(LibraryInitial());
    });
    // on<SearchLibrary>((SearchLibrary event, emit) {
    //   Library filtered_library = do_Filter(state.library!, event.value);
    //   emit(LibraryLoaded(
    //       library: filtered_library, currentSong: state.currentSong));
    // });
  }
}

//Library do_Filter(Library l, String str) {
Library do_Filter(Library l, String str) {
  if (str != "") {
    var abc = l.lib.where((i) => i.itemName!.contains(str)).toList();
    return Library(lib: abc as List<LibraryItems>);
  } else {
    return l;
  }
}

Library process_library_request(dynamic json) {
  var scanData_decoded = jsonDecode(json)['library'];
  List<String>? library =
      scanData_decoded != null ? List.from(scanData_decoded) : null;

  Library ll = Library(lib: []);

  try {
    //for (var i = 0; i < library!.length; i++) {
    for (var name in library!) {
      // print(name);
      // if (name == "Your hand, O God, has guided.pro6") {
      //   String stop = "12";
      // }
      ll.lib.add(LibraryItems(itemName: name));
      //newMap['inCache'] = false;
    }
  } catch (e) {
    print(e.toString());
  }

  return ll;
}
