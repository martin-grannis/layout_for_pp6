part of 'cache_bloc_bloc.dart';

abstract class CacheBlocEvent extends Equatable {
  const CacheBlocEvent();

  @override
  List<Object> get props => [];
}

class addCacheItem extends CacheBlocEvent {
  final String itemName;
  const addCacheItem({
    required this.itemName,
  });
}

class deleteCacheItem extends CacheBlocEvent {
  final String itemName;
  const deleteCacheItem({
    required this.itemName,
  });
}

