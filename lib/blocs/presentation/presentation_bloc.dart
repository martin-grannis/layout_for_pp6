import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pp6_layout/blocs/playlist/playlist_bloc.dart';
import 'package:pp6_layout/models/playlist.dart';
import 'package:pp6_layout/models/presentation.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

part 'presentation_event.dart';
part 'presentation_state.dart';

class PresentationBloc extends Bloc<PresentationEvent, PresentationState> {
// this bloc variables
  final ConnectionRepository _connectionRepository;
  //late PlaylistBloc _playlist_bloc;

  PresentationBloc({required connectionRepository})
      : _connectionRepository = connectionRepository,
        super(PresentationInitialState()) {
    on<PresentationEventLoadSong>(_onPresentationLoadSongRequested);
    on<PresentationEventLoadSongArray>(_onPresentationLoadSongArrayRequested);
    on<PresentationEventShowSong>(_onPresentationShowRequested);
  }

  FutureOr<void> _onPresentationLoadSongRequested(
      PresentationEventLoadSong event, Emitter<PresentationState> emit) async {
    // temp vars
    String this_song = event.this_presentation;
    List<Presentation>? next_if_needed = event.nextTwoSongs;
    bool fromLibrary = event.RequestFromLibrary;

    Presentation? this_presentation =
        await _connectionRepository.getPresentation(this_song);

    emit(PresentationLoadedState(currentPresentation: this_presentation!));
  }

  FutureOr<void> _onPresentationLoadSongArrayRequested(
      PresentationEventLoadSongArray event, Emitter<PresentationState> emit) async {
    // temp vars
    List<Playlist> lpl = event.passed_in_presentations;
    
 for (var p in lpl) {
        if (p.playlistItemType == "playlistItemTypePresentation"){
            Presentation? this_presentation =
        await _connectionRepository.getPresentation(p.playlistItemName!);
        }
 }
    
    // Presentation? this_presentation =
    //     await _connectionRepository.getPresentation(this_song);

    // emit(PresentationLoadedState(currentPresentation: this_presentation!));
  }




  FutureOr<void> _onPresentationShowRequested(
      PresentationEventShowSong event, Emitter<PresentationState> emit) async {
    await _connectionRepository.showPresentationByIndex(
        event.this_presentation_name, event.this_index);

    // no state changes (erm is that right?) so no emit here
    //emit(PresentationLoadedState(
    //currentPresentation: this_presentation_name!, setAsCurrentSong: true));
  }
}
