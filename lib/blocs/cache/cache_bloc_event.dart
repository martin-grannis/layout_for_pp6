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

// class deleteCacheItem extends CacheBlocEvent {
//   final String itemName;
//   const deleteCacheItem({
//     required this.itemName,
//   });
// }

