import 'package:flutter/material.dart';

class GeneralText extends StatelessWidget {

  final String text;
  final double size;
  final String family;
  final FontWeight fontWeight;
  final Color color;

  const GeneralText({Key key, @required this.text, this.size, this.family, this.fontWeight, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Text(
      text,
      style: TextStyle(
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: (size ?? 23) * _textScaleFactor,
          fontFamily: family ?? "Mulish"),
    );
  }
}
