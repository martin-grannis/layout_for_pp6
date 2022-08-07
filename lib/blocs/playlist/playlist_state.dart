part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistState extends Equatable {
  final Playlist playlist = Playlist();
  @override
  List<Object> get props => [playlist];
}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final Playlist playlist;
  bool fromTop;
  PlaylistLoaded({
    required this.playlist,
    required this.fromTop,
  });
  @override
  List<Object> get props => [playlist, fromTop];
}
