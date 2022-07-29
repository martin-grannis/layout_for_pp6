import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    //on<LoadPlaylistUpwards>(_loadSubPlaylists);
  }

  void _loadPlaylistDownwards(
    LoadPlaylistDownwards event,
    Emitter<PlaylistsListingState> emit,
  ) {
    PlaylistsLoaded s = state as PlaylistsLoaded;

    //String stopme = "YAY";
    History old_h = s.history;
    List<Playlist> new_playlist_list = event.playlist_list;
    old_h.history!.add(HistoryItem(new_playlist_list, false, event.clickedItemName));
    // gboing down needs this playlist adding to history, and becomning current - istop is false
    emit(PlaylistsLoaded(history: old_h, playlist_list: new_playlist_list));
    //var s = state;
    //  History old_h = state.history;
    //  List<Playlist> old_playlist_list = state.playlist_list;

    // new history = old History + this current playlust and onop as false

    // emit(PlaylistsLoaded(
    //   playlist_list: result!,
    //   history: History.empty,
    // ));
    print("have emitted Playlists init Loaded");
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
