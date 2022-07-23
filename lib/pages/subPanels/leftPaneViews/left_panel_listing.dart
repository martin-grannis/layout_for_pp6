// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LeftPanelListing extends StatefulWidget {
  const LeftPanelListing({Key? key}) : super(key: key);

  @override
  State<LeftPanelListing> createState() => _LeftPanelListingState();
}



class _LeftPanelListingState extends State<LeftPanelListing>
    //with SingleTickerProviderStateMixin {
    with
        TickerProviderStateMixin {
  // static const List<Tab> myTabs = <Tab>[
  //   Tab(text: "Left"),
  //   Tab(text: "Right"),
  // ];
final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          color: const Color.fromARGB(255, 244, 244, 244),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //padding: EdgeInsets.zero,
              child: Text("LISTING"),
            ),

            //SizedBox(width: 60),
          ),
        ),
      ),
    );
  }
}
