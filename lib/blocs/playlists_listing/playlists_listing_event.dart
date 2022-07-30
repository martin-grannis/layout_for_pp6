part of 'playlists_listing_bloc.dart';

abstract class PlaylistsListingEvent extends Equatable {
  const PlaylistsListingEvent();

  @override
  List<Object> get props => [];
}

class ResetPlaylistListingToInitial extends PlaylistsListingEvent {}

class LoadPlaylistsFromAPI extends PlaylistsListingEvent {}

// class LoadPlaylistFromTop extends PlaylistsListingEvent {
//   final List<Playlist> playlist_list;

//   const LoadPlaylistFromTop({required this.playlist_list});
//   //bloc will append history with this playlist_list and entry top
//   // then emit state with that new history and playlist
// }

class LoadPlaylistDownwards extends PlaylistsListingEvent {
  final List<Playlist> playlist_list;
  final String? clickedItemName;

  const LoadPlaylistDownwards({
    required this.clickedItemName,
    required this.playlist_list,
  });
  //bloc will append history with this playlist_list and entry not top
  // then emit state with that new history and playlist
}

class LoadPlaylistUpwards extends PlaylistsListingEvent {
  //bloc will remove last history
  // then emit state with last history and last playlist
}

