part of 'playlists_listing_bloc.dart';

abstract class PlaylistsListingState extends Equatable {
  const PlaylistsListingState();

  //get playlist_list => this.playlist_list;

  @override
  List<Object> get props => [];
}

class PlaylistsInitial extends PlaylistsListingState {}

class PlaylistsLoaded extends PlaylistsListingState {
  final List<Playlist> playlist_list;
  final bool isTop;

  const PlaylistsLoaded(
      {this.playlist_list = const <Playlist>[], this.isTop = false});

  // get playlist_list => this.playlist_list;

  @override
  List<Object> get props => [playlist_list, isTop];
}
