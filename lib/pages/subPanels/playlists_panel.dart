import 'package:flutter/material.dart';

class PlaylistPanel extends StatefulWidget {
  const PlaylistPanel({Key? key}) : super(key: key);

  @override
  State<PlaylistPanel> createState() => _PlaylistPanelState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _PlaylistPanelState extends State<PlaylistPanel>
    with SingleTickerProviderStateMixin {
  // static const List<Tab> myTabs = <Tab>[
  //   Tab(text: "Left"),
  //   Tab(text: "Right"),
  // ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("RIGHT RIGHT"),
    );
  }
}
