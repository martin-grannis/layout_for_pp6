//import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/PP6_connection/PP6_connection_bloc.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/blocs/library/library_bloc.dart';
import 'package:pp6_layout/blocs/network/network_bloc.dart';
import 'package:pp6_layout/blocs/playlist/playlist_bloc.dart';
import 'package:pp6_layout/blocs/playlists_listing/playlists_listing_bloc.dart';
import 'package:pp6_layout/blocs/presentation/presentation_bloc.dart';
import 'package:pp6_layout/dialogs/network_down.dart';
import 'package:pp6_layout/myApp.dart';
import 'package:pp6_layout/pages/connected_to_server_page.dart';
import 'package:pp6_layout/pages/network_failure_page.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

ConnectionRepository connectionRepository = ConnectionRepository();
PlaylistsListingBloc _playlistListingbloc =
    PlaylistsListingBloc(connectionRepository: connectionRepository);

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NetworkBloc()..add(ListenConnection()),
          ),
          BlocProvider(
            create: (context) => PlaylistBloc(),
          ),
          BlocProvider(
            create: (context) => LayoutBloc(playlistListingBloc: _playlistListingbloc)..add(ListenPlaylistListing()),
          ),
          BlocProvider(
            create: (context) =>
                LibraryBloc(connectionRepository: connectionRepository),
          ),
          BlocProvider(
            create: (context) => _playlistListingbloc
            // create: (context) => PlaylistsListingBloc(
            //     connectionRepository: connectionRepository),
          ),
          BlocProvider(
            create: (context) =>
                PP6_ConnectionBloc(connectionRepository: connectionRepository)
                  ..add(PP6_Initialise()),
          ),
          BlocProvider(
            create: (context) =>
                PresentationBloc(connectionRepository: connectionRepository),
          ),
        ],
        child: MyApp(
          connectionRepository: ConnectionRepository(),
        ),
      ),
    );
