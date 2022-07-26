import 'package:flutter/material.dart';

class FormFieldContainer_mb extends StatelessWidget {
  final Widget child;

  const FormFieldContainer_mb({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 8),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
              child: SizedBox(
                width: 200,
                //child: SubmitButton(),
                child: child,
              ),
            ),
          ]),
    );
  }
}
