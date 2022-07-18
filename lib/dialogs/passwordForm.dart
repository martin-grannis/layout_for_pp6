import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/PP6_connection/PP6_connection_bloc.dart';
import 'package:pp6_layout/forms/validator_extension.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';
import 'package:pp6_layout/services/secure_storage_impl.dart';


class PasswordForm extends StatefulWidget {
  PasswordForm({Key? key, required this.thisHost}) : super(key: key);
  final Host thisHost;

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final handle_secure_storage hss = handle_secure_storage();
  String? _errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Password for ${widget.thisHost.name}?')],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                child: Builder(builder: (context1) {
                  return _Password_Field(widget.thisHost, context);
                }),
              ),
              SubmitButton(widget.thisHost),
            ],
          ),
        ),
      ]),
    );
  }

  ElevatedButton SubmitButton(Host host) {
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
        child: const Text("Submit"));
  }

  TextFormField _Password_Field(Host thisHost, BuildContext parentContext) {
    return TextFormField(
      initialValue: 'sunshine',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) =>
          _authenticateOnServer(thisHost, value!, parentContext),
      onChanged: (_) {
        setState(() {
          _errorMsg = "";
        });
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r"[a-zA-Z]+|\s"),
        )
      ],
      validator: (val) {
        if (!val!.isValidPassword) {
          return 'Please Enter something';
        }
        if (_errorMsg != "") {
          return (_errorMsg);
        }

        return null;
      },
    );
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

    try {
      await RepositoryProvider.of<ConnectionRepository>(context)
          .logIn(host: h, hostPassword: password);

      Navigator.pop(context);
      Navigator.pop(parentContext);

// somehow update the connectionrepository status to donnected
      context
          .read<PP6_ConnectionBloc>()
          .add(PP6_ConnectionStatusChanged(PP6_ConnectionStatus.connected, h));

      // Future.delayed(const Duration(seconds: 2));
      // if (true) throw ("wrong password guv");
    } catch (e) {
      setState(() {
        _errorMsg = "Wrong flippin password innit!";
      });
    }
  }
}
