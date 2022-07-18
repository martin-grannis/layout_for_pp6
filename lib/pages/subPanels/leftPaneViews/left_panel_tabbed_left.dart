// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:pp6_layout/pages/subPanels/library_listing.dart';
import 'package:pp6_layout/pages/subPanels/playlists_listing.dart';

class LeftPanelTabbedLeft extends StatefulWidget {
  const LeftPanelTabbedLeft({Key? key}) : super(key: key);

  @override
  State<LeftPanelTabbedLeft> createState() => _LeftPanelTabbedLeftState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _LeftPanelTabbedLeftState extends State<LeftPanelTabbedLeft>
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
      initialIndex: 0,
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
          const LibraryListing(),
          const PlaylistsListing(),
        ],
      ),
    );
  }
}
