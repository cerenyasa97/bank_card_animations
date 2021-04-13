import 'package:flutter/material.dart';
import 'package:flutter_card_animation/core/general_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';
import 'card_type.dart';

class BankCard extends StatelessWidget {

  final int index;

  const BankCard({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SvgPicture.asset(BankAppConstant.cardImages[index], semanticsLabel: "card$index",),
          Positioned(
            child: GeneralText(
              text: BankAppConstant.cardNumber[index],
              size: 16,
              fontWeight: FontWeight.w700,
            ),
            top: 90,
            left: 25,
          ),
          Positioned(
            child: GeneralText(
              text: "\$" + BankAppConstant.budget[index],
              size: 35,
              fontWeight: FontWeight.bold,
            ),
            top: 120,
            left: 25,
          ),
          CardType(type: "master"),
        ],
      ),
    );
  }
}
