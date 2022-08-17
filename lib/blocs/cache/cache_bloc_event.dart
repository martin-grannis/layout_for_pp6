part of 'cache_bloc_bloc.dart';

abstract class CacheBlocEvent extends Equatable {
  const CacheBlocEvent();

  @override
  List<Object> get props => [];
}

class addCacheItem extends CacheBlocEvent {
  final PresentationCacheItem cacheItem;
  const addCacheItem({
    required this.cacheItem,
  });
}

class setCurrentSong extends CacheBlocEvent {
  final String songName;
  const setCurrentSong({
    required this.songName,
  });
}

class setLastSelectedPlaylist extends CacheBlocEvent {
  final String playlistName;
  const setLastSelectedPlaylist({
    required this.playlistName,
  });
}

class setCurrentPlaylist extends CacheBlocEvent {}


// class deleteCacheItem extends CacheBlocEvent {
//   final String itemName;
//   const deleteCacheItem({
//     required this.itemName,
//   });
// }

