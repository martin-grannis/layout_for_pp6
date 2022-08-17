import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pp6_layout/models/presentation.dart';

part 'cache_bloc_event.dart';
part 'cache_bloc_state.dart';

class CacheBlocBloc extends Bloc<CacheBlocEvent, CacheBlocState> {
  CacheBlocBloc()
      : super(CacheBloc(
            songCache: [],
            currentSong: "",
            currentPlaylist: "",
            lastSelectedPlaylist: "")) {
    //final StreamController<String> streamController =
    //  StreamController.broadcast();

    on<addCacheItem>((event, emit) {
      var s = state as CacheBloc;
      var newState = s.addCacheItem(songItem: event.cacheItem);
      emit(newState);
    });

    on<setCurrentSong>((event, emit) {
      var s = state as CacheBloc;
      emit(s.copyWith(currentSong: event.songName));
      //streamController.sink.add(event.songName);
    });

    on<setLastSelectedPlaylist>((event, emit) {
      var s = state as CacheBloc;
      emit(s.copyWith(lastSelectedPlaylist: event.playlistName));
      //streamController.sink.add(event.songName);
    });

    on<setCurrentPlaylist>((event, emit) {
      var s = state as CacheBloc;
      emit(s.copyWith(currentPlaylist: s.lastSelectedPlaylist));
      //streamController.sink.add(event.songName);
    });

    // on<deleteCacheItem>((event, emit) {
    //   var s = state as CacheBloc;
    //   var newState = s.deleteCacheItem(itemName: event.itemName);
    //   emit(newState);
    // });
  }

  @override
  void onTransition(Transition<CacheBlocEvent, CacheBlocState> transition) {
    super.onTransition(transition);
    var t = transition.currentState;
    var n = transition.nextState;

    debugPrint("PRE: ${t}\n${t}\n\n");
    //debugPrint("POST: ${n.leftWindowStatus}\n${n.lockedSplit}\n\n");
  }
}
