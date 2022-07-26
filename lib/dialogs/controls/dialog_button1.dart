import 'package:flutter/material.dart';



class DialogButton1 extends StatelessWidget {
  const DialogButton1({
    Key? key,
    required this.title,
    this.onPressedCallBack,
  }) : super(key: key);


  final String title;
  final onPressedCallBack;
  

  @override
  Widget build(BuildContext context) {
  final MediaQueryData sizeInfo = MediaQuery.of(context);  
    return ElevatedButton(
      onPressed: this.onPressedCallBack,
      child: Wrap(children: <Widget>[
        // Icon(
        //   Icons.login,
        //   size: 20,
        // ),
        // SizedBox(width: 10),
        Text(this.title)
      ]),
      //style: getButtonStyle1(sizeInfo.size.width, sizeInfo.size.height),
    );
  }
}

ButtonStyle getButtonStyle1(double width, double height) {
  late ButtonStyle bStyle1, finalStyle;
  bStyle1 = ElevatedButton.styleFrom(
    fixedSize: Size(width * .22, 40),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    primary: Color(0xFF2D3D4C),
    //padding:
    //EdgeInsets.symmetric(horizontal: 4, vertical: 3),
    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  );
  finalStyle =
      ButtonStyle(overlayColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      //if (states.contains(MaterialState.hovered))
      if (states.contains(MaterialState.pressed))
      {return Colors.redAccent;} //<-- SEE HERE

      return null; // Defer to the widget's default.
    },
  )).merge(bStyle1);
  return finalStyle;
}
