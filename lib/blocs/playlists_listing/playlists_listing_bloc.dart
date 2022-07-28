import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    on<LoadPlaylistPlaylist>(_loadSubPlaylists);
  }

  void _loadSubPlaylists(
    LoadPlaylistPlaylist event,
    Emitter<PlaylistsListingState> emit,
  ) async {
    var s = state as PlaylistsLoaded;

    s.copyWith(
        playlist_list: event.playlist_list,
        previousTop: event.previousTop,
        previousPreviousTop: event.previousPreviousTop);
    try {
      String pla = await _connectionRepository.getPlaylists();
      dynamic scanData_decoded = jsonDecode(pla);
      PlaylistRequestAll tmp = PlaylistRequestAll.fromJson(scanData_decoded);
      List<Playlist>? result = tmp.playlistAll;
      print("about to emit Playlists init Loaded");
      emit(PlaylistsLoaded(
        playlist_list: result!,
        isTop: true,
        previousTop: result,
        previousPreviousTop: result,
      ));
      print("have emitted Playlists init Loaded");
      return;
    } catch (e) {
      print(e.toString());
      return;
    }
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
        isTop: true,
        previousTop: result,
        previousPreviousTop: result,
      ));
      print("have emitted Playlists init Loaded");
      return;
    } catch (e) {
      print(e.toString());
      //emit(Playlists_Listing_State.error("cannot load playlists"));
      return;
    }
  }
}
