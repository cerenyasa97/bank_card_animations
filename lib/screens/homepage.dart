import 'package:flutter/material.dart';
import 'package:flutter_card_animation/widgets/bank_app_bar.dart';
import 'package:flutter_card_animation/widgets/homepage_body.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(child: BankAppBar(flag: "home", index: index), preferredSize: Size.fromHeight(60),),
      body: HomePageBody(index: index, size: size, onFinish: (index) {
          setState(() {
            this.index = index;
          });
      }),
    );
  }
}
