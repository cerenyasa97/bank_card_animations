import 'package:flutter/material.dart';
import 'package:flutter_card_animation/widgets/bank_app_bar.dart';
import 'package:flutter_card_animation/widgets/card_description_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDescriptionPage extends StatefulWidget {
  final transitionAnimation;
  final int index;

 CardDescriptionPage({Key key, this.transitionAnimation, this.index}) : super(key: key);

  @override
  _CardDescriptionPageState createState() => _CardDescriptionPageState();
}

class _CardDescriptionPageState extends State<CardDescriptionPage> {
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: BankAppBar(flag: "desc"), preferredSize: Size.fromHeight(60),),
      body: CardDescriptionBody(transitionAnimation: widget.transitionAnimation, index: widget.index)
    );
  }
}
