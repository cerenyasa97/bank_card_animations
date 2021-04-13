import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_animation/constants.dart';
import 'package:flutter_card_animation/widgets/bank_app_sliding_up.dart';
import 'package:flutter_card_animation/widgets/bottom_cards.dart';
import 'package:flutter_card_animation/widgets/transactionListBody.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'back_cards.dart';
import 'bank_card.dart';
import 'top_widget.dart';

// ignore: must_be_immutable
class HomePageBody extends StatefulWidget {

  int index;    // When the done button in AppBar is clicked, the relevant card's index is used while directing to the card detail page.
  Function(int) onFinish; // Function for index changes
  Size size;    // Phone size

  HomePageBody({Key key, this.index, this.onFinish, this.size}) : super(key: key);@override

  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> with TickerProviderStateMixin {
  int index = 0;    // Function for index changes
  int bottomCardIndex = 0; // The index that holds the colors of the cards below
  int textIndex = 0;  // The text index is kept in a different variable so that it can show the information of the front card.
  int length;   // Card description length
  double y;   // Vertical coordinate of the card in front
  double listHeight;  // Vertical coordinate of the transaction List
  bool topWidgetEnable = true;  // Hides card information when viewing transaction information
  AnimationController animationController;  // Controls animations that allow the card below to slide up and rotate parallel to the z-axis
  AnimationController notResetAnimationController;  // Controls the animation as the new card arrives, allowing the cards on the back to slide backwards
  AnimationController notResetAnimationController2; // When the previous card information wants to be displayed, the card is swiped down and controls the animation that makes the back card come to the front
  AnimationController textAnimationController;  // Controls the animation that allows left column titles to shift from left to right and right column titles from right to left
  AnimationController slideAboveController;  // Controls the animations that allow the bottom cards to slide up and new cards to come from the bottom as the new card is displayed
  AnimationController reverseAnimationController; // Controls animations that perform in the opposite direction of the bottom-up card swipe flow
  Animation<double> slideUpAnimation; // Swipe up animation to display next card information
  Animation<double> slideDownAnimation; // Swipe down animation to display before card information
  Animation<double> transformAnimation; // Animation that makes the card parallel to the z-axis to display the next card information
  Animation<double> reverseTransformAnimation; // Animation that rotates the card to display previous card information
  Animation<double> moveBackAnimation; // Animation that slides the top back cards back when the next card is displayed
  Animation<double> moveFrontAnimation; // Animation that slides the top back cards front when the before card is displayed
  Animation<double> moveUpAnimation;  // Animation that swipes up the middle card below when viewing the next card
  Animation<double> moveDownAnimation;  // Animation that swipes down the middle card below when viewing the before card
  Animation<double> invisibleToVisibleAnimation;  // Animation that slides the bottom card up when viewing the next card
  Animation<double> visibleToInvisible; // Animation that slides the bottom card down when viewing the before card

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Initial values initialized
    length = BankAppConstant.cardLength - 1;
    y = ScreenUtil().setHeight(150);
    listHeight = widget.size.height;

    //Initialization of ticker and time to animation controllers
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    reverseAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    notResetAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    notResetAnimationController2 = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    slideAboveController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    textAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    // Adding listeners to the controllers to displayed the changes in animations on the screen and reload the page structure at each trigger
    animationController.addListener(() {setState(() {});});
    reverseAnimationController.addListener(() {setState(() {});});
    textAnimationController.addListener(() {setState(() {});});
    notResetAnimationController.addListener(() {setState(() {});});
    notResetAnimationController2.addListener(() {setState(() {});});
    slideAboveController.addListener(() {setState(() {});});

    // Defining the actions to be taken according to the state of the animations
    animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        animationController.reset();
        slideAboveController.reset();
        index < length ? index += 1 : index = 0;
        widget.onFinish(index);
      }
      if(status == AnimationStatus.forward){
        y = ScreenUtil().setHeight(150);
        listHeight = widget.size.height;
        topWidgetEnable = true;
        notResetAnimationController.repeat();
        textIndex < length ? textIndex += 1 : textIndex = 0;
        bottomCardIndex < length ? bottomCardIndex += 1 : bottomCardIndex = 0;
        textAnimationController.reset();
        textAnimationController.forward();
        reverseAnimationController.reset();
        notResetAnimationController2.reset();
      }
    });

    reverseAnimationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        reverseAnimationController.reset();
        index > 0 ? index -= 1 : index = 2;
        widget.onFinish(index);
      }
      if(status == AnimationStatus.forward){
        textIndex > 0 ? textIndex -= 1 : textIndex = length;
        bottomCardIndex > 0 ? bottomCardIndex -= 1 : bottomCardIndex = length;
        notResetAnimationController2.repeat();
        textAnimationController.reset();
        textAnimationController.forward();
        slideAboveController.reverse(from: ScreenUtil().setHeight(-66));
        animationController.reset();
        notResetAnimationController.reset();
        slideAboveController.reset();
      }
    });

    // When the application is run, the texts are displayed with animation.
    textAnimationController.forward();

    // Definition of the range of values​that animations will take in the time intervals given in the controllers and with which curve the value will be changed with Tween
    slideUpAnimation = Tween<double>(begin: ScreenUtil().setHeight(330), end: ScreenUtil().setHeight(150)).animate(CurvedAnimation(parent: animationController, curve: Curves.elasticOut));
    slideDownAnimation = Tween<double>(begin: ScreenUtil().setHeight(150), end: ScreenUtil().setHeight(330)).animate(CurvedAnimation(parent: reverseAnimationController, curve: Curves.easeOutCubic));

    transformAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: animationController, curve: Curves.elasticOut));
    reverseTransformAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: reverseAnimationController, curve: Curves.easeOutCirc));

    moveBackAnimation = Tween<double>(begin: ScreenUtil().setHeight(150), end: ScreenUtil().setHeight(165)).animate(CurvedAnimation(parent: notResetAnimationController, curve: Interval(0.2, 0.4, curve: Curves.bounceInOut)));
    moveFrontAnimation = Tween<double>(begin: ScreenUtil().setHeight(165), end: ScreenUtil().setHeight(150)).animate(CurvedAnimation(parent: notResetAnimationController2, curve: Interval(0.2, 0.4, curve: Curves.bounceInOut)));

    moveUpAnimation = Tween<double>(begin: ScreenUtil().setHeight(350), end: ScreenUtil().setHeight(330)).animate(CurvedAnimation(parent: slideAboveController, curve: Interval(0.25, 0.4, curve: Curves.bounceOut)));
    moveDownAnimation = Tween<double>(begin: ScreenUtil().setHeight(350), end: ScreenUtil().setHeight(370)).animate(CurvedAnimation(parent: reverseAnimationController, curve: Interval(0.25, 0.4, curve: Curves.bounceOut)));

    invisibleToVisibleAnimation = Tween<double>(begin: ScreenUtil().setHeight(-140), end: ScreenUtil().setHeight(-66)).animate(CurvedAnimation(parent: slideAboveController, curve: Curves.easeOutExpo));
    visibleToInvisible = Tween<double>(begin: ScreenUtil().setHeight(366), end: ScreenUtil().setHeight(500)).animate(CurvedAnimation(parent: reverseAnimationController, curve: Curves.easeOutExpo));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Widget showing card information
        topWidgetEnable ? TopWidget(
          index: textIndex,
          animationController: textAnimationController,
        ) : Container(),
        // Card widgets on the back at the top
        backCards(ScreenUtil().setWidth(50), notResetAnimationController2.status == AnimationStatus.forward ? moveFrontAnimation.value : moveBackAnimation.value + 12.5, BackCard(width: 280,)),
        topWidgetEnable ? backCards(notResetAnimationController2.status == AnimationStatus.forward ? ScreenUtil().setWidth(40) : ScreenUtil().setWidth(45), notResetAnimationController2.status == AnimationStatus.forward ?  moveFrontAnimation.value : moveBackAnimation.value, reverseAnimationController.status == AnimationStatus.forward ? BankCard(index: index != 0 ? index - 1 : length) : BackCard(
          width: 290,
        )) :  Container(),
        // Abstract card widgets at the bottom in an inclined position
        buildTransform(ScreenUtil().setWidth(49), (animationController.status == AnimationStatus.forward ? (ScreenUtil().setHeight(300) - invisibleToVisibleAnimation.value) : (visibleToInvisible.value)), BottomCards(index: bottomCardIndex > 0 ? bottomCardIndex - 1 : length,)),
        buildTransform(ScreenUtil().setWidth(49), animationController.status == AnimationStatus.forward ? moveUpAnimation.value + 24 : moveDownAnimation.value + 20, slideAboveController.status == AnimationStatus.dismissed ? Container() : BottomCards(
          index: index > 0 ? index -1 : length,
        )),
        buildTransform(animationController.status == AnimationStatus.forward ? ScreenUtil().setWidth(40) : ScreenUtil().setWidth(49), animationController.status == AnimationStatus.forward ? moveUpAnimation.value - 6 : moveDownAnimation.value, animationController.status == AnimationStatus.forward ? BankCard(index: index != 0 ? index - 1 : length) : BottomCards(
          index: bottomCardIndex < length ? bottomCardIndex + 1 : 0,
        ),),
        // Widget displaying the currently selected card
        frontCard(),
        // Widget displaying the next card
        bottomSlidingCard(),
        // Sliding panel widget sliding from the bottom of the page
        BankAppSlidingUpPanel(),
        // Widget showing transaction information by sliding from below
        slidingTransactionList(),
      ],
    );
  }

  // Abstract cards showing previous cards on top
  Transform backCards(double x, double y, Widget child) {
    return Transform.translate(
          offset: Offset(x, y),
      child: child,
      );
  }

  Padding slidingTransactionList() {
    return Padding(
        padding: EdgeInsets.only(
          top: listHeight >= ScreenUtil().setHeight(170) ? (listHeight <= widget.size.height ? listHeight : widget.size.height) : ScreenUtil().setHeight(170),
        ),
        child: Container(
          color: Colors.white,
          child: TransactionListBody(physic: AlwaysScrollableScrollPhysics(),),
        ),
      );
  }

  Transform bottomSlidingCard() {
    return Transform.translate(
        offset: Offset(ScreenUtil().setWidth(40), animationController.status == AnimationStatus.forward ? slideUpAnimation.value : moveDownAnimation.value - 30),
        child: transform(transformAnimation.value, Container(
            child: GestureDetector(
              onTap: (){
                debugPrint("active");
              },
                onVerticalDragUpdate: (moveEvent) {
                  if(moveEvent.delta.dy < 0 ){
                    animationController.forward();
                    notResetAnimationController.forward();
                    slideAboveController.forward();
                  }
                },
                child: reverseAnimationController.status == AnimationStatus.forward ? Container() : BankCard(
                  index: index + 1 <= length ? index + 1 : 0,
                ))))
      );
  }

  Padding frontCard() {
    return Padding(
       padding: EdgeInsets.only(
         top: reverseAnimationController.status == AnimationStatus.forward ? slideDownAnimation.value : (y >= ScreenUtil().setHeight(10)) ? (y <= ScreenUtil().setHeight(150) ? y : ScreenUtil().setHeight(150)) : ScreenUtil().setHeight(10),
         left: ScreenUtil().setWidth(40),
       ),
          child: GestureDetector(
          onVerticalDragUpdate: (moveEvent){
            setState(() {
              y += moveEvent.delta.dy;
              listHeight += moveEvent.delta.dy * 4;
              y < ScreenUtil().setHeight(140) ? topWidgetEnable = false : topWidgetEnable = true;
            });
            if(moveEvent.delta.dy > 0 && y > ScreenUtil().setHeight(180)){
              y = ScreenUtil().setHeight(150);
              listHeight = widget.size.height;
              reverseAnimationController.forward();
              notResetAnimationController2.forward();
              notResetAnimationController.reverse(from: ScreenUtil().setHeight(165));
            }
          },
          child: transform(reverseAnimationController.value, BankCard(index: index,))
        )
      );
  }

  Transform buildTransform(var x, var y, Widget child, [double scale = 1]) {
    return Transform.translate(
        offset: Offset(x, y),
        child: transform(scale, child),
      );
  }

  Transform transform(double scale, Widget child) {
    return Transform(
          transform: Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0.002,
            0, 0, 0, 1,
          )
            ..rotateX(-0.75 * scale)
            ..rotateY(0.0)
            ..rotateZ(0.0),
          alignment: FractionalOffset.center,
          child: child
      );
  }
}
