import 'package:flutter/material.dart';

class FormCustomAppBar extends StatelessWidget {
 
  final String title;
  FormCustomAppBar(
    this.title) : super(key: GlobalKey<FormState>());
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = (mediaQuery.size.height - mediaQuery.padding.top) * .1;
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
              color: Color.fromARGB(255, 219, 219, 219),
              width: 1,
              ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      //  color: Colors.blue,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            color: Color.fromARGB(255, 96, 96, 96),
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
