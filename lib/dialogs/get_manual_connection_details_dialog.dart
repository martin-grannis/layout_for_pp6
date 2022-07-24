//import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/bits_and_pieces/form_custom_appbar.dart';
import 'package:pp6_layout/blocs/PP6_connection/PP6_connection_bloc.dart';
import 'package:pp6_layout/blocs/library/library_bloc.dart';
import 'package:pp6_layout/dialogs/controls/dialog_button1.dart';
import 'package:pp6_layout/dialogs/passwordForm.dart';
import 'package:pp6_layout/forms/validator_extension.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';
import 'package:pp6_layout/services/secure_storage_impl.dart';

// import 'package:web_socket_demo/myApp.dart';
// import 'package:web_socket_demo/pages/connected_home.dart';
//import 'package:web_socket_demo/dialogs/get_host_password_form.dart';

class get_manual_connection_details_dialog extends StatefulWidget {
  const get_manual_connection_details_dialog({
    Key? key,
  }) : super(key: key);

  //get this_host => this.this_host;

  // for state to get var via widget
  //Host get this_host => this_host;

  @override
  State<get_manual_connection_details_dialog> createState() =>
      _get_manual_connection_details_dialogState();
}

class _get_manual_connection_details_dialogState
    extends State<get_manual_connection_details_dialog> {
  //with SingleTickerProviderStateMixin {
  //final handle_secure_storage hss = handle_secure_storage();
  String ipAddress = "";
  String portN = "";
  String serverPW = "";
  bool _isTryingConnection = false;
  late TextEditingController textController;
  //late bool passwordVisibility;
  //final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String? _errorMsg = "";

  // late final AnimationController _controller = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 1),
  // );

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    //passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: size.width *.25,
              child: FormCustomAppBar("Manual connection details"),
            ),
            _isTryingConnection
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: _errorMsg!.isNotEmpty,
                                    child: Text(_errorMsg!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.red)),
                                  )
                                ]),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 10, 0),
                                    child: SizedBox(
                                        width: 200,
                                        child: _IPaddress_Field(
                                            context, ipAddress)),
                                  ),
                                ]),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 10, 0),
                                    child: SizedBox(
                                        width: 200,
                                        child:
                                            _portNumberField(context, portN)),
                                  ),
                                ]),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 10, 0),
                                    child: SizedBox(
                                        width: 200,
                                        child:
                                            _passwordField(context, serverPW)),
                                  ),
                                ]),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 10, 0),
                                    child: SizedBox(
                                      width: 200,
                                      child: SubmitButton(),
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
          ]),
    );
  }

  TextFormField _IPaddress_Field(BuildContext context, String field) {
    //final TextEditingController textController = TextEditingController();
    return TextFormField(
      initialValue: "192.168.1.109",
      //controller: textController,
      onSaved: (String? value) {
        ipAddress = value!;
        //field = value!;
        //Host thisHost =
        //Host("name", ipAddre//ss, "iuy", false, "password", false);
        //    _authenticateOnServer(thisHost, value!, parentContext),
      },
      decoration: InputDecoration(
        labelText: 'IP address',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        enabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      //initialValue: '192.168.1.45',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (_) {
        ipAddress = textController.text;
        setState(() {
          _errorMsg = "";
        });
      },
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(
      //     RegExp(r"(((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])[.]){3}((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])$"),
      //   )
      // ],
      validator: (val) {
        if (!val!.isValidIP) {
          return 'Please Enter xx.xx.xx.xxx stryle ip address';
        }
        // if (_errorMsg != "") {
        //   return (_errorMsg);
        // }

        return null;
      },
    );
  }

  TextFormField _portNumberField(BuildContext context, String field) {
    return TextFormField(
      initialValue: "49442",
      onSaved: (String? value) {
        portN = value!;
      },
      decoration: InputDecoration(
        labelText: 'port Number',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        enabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      //initialValue: '192.168.1.45',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //onSaved: (value) =>
      //    _authenticateOnServer(thisHost, value!, parentContext),
      onChanged: (_) {
        setState(() {
          _errorMsg = "";
        });
      },
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(
      //     RegExp(r"(((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])[.]){3}((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])$"),
      //   )
      // ],
      validator: (val) {
        if (!val!.isNotNumeric) {
          return 'Please enter port number';
        }
        // if (_errorMsg != "") {
        //   return (_errorMsg);
        // }

        return null;
      },
    );
  }

  TextFormField _passwordField(BuildContext context, String field) {
    return TextFormField(
      initialValue: "sunshine",
      onSaved: (String? value) {
        serverPW = value!;
        Host hostDetails =
            Host("name", ipAddress, portN, false, serverPW, false);

        _authenticateOnServer(hostDetails, value, context);
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Server password',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        enabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      //initialValue: '192.168.1.45',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //onSaved: (value) =>
      //    _authenticateOnServer(thisHost, value!, parentContext),
      onChanged: (_) {
        setState(() {
          _errorMsg = "";
        });
      },
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(
      //     RegExp(r"(((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])[.]){3}((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])$"),
      //   )
      // ],
      validator: (val) {
        if (!val!.isValidPassword) {
          return 'Please enter server password';
        }
        // if (_errorMsg != "") {
        //   return (_errorMsg);
        // }

        return null;
      },
    );
  }

  ElevatedButton SubmitButton() {
    return ElevatedButton(
        onPressed: () {
          //var res = _formKey.currentState!.validate();
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            //print("form saved");

            //_formKey.currentState!.s
            //   // use the email provided here
          }
        },
        child: const Text("Connect"));
  }

  Future<void> _authenticateOnServer(
      Host h, String password, parentContext) async {
// clear any message
    // setState(() {
    //   _errorMsg = "";
    // });

    // final formState = _formKey.currentState;
    // if (!formState!.validate()) return;

    // //formState.save();
    setState(() {
      _isTryingConnection = true;
    });

    try {
      //await RepositoryProvider.of<ConnectionRepository>(context)
      //    .logIn(host: h, hostPassword: password);

      var mbp = BlocProvider.of<PP6_ConnectionBloc>(context);
      //await BlocProvider.of<PP6_ConnectionBloc>(context);
      await mbp.connectionRepositoryInstance
          .logIn(host: h, hostPassword: password);
      // _connectionRepository.logIn(host: h, hostPassword: password);

      Navigator.pop(context);
      Navigator.pop(parentContext);

// somehow update the connectionrepository status to donnected
      context.read<LibraryBloc>().add(ResetLibraryToInitial());
      Host tempName = Host(
          h.ip_address, h.ip_address, h.port, h.known, h.password, h.favourite);
      context.read<PP6_ConnectionBloc>().add(PP6_ConnectionStatusChanged(
          PP6_ConnectionStatus.connected, tempName));

      // Future.delayed(const Duration(seconds: 2));
      // if (true) throw ("wrong password guv");
    } catch (e) {
      setState(() {
        _isTryingConnection = false;
        _errorMsg = "Can't connect with those details";
      });
    }
  }
}
