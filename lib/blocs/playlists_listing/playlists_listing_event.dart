part of 'playlists_listing_bloc.dart';

abstract class PlaylistsListingEvent extends Equatable {
  const PlaylistsListingEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaylistsFromAPI extends PlaylistsListingEvent {}
