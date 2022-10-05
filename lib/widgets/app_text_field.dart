import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/dimensisons.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  const AppTextField({Key? key, required this.textEditingController, required this.hintText, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: AppColors.iconColor1,),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensison.size15),
                borderSide: BorderSide(
                    width: 1.0,
                    color: AppColors.mainColor
                )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensison.size15),
            )
        ),
      ),
    );
  }
}
