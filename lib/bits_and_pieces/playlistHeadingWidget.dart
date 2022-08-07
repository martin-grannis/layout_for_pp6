import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistHeadingWidget extends StatelessWidget {
  const PlaylistHeadingWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 0, 10),
      child: Row(
         
          //textBaseline: TextBaseline.alphabetic,
          children: [
            Spacer(flex:3),
            Expanded(
              flex:21,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,150,0),
                child: Container(
                  //width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                        bottom: BorderSide(
                      color: Color(0xFFEF0D0D),
                      width: 2,
                    )),
                  ),
                  child: Baseline(
                    baseline: 22,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      text,
                      textAlign: TextAlign.start,
                      
                    ),
                  ),
                ),
              ),
            ),
          Spacer(flex:5)
          ]),
    );
  }
}
