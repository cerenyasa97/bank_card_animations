import 'package:flutter/material.dart';
import 'package:flutter_card_animation/core/general_text.dart';
import 'package:flutter_card_animation/screens/card_description_page.dart';

class BankAppBar extends StatelessWidget {
  
  final String flag;
  final int index;

  const BankAppBar({Key key, this.flag, this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          flag == "home" ? TextButton(child: GeneralText(text: "Done", color: Colors.indigo.shade600, size: MediaQuery.of(context).size.width * 0.042, fontWeight: FontWeight.bold),
    onPressed: (){
            Navigator.of(context).push(
                PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondAnimation){
                      return CardDescriptionPage(transitionAnimation: animation, index: index);
                    }
                )
            );
          },) : IconButton(icon: Icon(Icons.widgets_outlined, color:  Colors.indigo.shade600,), onPressed: (){}),
          SizedBox(width: MediaQuery.of(context).size.width / 12,),
          GeneralText(text: "Bank Cards App", color: Colors.black87, fontWeight: FontWeight.bold, size: MediaQuery.of(context).size.width * 0.0607,),
        ],
      ),
      actions: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Icon(Icons.add_circle_outline_rounded, color: Colors.indigo.shade600, size: MediaQuery.of(context).size.width * 0.085,),),
      ],
    );
  }
}
