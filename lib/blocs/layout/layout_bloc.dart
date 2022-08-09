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
      //: super(LayoutInitial()) {
      : super(LayoutCurrent(leftWindowStatus: 0, lockedSplit: false)) {
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
      if (state is LayoutCurrent) {
        var s = state as LayoutCurrent;
        emit(s.copyWith(leftWindowStatus: event.newLayout));
      }
    });

    on<LockSplitPoint>((event, emit) {
      if (state is LayoutCurrent) {
        var s = state as LayoutCurrent;
        var t = s.copyWith(lockedSplit: event.lockedSplit);
        emit(t);
      }
    });
  }
  @override
  void onTransition(Transition<LayoutEvent, LayoutState> transition) {
    super.onTransition(transition);
    var t = transition.currentState;
    var n = transition.nextState;

    debugPrint("PRE: ${t.leftWindowStatus}\n${t.lockedSplit}\n\n");
    debugPrint("POST: ${n.leftWindowStatus}\n${n.lockedSplit}\n\n");
  }
}
