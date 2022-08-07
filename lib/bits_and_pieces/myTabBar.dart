 import 'package:flutter/material.dart';

TabBar myTabBar(TabController _tController) {
    return TabBar(
            //isScrollable: true,
            //overlayColor: ,
            controller: _tController,
            labelPadding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            overlayColor:
                MaterialStateProperty.all<Color>(Colors.white),
            indicator:
             BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(13),
              //border: Border.all(),
            ),
            //indicatorColor: Colors.red,
            //indicatorSize: TabBarIndicatorSize.tab,
            //padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            tabs: [const Text("Library"), const Text("Playlists")],
          );
  }