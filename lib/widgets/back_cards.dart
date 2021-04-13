import 'package:flutter/material.dart';

class BackCard extends StatelessWidget {

  final double width;

  const BackCard({Key key, @required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: width,
      height: 170.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(37.0),
        color: const Color(0xffefefef),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }
}
