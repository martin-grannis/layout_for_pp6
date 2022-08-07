import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/bits_and_pieces/colours.dart';
import 'package:pp6_layout/bits_and_pieces/settingsWidgetHeaderBar.dart';
import 'package:pp6_layout/blocs/PP6_connection/PP6_connection_bloc.dart';
import 'package:pp6_layout/dialogs/settings.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

class CustomAppBar2 extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar2({Key? key}) : super(key: key);

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: const AppBarContent(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarContent extends StatelessWidget {
  const AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            //color: Color.fromARGB(255, 99, 99, 99),
            color: MyColors.myRed,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 2),
                        child: Container(
                          width: 162,
                          height: 40,
                          decoration: BoxDecoration(
                            //  color: Color(0x00FFFFFF),
                            borderRadius: BorderRadius.circular(8),
                            //border: Border.all(
                            //width: 2,
                            color: Colors.white,
                            //),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 2),
                                child: Text(
                                  'MrB',
                                  textAlign: TextAlign.center,
                                  //textHeightBehavior: ,
                                  style: TextStyle(
                                    //color: Color(0xFFD94E08),
                                    color: MyColors.myBlue,

                                    fontSize: 25,
                                    fontWeight: FontWeight.normal,
                                    height: 1,
                                  ),
                                ),
                              ),
                              Text(
                                ' remote',
                                style: TextStyle(
                                  color: MyColors.myBlack,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(color: MyColors.myRed),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 20,
                                child: Column(
                                  //mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'connected to:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 8),
                                          child: Text(
                                            'Mac Server 2 (spare) on part 49442',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        // Column(
                                        //   mainAxisSize: MainAxisSize.min,
                                        //   children: [
                                        //     Padding(
                                        //       padding: EdgeInsetsDirectional
                                        //           .fromSTEB(15, 0, 0, 0),
                                        //       child: IconButton(
                                        //         icon: Icon(Icons.cancel, size: 24,),
                                        //         //Icons.cancel,
                                        //         color: Colors.white,
                                        //         onPressed: () {
                                        //           BlocProvider.of<
                                        //                       PP6_ConnectionBloc>(
                                        //                   context)
                                        //               .add(PP6_ConnectionStatusChanged(
                                        //                   PP6_ConnectionStatus
                                        //                       .disconnected,
                                        //                   Host.empty));
                                        //         },

                                        //         //size: 25,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.cancel, size: 30),
                          color: Colors.white,
                          onPressed: () async {
                            if (await confirm(
                                title: Text("DISCONNECTING"),
                                content: Text(
                                    "Are you sure you want to disconnect?"),
                                context)) {
                              return context.read<PP6_ConnectionBloc>().add(
                                  PP6_ConnectionStatusChanged(
                                      PP6_ConnectionStatus.disconnected,
                                      Host.empty));
                            }
                            return print('pressedCancel');
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: IconButton(
                            icon: Icon(Icons.settings_outlined, size: 30),
                            color: Colors.white,
                            onPressed: () async {
                              Size size = MediaQuery.of(context).size;
                              showDialog<void>(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    body: Center(
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 65, 30, 50),
                                            child: new Container(
                                              decoration: BoxDecoration(
                                                //color: Color.fromARGB(0, 255, 2, 2),
                                                //color: Color(0xFFD94E08),
                                                border: Border.all(
                                                  color: Color(0xFFD94E08),
                                                  width: 2,
                                                ),
                                              ),

                                              //height: 500,
                                              //width: MediaQuery.of(context).size.width*.4,
                                              width: 350,
                                              // color: Colors.white,
                                              child: new Column(
                                                children: <Widget>[
                                                  Settings(),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
