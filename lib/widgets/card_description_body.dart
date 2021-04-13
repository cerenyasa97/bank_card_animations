import 'package:flutter/material.dart';
import 'package:flutter_card_animation/widgets/bank_card.dart';
import 'package:flutter_card_animation/widgets/transactionListBody.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDescriptionBody extends StatefulWidget {

  final transitionAnimation;
  final int index;

  const CardDescriptionBody({Key key, this.transitionAnimation, this.index}) : super(key: key);

  @override
  _CardDescriptionBodyState createState() => _CardDescriptionBodyState();
}

class _CardDescriptionBodyState extends State<CardDescriptionBody> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;
  Animation<double> slideAnimation2;
  Animation<double> clipAnimation;
  ScrollPhysics physic;
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: ScreenUtil().setHeight(170), end: ScreenUtil().setHeight(40)).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    slideAnimation2 = Tween<double>(begin: 0.3, end: 0.15).animate(controller);
    clipAnimation = Tween<double>(begin: 1, end: 0.6).animate(flag ? CurvedAnimation(parent: controller, curve: Curves.bounceOut) : controller);
    controller.addListener(() {setState(() {});});
    physic = NeverScrollableScrollPhysics();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
            animation: widget.transitionAnimation,
            child: GestureDetector(
              onVerticalDragUpdate: (event){
                if(event.delta.dy > 0){
                  if(animation.value == ScreenUtil().setHeight(40)){
                    controller.reverse(from: ScreenUtil().setHeight(40));
                    physic = NeverScrollableScrollPhysics();
                  }
                  else{
                    Navigator.pop(context);
                    flag = false;
                  }
                }
              },
              child: ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: clipAnimation.value,
                  child: BankCard(index: widget.index,),
                ),
              )
            ),
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                    begin: Offset(0.004, 1), end: Offset(0.004, 0.05))
                    .animate(flag ? CurvedAnimation(parent: widget.transitionAnimation, curve: Curves.bounceOut) : widget.transitionAnimation),
                child: child,
              );
            }),
        AnimatedBuilder(
            animation: widget.transitionAnimation,
            child: GestureDetector(
              onVerticalDragUpdate: (event){
                if(event.delta.dy < 0){
                  controller.forward();
                  physic = AlwaysScrollableScrollPhysics();
                }
              },
              child: TransactionListBody(physic: physic),
            ),
            builder: (context, child) {
              return SlideTransition(
                position:
                Tween<Offset>(begin: Offset(0, 1), end: Offset(0, slideAnimation2.value))
                    .animate(widget.transitionAnimation),
                child: child,
              );
            }),
      ],
    );
  }
}
