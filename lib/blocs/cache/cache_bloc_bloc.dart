import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pp6_layout/models/presentation.dart';

part 'cache_bloc_event.dart';
part 'cache_bloc_state.dart';

class CacheBlocBloc extends Bloc<CacheBlocEvent, CacheBlocState> {
  CacheBlocBloc() : super(CacheBloc(songCache: [], currentSong: "")) {
    on<addCacheItem>((event, emit) {
      var s = state as CacheBloc;
      var newState = s.addCacheItem(songItem: event.cacheItem);
      emit(newState);
    });

    // on<deleteCacheItem>((event, emit) {
    //   var s = state as CacheBloc;
    //   var newState = s.deleteCacheItem(itemName: event.itemName);
    //   emit(newState);
    // });
  }
}
