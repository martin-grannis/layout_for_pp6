//import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:pp6_layout/dialogs/controls/dialog_button1.dart';
import 'package:pp6_layout/dialogs/passwordForm.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/services/secure_storage_impl.dart';




// import 'package:web_socket_demo/myApp.dart';
// import 'package:web_socket_demo/pages/connected_home.dart';
//import 'package:web_socket_demo/dialogs/get_host_password_form.dart';

class get_host_dialog_widget extends StatefulWidget {
  final Host this_host;

  const get_host_dialog_widget({
    Key? key,
    required this.this_host,
  }) : super(key: key);

  //get this_host => this.this_host;

  // for state to get var via widget
  //Host get this_host => this_host;

  @override
  State<get_host_dialog_widget> createState() => _get_host_dialog_widgetState();
}

class _get_host_dialog_widgetState extends State<get_host_dialog_widget> {
  //with SingleTickerProviderStateMixin {
  final handle_secure_storage hss = handle_secure_storage();
  late TextEditingController textController;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // late final AnimationController _controller = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 1),
  // );

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        toolbarHeight: 35,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        //backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
            "${widget.this_host.name} ip:${widget.this_host.ip_address} ( ${widget.this_host.port}) ",
            //textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall),

        actions: [
          Container(
            child: Center(
              child: IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                icon: Icon(
                  Icons.close_rounded,
                  //color: FlutterFlowTheme.of(context).secondaryText,
                  size: 25,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.grey,
      ),
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                    child: DialogButton1(
                      title: "Connect",
                      onPressedCallBack: () {
                        print("connect pressed");
                        showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Stack(children: [
                        const IgnorePointer(
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize
                                .min, // makes dialog shrink to fit contents
                            children: [
                              SizedBox(height: 160),
                              Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                //elevation: 16,
                                child: PasswordForm(
                                    thisHost: widget.this_host),
                              ),
                            ],
                          ),
                        ),
                      ]);
                    });
                        },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                    child: DialogButton1(
                      title: "Forget",
                      onPressedCallBack: () => {print("forget pressed")},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                    child: DialogButton1(
                      title: "Set Default",
                      onPressedCallBack: () {
                        print("default pressed");
                        hss.setDefaultHost(widget.this_host);
                        final snackBar = SnackBar(
                          backgroundColor: Colors.green.shade700,
                          duration: Duration(seconds:2),
                          content:
                              Text("Default set", style: TextStyle(color: Colors.white)),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ),
                ]),
          ),
        ],
      ),
    ]);
  }
}
