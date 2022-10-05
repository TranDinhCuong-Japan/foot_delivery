import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/widgets/small_text.dart';

import '../utils/app_color.dart';
import '../utils/dimensisons.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double stars;
  final double size;
  const AppColumn({Key? key, required this.text,this.stars=5.0, this.size=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text
        BigText(text: text, size: size,),
        SizedBox(height: Dimensison.size5,),
        // Recomment
        Row(
          children: [
            Wrap(children: List.generate(stars.toInt(), (index) => Icon(Icons.star,color: AppColors.mainColor,size: Dimensison.size15,))),
            SizedBox(width: Dimensison.size5,),
            SmallText(text: stars.toString()),
            SizedBox(width: Dimensison.size5,),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensison.size5OP),
              child: SmallText(text: '.'),
            ),
            SizedBox(width: Dimensison.size5,),
            SmallText(text: '123 Comments'),
          ],
        ),
        SizedBox(height: Dimensison.size5,),
        // Icon and Text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp, text: 'Normal', iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on, text: '1.7km', iconColor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded, text: '32min', iconColor: AppColors.iconColor2)
          ],
        ),
      ],
    );
  }
}
