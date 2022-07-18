part of 'playlists_listing_bloc.dart';

abstract class PlaylistsListingState extends Equatable {
  const PlaylistsListingState();
  
  @override
  List<Object> get props => [];
}

class PlaylistsListingInitial extends PlaylistsListingState {}
