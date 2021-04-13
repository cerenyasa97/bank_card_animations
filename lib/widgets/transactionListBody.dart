import 'package:flutter/material.dart';
import 'package:flutter_card_animation/constants.dart';
import 'package:flutter_card_animation/widgets/list_cards.dart';
import 'package:flutter_card_animation/widgets/title_card.dart';

class TransactionListBody extends StatelessWidget {

  final physic;

  const TransactionListBody({Key key, this.physic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(parent: physic),
      itemBuilder: (context, index) {
        return index == 0
            ? TitleCard()
            : ListCards(index: index);
      },
      itemCount: (BankAppConstant.transactionTitle.length + 1),
    );
  }
}
