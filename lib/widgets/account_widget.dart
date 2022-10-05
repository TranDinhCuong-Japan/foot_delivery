import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/app_icon.dart';

import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon icon;
  BigText text;

  AccountWidget({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensison.size20OP, top: Dimensison.size10OP, bottom: Dimensison.size10OP),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              offset: Offset(0,2),
              color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: Dimensison.size20OP,),
          text
        ],
      ),
    );
  }
}
