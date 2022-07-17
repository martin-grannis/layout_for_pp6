// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';


class LeftPanelPlaylist extends StatefulWidget {
  const LeftPanelPlaylist({Key? key}) : super(key: key);

  @override
  State<LeftPanelPlaylist> createState() => _LeftPanelPlaylistState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _LeftPanelPlaylistState extends State<LeftPanelPlaylist>
    //with SingleTickerProviderStateMixin {
    with
        TickerProviderStateMixin {
  // static const List<Tab> myTabs = <Tab>[
  //   Tab(text: "Left"),
  //   Tab(text: "Right"),
  // ];

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
                child: Text("PLAYLIST"),
                ),
              ),
              //SizedBox(width: 60),
            
          ),
      
      ),
    );
  }
}
