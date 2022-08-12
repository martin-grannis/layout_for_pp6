part of 'cache_bloc_bloc.dart';

abstract class CacheBlocState extends Equatable {
  const CacheBlocState();

  @override
  List<Object> get props => [];
}

//class CacheBlocInitial extends CacheBlocState {}

class CacheBloc extends CacheBlocState {
  final String currentSong;
  final List<PresentationCacheItem> songCache;
  const CacheBloc( {
    required this.songCache,
    required this.currentSong,
     
  });

  @override
  List<Object> get props => [songCache, currentSong];
  
  CacheBloc addCacheItem({
    String? currentSong,
//    List<String>? itemNames,
    PresentationCacheItem? songItem,
  }) {
    
    List<PresentationCacheItem>  newL = [...this.songCache, songItem!];

    return CacheBloc(
      currentSong: currentSong ?? this.currentSong,
      songCache: newL,
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

  bool inCache(PresentationCacheItem item) {
    var tmp = this.songCache.indexWhere((element) => element == item);
    return tmp != -1; // -1 means not there
  }

  String getCurrentSong() {
    return currentSong;
  }
}
