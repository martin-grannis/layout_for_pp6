import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class looking_for_servers_bouncing extends StatelessWidget {
  const looking_for_servers_bouncing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: Stack(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Looking for servers..."),
          ),
          SizedBox(
            width:200,
            child: LoadingIndicator(
              indicatorType: Indicator
                  .ballTrianglePathColored,
              colors: [
                Colors.red,
                Colors.green,
                Colors.blue
              ],
              strokeWidth: 4.0,
              pathBackgroundColor:
                  Colors.black45,
            ),
          ),
        ]),
      );
  }
}
