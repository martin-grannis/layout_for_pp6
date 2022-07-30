//import 'package:connection_repository/connection_repository.dart';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/blocs/playlist/playlist_bloc.dart';
import 'package:pp6_layout/blocs/playlists_listing/playlists_listing_bloc.dart';

class PlaylistsListing extends StatefulWidget {
  const PlaylistsListing({Key? key}) : super(key: key);

  @override
  _PlaylistsListingState createState() => _PlaylistsListingState();
}

class _PlaylistsListingState extends State<PlaylistsListing> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    var bp_p = BlocProvider.of<PlaylistsListingBloc>(context);
    if (bp_p.state is PlaylistsInitial) {
      bp_p.add(LoadPlaylistsFromAPI());
    }
    // if (!bp_l.state.isLoaded) {
    //   bp_l.add(LibraryEventGetLibrary());
    // }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    // var pixelRatio = window.devicePixelRatio;
    // var logicalScreenSize = window.physicalSize / pixelRatio;
    // var logicalWidth = logicalScreenSize.width;
    //double w = Horizon

    return BlocBuilder<PlaylistsListingBloc, PlaylistsListingState>(
      builder: (context, state) {
        if (state is PlaylistsInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PlaylistsLoaded) {
          return Column(
            children: [
              Row(children: [
                Expanded(
                  flex: 5,
                  child: state.history.history!.length > 1
                      ? TextButton(
                          onPressed: (() {
                            context
                                .read<PlaylistsListingBloc>()
                                .add(LoadPlaylistUpwards());
                            // else playlist_listing = previousList, and previouspreviouslist
                          }),
                          child: Text("back",
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        )
                      : Container(),
                ),
                Expanded(
                  flex: 35,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Row(
                      children: [
                        Text("Playlist Folder: "),
                        Text("${state.breadcrumbs}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
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
                    itemCount: state.playlist_list.length > 0
                        ? state.playlist_list.length
                        : 0,
                    //itemCount: 0, // testing
                    itemBuilder: (BuildContext context, int index) {
                      return myPlaylist_listingItems(context, state, index);
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

  Padding myPlaylist_listingItems(BuildContext context, state, int index) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: Container(
        color: state.playlist_list[index].playlistType == "playlistTypeGroup"
            ? Colors.green
            : Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    state.playlist_list[index].playlistType ==
                            "playlistTypeGroup"
                        ? 80
                        : 60,
                    0,
                    0,
                    0),
                child: TextButton(
                  onPressed: () => {
                    // fire leftpane change to panel 1
                    // fire  playlistsBloc folderChanged (also send ifTop)- send the playlists list from this level
                    // ie the children of this item become the top level ion the pane.

                    if (state.playlist_list[index].playlistType ==
                        "playlistTypeGroup")
                      {
                        //     // is a folder name
                        BlocProvider.of<PlaylistsListingBloc>(context).add(
                          LoadPlaylistDownwards(
                            playlist_list: state.playlist_list[index].playlist,
                            clickedItemName:
                                state.playlist_list[index].playlistName,
                          ),
                        ),
                        BlocProvider.of<LayoutBloc>(context).add(
                            LayoutEventChangeLayout(
                                newLayout: 2)), // playlist listing in left pane
                      }
                    else
                      {
                        //send a playlistgItemselected event
                        BlocProvider.of<PlaylistBloc>(context).add(
                            PlaylistLoad(playlist: state.playlist_list[index])),
                        BlocProvider.of<LayoutBloc>(context).add(
                            LayoutEventChangeLayout(
                                newLayout: 3)), // playlist in left pane
                      }
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // child: state.currentSong == state.library[index].itemName ? Text(libReformatText(
                    //     state.library[index])): Text("CURRENT"),
                    child: PlaylistsItem(state, index),
                    //child: Text(state.myPlaylist[index].playlistName),
                  ),
                  // style: FlutterFlowTheme.of(context).bodyText1.override(
                  //       fontFamily: 'Poppins',
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                ),
              ),
            ),
            // Align(
            //   alignment: AlignmentDirectional(0, -0.05),
            //   child: Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
            //     child: Container(
            //       width: 30,
            //       height: 30,
            //       decoration: BoxDecoration(
            //         // color: state.currentSong == state.library.lib[index].itemName
            //         //     ? Colors.red
            //         //     : Colors.white,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Align(
            //         alignment: AlignmentDirectional(0, 0.2),
            //         child: Icon(
            //           Icons.tv_outlined,
            //           color: Colors.white,
            //           // size: state.currentSong == state.library.lib[index].itemName
            //           //     ? 20
            //           //     : 0,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(4, 5, 0, 0),
            //   child: Container(
            //     width: 30,
            //     height: 30,
            //     decoration: BoxDecoration(
            //       // color: state.library.lib[index].inCache
            //       //     ? Colors.green
            //       //     : Colors.white,
            //       shape: BoxShape.circle,
            //     ),
            //     child: Align(
            //       alignment: AlignmentDirectional(0, -0.3),
            //       child: Icon(
            //         Icons.check,
            //         color: Colors.white,
            //         // size: state.library.lib[index].inCache ? 20 : 0,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Padding PlaylistsItem(state, int index) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Text(
          playlist_reformatText(state.playlist_list[index], state, index),
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ));
  }

  String playlist_reformatText(playlistItem, state, index) {
    String songName = playlistItem.playlistName.replaceAll('.pro6', '').trim();
    var temp = songName.split('/');
    songName = temp[temp.length - 1];

    // if (library.inCache) {
    //   libName = libName + " YAY";
    // }
    String txt = "";
    if (state.playlist_list[index].playlistType == "playlistTypeGroup") {
      txt = " > ";
    }

    return "${txt} ${songName}";
  }
}
