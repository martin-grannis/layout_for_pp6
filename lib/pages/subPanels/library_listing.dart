//import 'package:connection_repository/connection_repository.dart';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/library/library_bloc.dart';
import 'package:pp6_layout/blocs/presentation/presentation_bloc.dart';

class LibraryListing extends StatefulWidget {
  const LibraryListing({Key? key}) : super(key: key);

  @override
  State<LibraryListing> createState() => _LibraryListingState();
}

class _LibraryListingState extends State<LibraryListing> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    var bp_l = BlocProvider.of<LibraryBloc>(context);
    if (bp_l.state is LibraryInitial) {
      bp_l.add(LoadLibraryfromAPI());
    }
    // if (!bp_l.state.isLoaded) {
    //   bp_l.add(LibraryEventGetLibrary());
    // }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      if (state is LibraryInitial || state is LibraryLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        if (state is LibraryLoaded) {
          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(80, 10, 80, 0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.red),
                        controller: textController,
                        onChanged: (textValue) => EasyDebounce.debounce(
                          'textController',
                          Duration(milliseconds: 2000),
                          () => {
                            context
                                .read<LibraryBloc>()
                                .add(SearchLibrary(textValue))
                          },
                          // () => setState(() {}),
                        ),
                        autofocus: true,
                        obscureText: false,

                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          hintText: 'Search',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xFFDCD8D8),
                          suffixIcon: textController.text.isNotEmpty
                              ? InkWell(
                                  onTap: () => setState(
                                    () => textController.clear(),
                                  ),
                                  child: Icon(
                                    Icons.clear,
                                    color: Color(0xFF757575),
                                    size: 22,
                                  ),
                                )
                              : null,
                        ),
//                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                //color:Colors.red,
                width: w,
                height: h - 146,
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    scrollDirection: Axis.vertical,
                    primary: true,
                    itemCount: state.library.lib.length > 0
                        ? state.library.lib.length
                        : 0,
                    //itemCount: 0, // testing
                    itemBuilder: (BuildContext context, int index) {
                      return myLibraryItems(context, state, index);
                    }),
              ),
            ],
          );
        } else {
          return Container();
        }
      }
    });
  }

  Padding myLibraryItems(BuildContext context, LibraryState state, int index) {
    var s = state as LibraryLoaded;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(60, 0, 0, 0),
              child: TextButton(
                onPressed: () => {
                  context.read<PresentationBloc>().add(
                      PresentationEventLoadSong(
                          s.library.lib[index].itemName!, const [], false))
                },
                // onPressed: () {},
                child: Align(
                  alignment: Alignment.centerLeft,
                  // child: state.currentSong == state.library[index].itemName ? Text(libReformatText(
                  //     state.library[index])): Text("CURRENT"),
                  child: LibraryItem(state, index),
                ),
                // style: FlutterFlowTheme.of(context).bodyText1.override(
                //       fontFamily: 'Poppins',
                //       fontSize: 16,
                //       fontWeight: FontWeight.normal,
                //     ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.05),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: state.currentSong == state.library.lib[index].itemName
                      ? Colors.red
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0.2),
                  child: Icon(
                    Icons.tv_outlined,
                    color: Colors.white,
                    size: state.currentSong == state.library.lib[index].itemName
                        ? 20
                        : 0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4, 5, 0, 0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: state.library.lib[index].inCache
                    ? Colors.green
                    : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, -0.3),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: state.library.lib[index].inCache ? 20 : 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text LibraryItem(LibraryState state, int index) {
    var s = state as LibraryLoaded;
    return Text(libReformatText(s.library.lib[index]),
        style: TextStyle(color: Colors.black));

    // return Text(libReformatText(state.library.lib[index]),
    //     style: TextStyle(backgroundColor: unCachedBColour));
  }

  String libReformatText(library) {
    String libName = library.itemName.replaceAll('.pro6', '').trim();
    var temp = libName.split('/');
    libName = temp[temp.length - 1];

    return libName;
  }
}
