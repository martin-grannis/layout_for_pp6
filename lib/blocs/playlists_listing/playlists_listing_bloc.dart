import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

part 'playlists_listing_event.dart';
part 'playlists_listing_state.dart';

class PlaylistsListingBloc extends Bloc<PlaylistsListingEvent, PlaylistsListingState> {
    final ConnectionRepository _connectionRepository;
  PlaylistsListingBloc({required ConnectionRepository connectionRepository}) :  _connectionRepository = connectionRepository, super(PlaylistsListingInitial()) {
    
    on<LoadPlaylistsFromAPI>((event, emit) async {
      // one off load of data into Library
      dynamic pl = await _connectionRepository.getPlaylists();
      //Library processedLibData = process_library_request(lr);
      print("about to emit playlists loaded");
      //emit(LibraryLoaded(library: processedLibData, currentSong:""));
      //emit(library);
    });
  }
}


// Library process_library_request(dynamic json) {
//   var scanData_decoded = jsonDecode(json)['library'];
//   List<String>? library =
//       scanData_decoded != null ? List.from(scanData_decoded) : null;

//   Library ll = Library(lib: []);
//   ;

//   try {
//     //for (var i = 0; i < library!.length; i++) {
//     for (var name in library!) {
//       // print(name);
//       // if (name == "Your hand, O God, has guided.pro6") {
//       //   String stop = "12";
//       // }
//       ll.lib.add(LibraryItems(itemName: name));
//       //newMap['inCache'] = false;
//     }
//   } catch (e) {
//     print(e.toString());
//   }

//   return ll;
// }
