part of 'playlists_listing_bloc.dart';

abstract class PlaylistsListingState extends Equatable {
  // get playlist_list => this.playlist_list;

  @override
  List<Object> get props => [];
}

class PlaylistsInitial extends PlaylistsListingState {}

class PlaylistsLoaded extends PlaylistsListingState {
  final List<Playlist> playlist_list;
  final History history;

  PlaylistsLoaded(
      {this.playlist_list = const <Playlist>[], this.history = History.empty});

  // get playlist_list => this.playlist_list;
  //get playlist_list => this.playlist_list;

  @override
  List<Object> get props => [playlist_list, history];

  get breadcrumbs {
    List<HistoryItem> mhi = this.history.history as List<HistoryItem>;
    String str = "";

    bool first = true;
    for (HistoryItem hi in mhi) {
      if (first && mhi.length>1) {
        first = false;
      } else {
        str = "${str}/${hi.groupName}";
      }
    }
    return str;
  }

  PlaylistsLoaded copyWith({
    List<Playlist>? playlist_list,
    History? history,
  }) {
    return PlaylistsLoaded(
      history: this.history,
      playlist_list: this.playlist_list,
    );
  }
}
