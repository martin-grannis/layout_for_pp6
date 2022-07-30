import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/models/playlist.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

part 'playlists_listing_event.dart';
part 'playlists_listing_state.dart';

class PlaylistsListingBloc
    extends Bloc<PlaylistsListingEvent, PlaylistsListingState> {
  final ConnectionRepository _connectionRepository;
  PlaylistsListingBloc({required ConnectionRepository connectionRepository})
      : _connectionRepository = connectionRepository,
        super(PlaylistsInitial()) {
    on<LoadPlaylistsFromAPI>(_loadPlaylists);
    //on<LoadPlaylistFromTop>(_loadPlaylists);

    on<ResetPlaylistListingToInitial>((event, emit) async {
      emit(PlaylistsInitial());
    });

    on<LoadPlaylistDownwards>(_loadPlaylistDownwards);
    on<LoadPlaylistUpwards>(_loadPlaylistUpwards);
  }

  final StreamController<bool> streamController = StreamController.broadcast();
  Stream<bool> get aStream => streamController.stream;

// Stream<bool> get playlistListingUpdates async* {
//     yield* _controller.stream;
//   }

  void _loadPlaylistUpwards(
    LoadPlaylistUpwards event,
    Emitter<PlaylistsListingState> emit,
  ) {
    PlaylistsLoaded s = state as PlaylistsLoaded;
// pop the last histoyr of the bottom as that is us
// and then load the last one
    History old_h = s.history;
    var l = old_h.history?.length;

    old_h.history?.removeLast();
    var lastP = old_h.history![l! - 2].currentPlaylist;
    emit(PlaylistsLoaded(
        history: old_h, playlist_list: lastP as List<Playlist>));

    if (l == 2) {
      streamController.sink.add(true);
    }

    return;
  }

  void _loadPlaylistDownwards(
    LoadPlaylistDownwards event,
    Emitter<PlaylistsListingState> emit,
  ) {
    PlaylistsLoaded s = state as PlaylistsLoaded;

    //String stopme = "YAY";
    History old_h = s.history;
    List<Playlist> new_playlist_list = event.playlist_list;
    old_h.history!
        .add(HistoryItem(new_playlist_list, false, event.clickedItemName));

    emit(PlaylistsLoaded(history: old_h, playlist_list: new_playlist_list));

    return;
  }

  void _loadPlaylists(
    LoadPlaylistsFromAPI event,
    Emitter<PlaylistsListingState> emit,
  ) async {
    try {
      String pla = await _connectionRepository.getPlaylists();
      dynamic scanData_decoded = jsonDecode(pla);
      PlaylistRequestAll tmp = PlaylistRequestAll.fromJson(scanData_decoded);
      List<Playlist>? result = tmp.playlistAll;
      print("about to emit Playlists init Loaded");
      emit(PlaylistsLoaded(
          playlist_list: result!,
          history: History([HistoryItem(result, true, "")])));
      print("have emitted Playlists init Loaded");
      return;
    } catch (e) {
      print(e.toString());
      //emit(Playlists_Listing_State.error("cannot load playlists"));
      return;
    }
  }
}
