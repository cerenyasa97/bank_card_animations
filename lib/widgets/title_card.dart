import 'package:flutter/material.dart';
import 'package:flutter_card_animation/core/general_text.dart';

class TitleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: GeneralText(
          text:  "Transactions",
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )
    );
  }
}
