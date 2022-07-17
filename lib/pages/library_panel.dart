import 'package:flutter/material.dart';

class LibraryPanel extends StatefulWidget {
  const LibraryPanel({Key? key}) : super(key: key);

  @override
  State<LibraryPanel> createState() => _LibraryPanelState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _LibraryPanelState extends State<LibraryPanel>
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
      child: Text("LEFT LEFT"),
    );
  }
}
