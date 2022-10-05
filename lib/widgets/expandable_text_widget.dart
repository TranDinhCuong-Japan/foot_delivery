import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {

  late String firstHalfText;
  late String secondHalfText;

  bool isHiddenText = true;

  double textHeight= Dimensison.size300OP;

  @override
  void initState() {
    super.initState();
    if(widget.text.length>textHeight){
      firstHalfText=widget.text.substring(0,textHeight.toInt());
      secondHalfText=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalfText=widget.text;
      secondHalfText='';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Dimensison.size10),
      child: secondHalfText.isEmpty?SmallText(text: firstHalfText, color: AppColors.paraColor,):Column(
        children: [
          SmallText(text: isHiddenText?(firstHalfText+"..."):(firstHalfText+secondHalfText), color: AppColors.paraColor,),
          InkWell(
            onTap: (){
              setState(() {
                isHiddenText=!isHiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: isHiddenText?('Show more'):('Show hidden'), color: AppColors.mainColor,),
                Icon(isHiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
