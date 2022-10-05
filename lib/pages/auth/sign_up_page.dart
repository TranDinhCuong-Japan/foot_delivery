import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/models/sign_up_body.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/app_icon.dart';
import 'package:foot_delivery/widgets/app_text_field.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phonelController = TextEditingController();

    void _registration(){
      var email = emailController.text.trim();
      var pass = passwordController.text.trim();
      var name = nameController.text.trim();
      var phone = phonelController.text.trim();

      if(email.isEmpty) {
        showCustomSnackBar("Enter your email", title: "Email empty");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Enter email style", title: "Email style");
      }else if(pass.isEmpty) {
        showCustomSnackBar("Enter password", title: "Pass empty");
      }else if(pass.length<6){
        showCustomSnackBar("password is too short", title: "Password length");
      }else if(name.isEmpty){
        showCustomSnackBar("Enter your name", title: "Name empty");
      }else if(phone.isEmpty){
        showCustomSnackBar("Enter your phone number", title: "phone empty");
      }else{
        showCustomSnackBar("Succsess!", title: "Ok");
        SignUpBody signUpBody = SignUpBody(name: name, email: email, passWord: pass, phone: phone);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: Dimensison.size20OP, right: Dimensison.size20OP),
          child: Column(
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
              // Name
              AppTextField(
                  textEditingController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensison.size20OP,),
              // Phone
              AppTextField(
                  textEditingController: phonelController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensison.size20OP,),
              // Signup button
              GestureDetector(
                onTap: (){
                  _registration();
                },
                child: Container(
                  width: Dimensison.screenwidth/2,
                  height: Dimensison.screenHeight/13,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensison.size20OP)
                  ),
                  child: Center(child: BigText(text: "Sign up",color: Colors.white,size: Dimensison.size35,)),
                ),
              ),
              SizedBox(height: Dimensison.size10OP,),
              RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Have an account already?",
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: Dimensison.size20OP
                    )
                  )),
              SizedBox(height: Dimensison.size20OP,),
              RichText(
                  text: TextSpan(
                      text: "Sign up using one of the following methods",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensison.size16
                      )
                  )),
              SizedBox(height: Dimensison.size10OP,),
              Wrap(
                children: [
                  AppIcon(icon: Icons.facebook,size: Dimensison.size50OP,iconSize: Dimensison.size45OP,iconColor: Colors.blue,),
                  SizedBox(width: Dimensison.size20OP,),
                  AppIcon(icon: Icons.g_mobiledata_outlined,size: Dimensison.size50OP,iconSize: Dimensison.size45OP,iconColor: Colors.red,),
                ],
              )

            ],
          ),
        ),
      ),
    );

  }

}
