import 'package:flutter/material.dart';
import 'package:flutter_card_animation/core/general_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class TopWidget extends StatefulWidget {
  final int index;
  final AnimationController animationController;

  TopWidget({Key key, @required this.index, @required this.animationController})
      : super(key: key);

  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {

  Animation leftAnimation;
  Animation rightAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leftAnimation = Tween<double>(begin: ScreenUtil().setWidth(400), end: ScreenUtil().setWidth(-30)).animate(
        CurvedAnimation(parent: widget.animationController, curve: Interval(0.8, 1, curve: Curves.elasticOut)));
    rightAnimation = Tween<double>(begin: ScreenUtil().setWidth(600), end: ScreenUtil().setWidth(240)).animate(
        CurvedAnimation(parent: widget.animationController, curve: Interval(0.8, 1, curve: Curves.elasticOut)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(ScreenUtil().setWidth(10) - leftAnimation.value, ScreenUtil().setHeight(25)), // 20 -> 50
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GeneralText(text: widget.index != -1 ? BankAppConstant.budget[widget.index] : "0,000", color: Colors.black87, size: 25, fontWeight: FontWeight.bold,),
                    SizedBox(
                      width: 5,
                    ),
                    GeneralText(text: "USD", color: const Color(0xff62688e), size: 12, fontWeight: FontWeight.bold,)
                  ],
                ),
                GeneralText(text: "BALANCE", color: const Color(0xff62688e), size: 12, fontWeight: FontWeight.bold,),
                SizedBox(
                  height: 30,
                ),
                GeneralText(text: widget.index != -1 ? BankAppConstant.cardHolder[widget.index] : "XXXX XXXX", color: Colors.black87, size: 25, fontWeight: FontWeight.bold,),
                GeneralText(text: "CARD HOLDER", color: const Color(0xff62688e), size: 12, fontWeight: FontWeight.bold,),
              ],
            ),
          ]),
        ),
        Transform.translate(
          offset: Offset(rightAnimation.value, ScreenUtil().setHeight(25)), // 600 -> 230
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralText(text: widget.index != -1 ? BankAppConstant.expiresDate[widget.index] : "XX/XX", color: Colors.black87, size: 25, fontWeight: FontWeight.bold,),
                GeneralText(text: "EXPIRES", color: const Color(0xff62688e), size: 12, fontWeight: FontWeight.bold,),
                SizedBox(height: 30,),
                GeneralText(text: widget.index != -1 ? BankAppConstant.cvc[widget.index] : "000", color: Colors.black87, size: 25, fontWeight: FontWeight.bold,),
                GeneralText(text: "CVC", color: const Color(0xff62688e), size: 12, fontWeight: FontWeight.bold,),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
