import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/cache/cache_bloc_bloc.dart';
import 'package:pp6_layout/blocs/presentation/presentation_bloc.dart';
import 'package:pp6_layout/models/playlist.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PresentationBloc _presentationBloc;
  //final ConnectionRepository _connectionRepository;
  //PlaylistBloc({required ConnectionRepository connectionRepository})
  PlaylistBloc({required PresentationBloc myPresentationBloc})
      // : _connectionRepository = connectionRepository,
      : _presentationBloc = myPresentationBloc,
        super(PlaylistInitial()) {
    on<PlaylistLoad>((event, emit) {
      emit(PlaylistLoaded(playlist: event.playlist, fromTop: event.fromTop));
    });
    on<preloadAll>((event, emit) {
      // get playlist items - loop and load
      var s = state as PlaylistLoaded;
      //for (var i = 0; i < s.playlist.playlist!.length; i++) {
        // if playlistItem
        // if (s.playlist.playlist![i].playlistItemType !=
        //     "playlistTypePresentation") {
        //   // event load song
          _presentationBloc.add(PresentationEventLoadSongArray(s.playlist.playlist!));
          //emit(PlaylistInitial());
          //emit(PlaylistInitial());
          //emit(state);
        // }
      //}

      //emit(PlaylistLoaded(playlist: event.playlist, fromTop: event.fromTop));
    });
  }
}
