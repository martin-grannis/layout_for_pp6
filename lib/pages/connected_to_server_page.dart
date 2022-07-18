import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_listing.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_playlist.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_tabbed_left.dart';
import 'package:pp6_layout/pages/subPanels/leftPaneViews/left_panel_tabbed_right.dart';
import 'package:pp6_layout/pages/subPanels/right_panel.dart';


class ConnectToServerPage extends StatefulWidget {
  const ConnectToServerPage({Key? key}) : super(key: key);

static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ConnectToServerPage());
  }

  @override
  State<ConnectToServerPage> createState() => _ConnectToServerPageState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _ConnectToServerPageState extends State<ConnectToServerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //appBar: AppBar(title: Text("my layout app")),
      body: MultiSplitView(
        children: [
          BlocBuilder<LayoutBloc, LayoutState>(
            builder: (context, state) {
              switch (state.leftWindowStatus) {
                case 0:
                  return const LeftPanelTabbedLeft();

                case 1:
                  return const LeftPanelTabbedRight();

                case 2:
                  return const LeftPanelListing();

                case 3:
                  return const LeftPanelPlaylist();
              }
              return const LeftPanelPlaylist(); // as we must return something bu is dead code!
            },
          ),
          // color: Colors.red,

          const RightPanel(),

          // Container(
          //   child: Center(child: Text("View3")),
          //   color: Colors.green,
          // ),,),
        ],
      ),
    );
  }
}
