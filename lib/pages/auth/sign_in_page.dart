import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/pages/auth/sign_up_page.dart';
import 'package:foot_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';
import '../../utils/dimensisons.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phonelController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: Dimensison.size20OP, right: Dimensison.size20OP),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensison.size50OP,),
              // image
              Center(
                child: Container(
                  width:Dimensison.size150OP,
                  child: Image(image: AssetImage("assets/images/food4.png"),),
                ),
              ),
              SizedBox(height: Dimensison.size35,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Hello",size: Dimensison.size50OP,),
                    BigText(text: "Sign into your account",size: Dimensison.size20,color: Colors.grey,),
                  ],
                ),
              ),
              SizedBox(height: Dimensison.size20OP,),
              // Email
              AppTextField(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.email_outlined),
              SizedBox(height: Dimensison.size20OP,),
              // Password
              AppTextField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  icon: Icons.lock_outline_rounded),
              SizedBox(height: Dimensison.size20OP,),
              Container(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:[
                      BigText(text: "Sign into your account",size: Dimensison.size20,color: Colors.grey,)
                ]),
              ),
              SizedBox(height: Dimensison.size45OP,),
              Center(
                child: Column(
                  children: [
                    // Sign in button
                    Container(
                      width: Dimensison.screenwidth/2,
                      height: Dimensison.screenHeight/13,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensison.size20OP)
                      ),
                      child: Center(child: BigText(text: "Sign in",color: Colors.white,size: Dimensison.size35,)),
                    ),
                    SizedBox(height: Dimensison.size45OP,),
                    Wrap(
                      children: [
                        SmallText(text: "Don't have an acount?", size: Dimensison.size20,),
                        SizedBox(width: Dimensison.size10OP,),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                                text: "Create",
                                style: TextStyle(
                                    color: Colors.blue[500],
                                    fontSize: Dimensison.size20OP
                                )
                            )),
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
