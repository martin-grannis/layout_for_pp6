//import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import 'package:pp6_layout/bits_and_pieces/form_custom_appbar.dart';

import 'package:pp6_layout/dialogs/controls/dialog_button1.dart';
import 'package:pp6_layout/dialogs/passwordForm.dart';

import 'package:pp6_layout/models/host.dart';

import 'package:pp6_layout/services/secure_storage_impl.dart';

// import 'package:web_socket_demo/myApp.dart';
// import 'package:web_socket_demo/pages/connected_home.dart';
//import 'package:web_socket_demo/dialogs/get_host_password_form.dart';
class GetHostDialogForm extends StatefulWidget {
  const GetHostDialogForm({Key? key, required this.thisHost}) : super(key: key);
  final Host thisHost;

  @override
  State<GetHostDialogForm> createState() => _GetHostDialogFormState();
}

class _GetHostDialogFormState extends State<GetHostDialogForm> {
  final _formKey = GlobalKey<FormState>();
  final handle_secure_storage hss = handle_secure_storage();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: size.width * .25,
              child: FormCustomAppBar("Host connection", 35),
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        //elevation: 16,
                                        child: PasswordForm(
                                            thisHost: widget.thisHost),
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            });
                      })),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: DialogButton1(
                    title: "Forget",
                    onPressedCallBack: () {
                      print("forget pressed");
                      hss.forgetPassword(widget.thisHost);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.blue.shade700,
                          duration: Duration(seconds: 2),
                          content: Text("Password forgotten set",
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                    }),
              ),
              DialogButton1(
                  title: "Set Default",
                  onPressedCallBack: () {
                    print("default pressed");
                    hss.setDefaultHost(widget.thisHost);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.blue.shade700,
                          duration: Duration(seconds: 2),
                          content: Text("Set as Default",
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                  }),
            ]),
          ]),
    );
  }
}
