import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cache_bloc_event.dart';
part 'cache_bloc_state.dart';

class CacheBlocBloc extends Bloc<CacheBlocEvent, CacheBlocState> {
  CacheBlocBloc() : super(CacheBloc(itemNames: const [], currentSong: "")) {
    
    on<addCacheItem>((event, emit) {
      var s = state as CacheBloc;
      var newState = s.copyWith();
      newState.itemNames.add(event.itemName);
      emit(newState);
    });

    on<deleteCacheItem>((event, emit) {
      var s = state as CacheBloc;
      var newState = s.copyWith();
      newState.itemNames.remove(event.itemName);
      emit(newState);
    });

  }
}
