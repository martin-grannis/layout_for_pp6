//import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/bits_and_pieces/form_custom_appbar.dart';
import 'package:pp6_layout/blocs/PP6_connection/PP6_connection_bloc.dart';
import 'package:pp6_layout/blocs/library/library_bloc.dart';
import 'package:pp6_layout/forms/formFieldContainer_mb.dart';
import 'package:pp6_layout/forms/validator_extension.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

// import 'package:web_socket_demo/myApp.dart';
// import 'package:web_socket_demo/pages/connected_home.dart';
//import 'package:web_socket_demo/dialogs/get_host_password_form.dart';
class PasswordForm extends StatefulWidget {
  PasswordForm({Key? key, required this.thisHost}) : super(key: key);
  final Host thisHost;

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
// Form field field vars

  String serverPW = "";
  bool savedTicked = false;

  // other vars
  bool _isTryingConnection = false;

  final _formKey = GlobalKey<FormState>();
  String? _errorMsg = "";

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
              child: FormCustomAppBar("Password", 35),
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
                          FormFieldContainer_mb(
                            child: _passwordField(context, widget.thisHost),
                          ),
                          FormFieldContainer_mb(
                            child: _rememberMe_Field(),
                          ),
                          FormFieldContainer_mb(
                            child: SubmitButton(),
                          ),
                        ],
                      ),
                    ],
                  ),
          ]),
    );
  }

  CheckboxListTile _rememberMe_Field() {
    return CheckboxListTile(
      title: Text("Save"),
      value: savedTicked,
      onChanged: (newValue) {
        setState(() {
          savedTicked = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  TextFormField _passwordField(BuildContext context, Host hostDetails) {
    return TextFormField(
      initialValue: "sunshine",
      onSaved: (String? value) {
        serverPW = value!;
        _authenticateOnServerKnown(hostDetails, value, context);
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

  Future<void> _authenticateOnServerKnown(
      Host h, String password, parentContext) async {
    var mbp = BlocProvider.of<PP6_ConnectionBloc>(context);

    Host tempName =
        Host(h.name, h.ip_address, h.port, h.known, password, h.favourite);

    if (savedTicked) {
      try {
        // TODO Update remembered servers
        //await mbp.connectionRepositoryInstance.hostNameSave(tempName);
        await mbp.connectionRepositoryInstance.UpdateKnownHostPassword(tempName);
      } catch (e) {}
      ;
    }
    setState(() {
      _isTryingConnection = true;
    });

    try {
      await mbp.connectionRepositoryInstance
          .logIn(host: h, hostPassword: password);

      Navigator.pop(context);
      Navigator.pop(parentContext);

      context.read<LibraryBloc>().add(ResetLibraryToInitial());
      context.read<PP6_ConnectionBloc>().add(PP6_ConnectionStatusChanged(
          PP6_ConnectionStatus.connected, tempName));
    } catch (e) {
      setState(() {
        _isTryingConnection = false;
        _errorMsg = "Can't connect with those details";
      });
    }
  }
}
