import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BankAppSlidingUpPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: MediaQuery.of(context).size.height * 0.09,
      color: const Color(0xff474545),
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50), topLeft: Radius.circular(50)),
      panelSnapping: true,
      panel: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 17),
        child: Text(
          "Statictics",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "Mulish"),
        ),
      ),
    );
  }
}
