import 'package:flutter/material.dart';
import 'package:flutter_card_animation/core/general_text.dart';
class CardType extends StatelessWidget {

  final String type;

  const CardType({Key key,@required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: type == "master" ? 18 : 20,
        top: type == "master" ? 20 : 18,
        child: type == "master" ? Container(
          width: 50,
          child: Stack(
            children: [
              masterCardCircle(),
              Positioned(
                child: masterCardCircle(),
                right: 10,
              ),
            ],
          ),
        ) : GeneralText(text: "VISA", color: Colors.white, fontWeight: FontWeight.bold, size: 30,),
    );
  }

  Container masterCardCircle() {
    return Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0x87ffffff),
              ),
            );
  }
}
