// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pp6_layout/pages/library_panel.dart';
import 'package:pp6_layout/pages/playlists_panel.dart';


class LeftPanelTabbedRight extends StatefulWidget {
  const LeftPanelTabbedRight({Key? key}) : super(key: key);

  @override
  State<LeftPanelTabbedRight> createState() => _LeftPanelTabbedRightState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _LeftPanelTabbedRightState extends State<LeftPanelTabbedRight>
    //with SingleTickerProviderStateMixin {
    with
        TickerProviderStateMixin {
  // static const List<Tab> myTabs = <Tab>[
  //   Tab(text: "Left"),
  //   Tab(text: "Right"),
  // ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 1,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          color: const Color.fromARGB(255, 244, 244, 244),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //padding: EdgeInsets.zero,
              child: TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                labelColor: Colors.black,
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.tab,
                //padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                tabs: [const Text("Library"), const Text("Playlists")],
              ),
            ),
            //SizedBox(width: 60),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const LibraryPanel(),
          const PlaylistPanel(),
        ],
      ),
    );
  }
}
