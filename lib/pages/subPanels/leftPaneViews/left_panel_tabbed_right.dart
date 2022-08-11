// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pp6_layout/bits_and_pieces/myTabBar.dart';
import 'package:pp6_layout/pages/subPanels/library_listing.dart';
import 'package:pp6_layout/pages/subPanels/playlists_listing.dart';



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
        preferredSize: const Size.fromHeight(60),
        child: Container(
          //alignment: Alignment.center,
          //color: const Color.fromARGB(255, 244, 244, 244),
          child: Column(
            children: [
              myTabBar(_tabController, context),
            ],
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
