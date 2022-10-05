import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/app_icon.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:foot_delivery/widgets/icon_and_text_widget.dart';

import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        title: Center(child: BigText(text: "Profile", color: Colors.white,size: Dimensison.size30,)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensison.size50OP),
            child: Column(
              children: [
                // Profile icon
                AppIcon(icon: Icons.person, backgoundColor: AppColors.mainColor,size: Dimensison.size150OP,iconSize: Dimensison.size100,iconColor: Colors.white,),
                SizedBox(height: Dimensison.size20OP,),
                // Name
                AccountWidget(
                    icon: AppIcon(icon: Icons.person, backgoundColor: AppColors.mainColor,size: Dimensison.size50OP,iconSize: Dimensison.size20OP,iconColor: Colors.white,),
                    text: BigText(text: "text")
                ),
                SizedBox(height: Dimensison.size20OP,),
                // Phone
                AccountWidget(
                    icon: AppIcon(icon: Icons.phone, backgoundColor: AppColors.iconColor1,size: Dimensison.size50OP,iconSize: Dimensison.size20OP,iconColor: Colors.white,),
                    text: BigText(text: "text")
                ),
                SizedBox(height: Dimensison.size20OP,),
                // Email
                AccountWidget(
                    icon: AppIcon(icon: Icons.email_outlined, backgoundColor: AppColors.iconColor2,size: Dimensison.size50OP,iconSize: Dimensison.size20OP,iconColor: Colors.white,),
                    text: BigText(text: "text")
                ),
                SizedBox(height: Dimensison.size20OP,),
                // Address
                AccountWidget(
                    icon: AppIcon(icon: Icons.location_on, backgoundColor: AppColors.mainColor,size: Dimensison.size50OP,iconSize: Dimensison.size20OP,iconColor: Colors.white,),
                    text: BigText(text: "text")
                ),
                SizedBox(height: Dimensison.size20OP,),
                // Message
                AccountWidget(
                    icon: AppIcon(icon: Icons.message_outlined, backgoundColor: AppColors.iconColor1,size: Dimensison.size50OP,iconSize: Dimensison.size20OP,iconColor: Colors.white,),
                    text: BigText(text: "text")
                ),
                SizedBox(height: Dimensison.size20OP,),
                // Logout
                AccountWidget(
                    icon: AppIcon(icon: Icons.logout_outlined, backgoundColor: AppColors.iconColor2,size: Dimensison.size50OP,iconSize: Dimensison.size20OP,iconColor: Colors.white,),
                    text: BigText(text: "text")
                ),
              ],
            ),
          ),
      ),
    );
  }
}
