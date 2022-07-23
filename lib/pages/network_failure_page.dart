import 'package:flutter/material.dart';

class NetworkFailurePage extends StatefulWidget {
  const NetworkFailurePage({Key? key}) : super(key: key);

  @override
  State<NetworkFailurePage> createState() => _NetworkFailurePageState();
}

// final scaffoldKey = GlobalKey<ScaffoldState>();

class _NetworkFailurePageState extends State<NetworkFailurePage>
    with SingleTickerProviderStateMixin {
  // static const List<Tab> myTabs = <Tab>[
  //   Tab(text: "Left"),
  //   Tab(text: "Right"),
  // ];

  //late TabController _tabController;

  @override
  void initState() {
    super.initState();
    
  }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("NETWORK HAS FAILED"),
    );
  }
}
