import 'package:flutter/material.dart';
import 'package:pp6_layout/bits_and_pieces/settingsWidgetHeaderBar.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: double.maxFinite,
      color: Colors.white,
        child: Column(
      children: [
        SettingsWidgetHeaderBar(),
        Container(color: Colors.red, child: Text("asdfasdfasdfasdf")),
        Container(color: Colors.red, child: Text("asdfasdfasdfasdf")),
        Container(color: Colors.red, child: Text("asdfasdfasdfasdf")),
        Container(color: Colors.red, child: Text("asdfasdfasdfasdf")),
        Container(color: Colors.red, child: Text("asdfasdfasdfasdf")),
      ],
    ));
  }
}
