import 'package:flutter/material.dart';


class RightPanel extends StatefulWidget {
  const RightPanel({Key? key}) : super(key: key);

  @override
  State<RightPanel> createState() => _RightPanelState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class _RightPanelState extends State<RightPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //appBar: AppBar(title: Text("my layout app")),
      body: Container(color: Colors.green),
    );
  }
}
