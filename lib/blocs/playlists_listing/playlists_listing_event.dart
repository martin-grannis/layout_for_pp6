part of 'playlists_listing_bloc.dart';

abstract class PlaylistsListingEvent extends Equatable {
  const PlaylistsListingEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaylistsFromAPI extends PlaylistsListingEvent {}

class LoadPlaylistPlaylist extends PlaylistsListingEvent {
  final List<Playlist> playlist_list;
  final List<Playlist> previousTop;
  final List<Playlist> previousPreviousTop;
  final bool calledFromTop;

  const LoadPlaylistPlaylist( {
    required this.calledFromTop,
    required this.playlist_list,
    required this.previousTop,
    required this.previousPreviousTop,
  });
}
