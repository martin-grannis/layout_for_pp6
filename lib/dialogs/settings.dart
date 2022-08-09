import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pp6_layout/bits_and_pieces/settingsWidgetHeaderBar.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences prefs;
  Color pickerColor = Color(0xff443a49);
  int _cachedSongColor = 0;
  int _currentSongColor = 0;
  int _disconnectIconColor = 0;
  bool _lockedSplit = true;
  double _splitPoint = 40;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPrefs();
  }

  Future<void> loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _cachedSongColor = prefs.getInt('_cachedSongColor') ?? 0xFF76FF03;
    _currentSongColor = prefs.getInt('_currentSongColor') ?? 0xff33691e;
    _disconnectIconColor = prefs.getInt('_disconnectIconColor') ?? 0xff93291e;
    _lockedSplit = prefs.getBool('_lockedSplit') ?? true;
    _splitPoint = prefs.getDouble('_splitPoint') ?? 40;
    setState(() {});
  }

  // this.cachedSongColor = prefs.getInt('cachedSongColor') ?? 0xff443a49;
  // this.currentSongColor = prefs.getInt('currentSongColor') ?? 0xff33691e;

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: double.maxFinite,
        color: Colors.white,
        child: Column(
          children: [
            SettingsWidgetHeaderBar(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'Cached song color',
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: GestureDetector(
                            onTap: () {
                              var savedColor = _cachedSongColor;
                              showColorDialog(context, _cachedSongColor,
                                      update_cachedSongColor)
                                  .then((exit) {
                                if (exit) {
                                  savePrefInt(
                                      "_cachedSongColor", _cachedSongColor);
                                } else {
                                  setState(() => _cachedSongColor = savedColor);
                                }
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                //color: Color(0xFF56875D),
                                color: Color(_cachedSongColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'Current song color',
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: GestureDetector(
                            onTap: () {
                              var savedColor = _currentSongColor;
                              showColorDialog(context, _currentSongColor,
                                      update_currentSongColor)
                                  .then((exit) {
                                if (exit) {
                                  savePrefInt(
                                      "_cachedSongColor", _currentSongColor);
                                } else {
                                  setState(
                                      () => _currentSongColor = savedColor);
                                }
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                //color: Color(0xFF56875D),
                                color: Color(_currentSongColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'Disconnect icon color',
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                          child: GestureDetector(
                            onTap: () {
                              var savedColor = _disconnectIconColor;
                              showColorDialog(context, _disconnectIconColor,
                                      update_disconnectIconColor)
                                  .then((exit) {
                                if (exit) {
                                  savePrefInt("_disconnectIconColor",
                                      _disconnectIconColor);
                                } else {
                                  setState(
                                      () => _disconnectIconColor = savedColor);
                                }
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                //color: Color(0xFF56875D),
                                color: Color(_disconnectIconColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'Locked split?',
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                      child: Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: BlocBuilder<LayoutBloc, LayoutState>(
                          builder: (context, state) {
                            return Checkbox(
                              value: state.lockedSplit,
                              onChanged: (val) {
                                setState(() => _lockedSplit = val!);
                                var lb = BlocProvider.of<LayoutBloc>(context);
                                context.read<LayoutBloc>().add(LockSplitPoint(
                                    //splitPoint: this._controller.areas[0].weight!));
                                    lockedSplit: val == 1));
                                this.prefs.setBool("_lockedSplit", val!);
                              },
                            );
                          },
                        ),
                      )),
                ),
              ],
            ),

            // Visibility(
            //   visible: _lockedSplit,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Expanded(
            //         flex: 5,
            //         child: Padding(
            //           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.max,
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children: const [
            //               Text(
            //                 'Split point',
            //                 textAlign: TextAlign.start,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       // Expanded(
            //       //   flex: 2,
            //       //   child: Padding(
            //       //       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            //       //       child: Align(
            //       //         alignment: AlignmentDirectional(-1, 0),
            //       //         child: Slider.adaptive(
            //       //           max: 100,
            //       //           min: 0,
            //       //           value: _splitPoint,
            //       //           onChanged: (val) {
            //       //             setState(() => _splitPoint = val);
            //       //             this.prefs.setDouble("_splitPoint", val);
            //       //           },
            //       //         ),
            //       //       )),
            //       // ),
            //     ],
            //   ),
            // )
          ],
        ));
  }

  void update_cachedSongColor(int? value) {
    setState(() {
      _cachedSongColor = value!;
    });
  }

  void update_currentSongColor(int? value) {
    setState(() {
      _currentSongColor = value!;
    });
  }

  void update_disconnectIconColor(int? value) {
    setState(() {
      _disconnectIconColor = value!;
    });
  }

  Future<dynamic> showColorDialog(BuildContext context, int initialColor,
      [void Function(int? value)? update_callback]) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                // title: Text('Wanna Exit?'),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, false), // passing false
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, true), // passing true
                    child: Text('OK'),
                  ),
                ],
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: Color(initialColor),
                    onColorChanged: (color) {
                      update_callback!(color.value);
                    },
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: true,
                    displayThumbColor: true,
                    labelTypes: [],
                    paletteType: PaletteType.hsl,
                  ),
                ),
              ));
        });
  }

  void savePrefInt(String key, int value) {
    this.prefs.setInt(key, value);
  }
}
