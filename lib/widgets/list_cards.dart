import 'package:flutter/material.dart';
import 'package:flutter_card_animation/core/general_text.dart';

import '../constants.dart';

class ListCards extends StatelessWidget {

  final int index;

  const ListCards({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: index == (BankAppConstant.transactionImages.length + 1 ) ? 20 :5), child: Card(
      child: ListTile(
        leading: Image.asset("assets/images/" + BankAppConstant.transactionImages[index - 1] + ".png"),
        title: GeneralText(
          text: BankAppConstant.transactionTitle[index - 1],
          size: 20,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        subtitle: GeneralText(
          text: BankAppConstant.transactionDescription[index - 1].toString() + " Transactions",
          size: 18,
          color: Colors.blueGrey,
        ),
        trailing: GeneralText(
          text: "\$${BankAppConstant.transactionExpenditure[index - 1].toString()}",
          size: 22,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    ),);
  }
}
