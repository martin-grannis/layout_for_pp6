import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';

Padding myTabBar(TabController _tController, context) {
  //var area = BlocProvider.of<LayoutBloc>(context).state.splitPoint;
  //Size size = MediaQuery.of(context).size;
  //double fSize;

  // if (area >= 0) {
  //   fSize = (size.width) * area*.3;
  // } else {
  //   fSize = 18;
  // }
  return Padding(
    padding: const EdgeInsets.fromLTRB(0,20,0,0),
    child: TabBar(
      isScrollable: true,
      //overlayColor: ,
      controller: _tController,
      labelPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      labelColor: Colors.white,
      labelStyle: TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w200),
      overlayColor: MaterialStateProperty.all<Color>(Colors.white),
      indicator: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(13),
        //border: Border.all(),
      ),
      //indicatorColor: Colors.red,
      //indicatorSize: TabBarIndicatorSize.tab,
      //padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      tabs: [
        Text("Library", style: TextStyle(fontSize: 18)),
        Text("Playlists", style: TextStyle(fontSize: 18))
      ],
    ),
  );
}
