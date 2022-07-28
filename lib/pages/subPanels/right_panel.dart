//import 'package:connection_repository/connection_repository.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/presentation/presentation_bloc.dart';


class RightPanel extends StatefulWidget {
  const RightPanel({Key? key}) : super(key: key);

  @override
  _rightPanelState createState() => _rightPanelState();
}

class _rightPanelState extends State<RightPanel> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String prevColour = "";
  List<bool> isSelected = [true, false];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //backgroundColor: Colors.pink,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: BlocBuilder<PresentationBloc, PresentationState>(
                  builder: (context, state) {
                    if (state is PresentationInitialState ||
                        state is PresentationLoadingState) {
                      //return Center(child: CircularProgressIndicator());
                      return Scaffold(); // blank screen while unloaded
                    } else {
                      var w = MediaQuery.of(context).size.width;
                      var h = MediaQuery.of(context).size.height;

//                      print("mq: width= ${w}, height= ${h}, ratio= ${w / h} ");

                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            //flex:1,
                            child: GridView.builder(
                              padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              primary: false,

                              // fake
                              //itemCount: state.currentPresentation.presentationSlideGroups.length,
                              itemCount: state.currentPresentation.slideCount,
                              // itemCount: state.library.length > 0
                              //     ? state.library.length
                              //     : 0,
                              itemBuilder: (BuildContext context, int index) =>
                                  PresentationItem(state, index),
                              //itemBuilder: (BuildContext context, int index) => Image.memory(state.currentPresentation.LinearSlideArray[index]
                              //.SlideImageUsable),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          // MediaQuery.of(context).orientation ==
                                          //         Orientation.landscape
                                          //     ? 3
                                          //     : 2,
                                          (MediaQuery.of(context).size.width /
                                                  500)
                                              .round(),
                                      crossAxisSpacing: 14,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1.6
                                      // childAspectRatio: (MediaQuery.of(context)
                                      //         .size
                                      //         .width) /
                                      //     (MediaQuery.of(context).size.height) *2.5
                                      ),
                            ),
                          ),
                          // Expanded(
                          //   child: ListView.builder(
                          //       padding: EdgeInsets.zero,
                          //       scrollDirection: Axis.vertical,
                          //       primary: false,
                          //       // fake
                          //       //itemCount: state.currentPresentation.presentationSlideGroups.length,
                          //       itemCount: state.currentPresentation.slideCount,
                          //       // itemCount: state.library.length > 0
                          //       //     ? state.library.length
                          //       //     : 0,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return PresentationItem(state, index);
                          //       }),
                          // ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector PresentationItem(PresentationState state, int index) {
    return GestureDetector(
      onTap: () => {
        context.read<PresentationBloc>().add(PresentationEventShowSong(
            state.currentPresentation.presentationName, index)),
        
        // TODO 
        // context.read<LibraryBloc>().add(LibraryCurrentlyShowingChanged(
        //     currentSongPath: state.currentPresentation.presentationName)),
      },
      child: Container(
        //height: 230,
        //width: 430,
        decoration: BoxDecoration(
            border: Border.all(
          width: 6,
          color: getGroupColour(
              state.currentPresentation.LinearSlideArray[index].groupColour,
              index,
              false),
        )),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              //fit: BoxFit.fitWidth,
              fit: BoxFit.fitHeight,
              image: state
                  .currentPresentation.LinearSlideArray[index].SlideImageUsable,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    color: getGroupColour(
                        state.currentPresentation.LinearSlideArray[index]
                            .groupColour,
                        index,
                        true),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        formatTextForBottomRight(
                            "${state.currentPresentation.LinearSlideArray[index].groupName}",
                            index),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],

                // children: [
                //   Text(
                //       "${index + 1}. ${state.currentPresentation.LinearSlideArray[index].groupName}",
                //       style: TextStyle(
                //           color: Colors.white,
                //           backgroundColor: getGroupColour(
                //               state.currentPresentation.LinearSlideArray[index]
                //                   .groupColour,
                //               index))),
                // ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getGroupColour(groupColour, index, bool faded) {
// convert rgb string "0 0 1 1" type to Color

    if (index > 0 && groupColour == '') {
      groupColour = this.prevColour;
    } else {
      this.prevColour = groupColour;
    }

    var tmp = groupColour.split(' ');

    double red = double.parse(tmp[0]) * 255;
    double green = double.parse(tmp[1]) * 255;
    double blue = double.parse(tmp[2]) * 255;
    double alpha = double.parse(tmp[3]) * 255;

    if (faded) alpha = alpha / 2;

    return Color.fromARGB(
        alpha.round(), red.round(), green.round(), blue.round());
  }

  String formatTextForBottomRight(String s, int index) {
    if (s == "" || s == "Group") {
      return "${index + 1}.";
    } else {
      return "${index + 1}. ${s}";
    }
  }
}
