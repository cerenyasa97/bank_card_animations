import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class BottomCards extends StatelessWidget {

  final int index;

  const BottomCards({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(BankAppConstant.bottomCardImages[index]);
  }
}
