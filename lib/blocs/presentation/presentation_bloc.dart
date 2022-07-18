import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pp6_layout/models/presentation.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';


part 'presentation_event.dart';
part 'presentation_state.dart';

class PresentationBloc extends Bloc<PresentationEvent, PresentationState> {
  final ConnectionRepository _connectionRepository;

  PresentationBloc({required connectionRepository})
      : _connectionRepository = connectionRepository,
        super(PresentationInitialState()) {
    on<PresentationEventLoadSong>(_onPresentationEventRequested);
    on<PresentationEventShowSong>(_onPresentationShowRequested);
  }

  FutureOr<void> _onPresentationEventRequested(
      PresentationEventLoadSong event, Emitter<PresentationState> emit) async {
    // temp vars
    String this_song = event.this_presentation;
    List<Presentation>? next_if_needed = event.nextTwoSongs;
    bool fromLibrary = event.RequestFromLibrary;

    Presentation? this_presentation =
        await _connectionRepository.getPresentation(this_song);

    emit(PresentationLoadedState(
        currentPresentation: this_presentation!));

  }

  FutureOr<void> _onPresentationShowRequested(PresentationEventShowSong event, Emitter<PresentationState> emit) async {
    
    await _connectionRepository.showPresentationByIndex(event.this_presentation_name, event.this_index);

    // no state changes (erm is that right?) so no emit here
    // emit(PresentationLoadedState(
    //     currentPresentation: this_presentation!, setAsCurrentSong: true));
  
  
  }

}
