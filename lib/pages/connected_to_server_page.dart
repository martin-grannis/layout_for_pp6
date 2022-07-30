import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:pp6_layout/bits_and_pieces/custom_app_bar.dart';
import 'package:pp6_layout/bits_and_pieces/custom_app_bar2.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/blocs/network/network_bloc.dart';
import 'package:pp6_layout/pages/network_failure_page.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_listing.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_playlist.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_tabbed_left.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_tabbed_right.dart';
import 'package:pp6_layout/pages/subPanels/playlists_listing.dart';
import 'package:pp6_layout/pages/subPanels/right_panel.dart';

class ConnectToServerPage extends StatefulWidget {
  const ConnectToServerPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ConnectToServerPage());
  }

  @override
  State<ConnectToServerPage> createState() => _ConnectToServerPageState();
}



class _ConnectToServerPageState extends State<ConnectToServerPage> {
final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar2(),
        body: BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
          if (BlocProvider.of<NetworkBloc>(context).state
              is ConnectionFailure) {
            return NetworkFailurePage();
          } else {
            return MultiSplitView(children: [
              BlocBuilder<LayoutBloc, LayoutState>(
                builder: (context, state) {
                  switch (state.leftWindowStatus) {
                    case 0:
                      return const LeftPanelTabbedLeft();

                    case 1:
                      return const LeftPanelTabbedRight();

                    case 2:
                    
                      //return const LeftPanelListing();
                      return const PlaylistsListing();

                    case 3:
                      return const LeftPanelPlaylist();
                  }
                  return const LeftPanelPlaylist(); // as we must return something bu is dead code!
                },
              ),
              const RightPanel(),
            ]);
          }
        }));
  }
}
