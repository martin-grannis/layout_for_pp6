// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pp6_layout/bits_and_pieces/playlistHeadingWidget.dart';
import 'package:pp6_layout/blocs/playlist/playlist_bloc.dart';

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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        if (state is PlaylistInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PlaylistLoaded) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Playlist: xxxxxxxxxx"),
                )
              ]),
              Container(
                //color:Colors.red,
                width: w,
                height: h - 146,
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    scrollDirection: Axis.vertical,
                    primary: false,
                    itemCount: state.playlist.playlist!.length > 0
                        ? state.playlist.playlist?.length
                        : 0,
                    //itemCount: 0, // testing
                    itemBuilder: (BuildContext context, int index) {
                      // return Container();
                      return PlaylistItem(state, index);
                    }),
              ),
            ],
          );
        }
        return const Text(
            "something went wrong playlist listing"); // to keep the compiler happy
      },
    );
  }

  PlaylistItem(PlaylistState state, int index) {
    String? str = state.playlist.playlist![index].playlistItemName;
    str = str!.replaceAll(".pro6", "");

    if (state.playlist.playlist![index].playlistItemType ==
        "playlistItemTypePresentation") {
      // we goit a presentation
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.lyrics, color: Colors.orange),
            TextButton(
              onPressed: (() {}),
              child: Text(
                str,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (state.playlist.playlist![index].playlistItemType ==
        "playlistItemTypeHeader") {
      // we got a heading
      return PlaylistHeadingWidget(text: str);
    }
    return Text("somethign wrong in playlist typing");
  }
}
