part of 'playlist_bloc.dart';

abstract class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

class PlaylistLoad extends PlaylistEvent {
  final Playlist playlist;
  final bool fromTop;
  PlaylistLoad({
    required this.playlist,
    required this.fromTop,
  });
}

class preloadAll extends PlaylistEvent {}
