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
  final List<Playlist> previousTop;
  final List<Playlist> previousPreviousTop;

  const PlaylistsLoaded(
      {required this.playlist_list, required this.isTop, required this.previousPreviousTop, required this.previousTop}
      );

  // get playlist_list => this.playlist_list;

  @override
  List<Object> get props => [playlist_list, isTop, previousTop, previousPreviousTop];

  PlaylistsLoaded copyWith({
    List<Playlist>? playlist_list,
    bool? isTop,
    List<Playlist>? previousTop,
    List<Playlist>? previousPreviousTop,
  }) {
    return PlaylistsLoaded(
      
      playlist_list: this.playlist_list,
      isTop: this.isTop,
      previousPreviousTop: this.previousPreviousTop,
      previousTop: this.previousTop, 
      
      
      
    );
  }
}
