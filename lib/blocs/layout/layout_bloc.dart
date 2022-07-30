import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/playlists_listing/playlists_listing_bloc.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  StreamSubscription? subscription;
  PlaylistsListingBloc? playlistListingBloc;

  LayoutBloc({subscription, required PlaylistsListingBloc playlistListingBloc})
      : super(LayoutInitial()) {
    // listeners
    on<ListenPlaylistListing>((event, emit) {
      subscription =
          playlistListingBloc.streamController.stream.listen((status) {
        if (status) {
          add(LayoutEventChangeLayout(newLayout: 1));
        }
      });
    });

// event handlers

    on<LayoutEventChangeLayout>((event, emit) {
      emit(state.copyWith(leftWindowStatus: event.newLayout));
    });
  }
  @override
  void onTransition(Transition<LayoutEvent, LayoutState> transition) {
    super.onTransition(transition);
    debugPrint("${transition.currentState}\n${transition.nextState}\n\n");
  }
}
