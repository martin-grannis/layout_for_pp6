part of 'cache_bloc_bloc.dart';

abstract class CacheBlocState extends Equatable {
  const CacheBlocState();

  @override
  List<Object> get props => [];
}

//class CacheBlocInitial extends CacheBlocState {}

class CacheBloc extends CacheBlocState {
  final String currentSong;
  final String lastSelectedPlaylist;
  final String currentPlaylist;
  final List<PresentationCacheItem> songCache;
  const CacheBloc({
    required this.lastSelectedPlaylist,
    required this.songCache,
    required this.currentSong,
    required this.currentPlaylist,
  });

  @override
  List<Object> get props => [songCache, currentSong, currentPlaylist, lastSelectedPlaylist];

  CacheBloc addCacheItem({
    //String? currentPlaylist,
    //String? currentSong,
//    List<String>? itemNames,
    PresentationCacheItem? songItem,
  }) {
    List<PresentationCacheItem> newL = [...this.songCache, songItem!];

    return CacheBloc(
      lastSelectedPlaylist: this.lastSelectedPlaylist,
      currentSong: this.currentSong,
      currentPlaylist: this.currentPlaylist,
      songCache: newL,
    );
  }

  CacheBloc copyWith({
    String? currentSong,
    String? currentPlaylist,
    String? lastSelectedPlaylist,
    List<PresentationCacheItem>? songCache,
  }) {
    return CacheBloc(
      currentSong: currentSong ?? this.currentSong,
      currentPlaylist: currentPlaylist ?? this.currentPlaylist,
      lastSelectedPlaylist: lastSelectedPlaylist ?? this.lastSelectedPlaylist,
      songCache: songCache ?? this.songCache,
    );
  }
//   CacheBloc deleteCacheItem({
//     String? currentSong,
// //    List<String>? itemNames,
//     String? itemName,
//   }) {
//     List<String> newL = [];
// 	newL = [...this.itemNames!];
//       newL.remove(itemName);
//     return CacheBloc(
//       currentSong: currentSong ?? this.currentSong,
//       itemNames: newL,
//     );
//   }

  bool inCache(String item) {
    var tmp = this.songCache.indexWhere(
        (element) => element.presentation!.presentationName == item);
    return tmp != -1; // -1 means not there
  }

  bool amICurrentSong(String item) {
    return (currentSong == item);
  }
}
