import 'package:flutter/material.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError=true,String title="Error"}){
  Get.snackbar(title, message,
    titleText: BigText(text: title, color: Colors.white,),
    messageText: Text(message,style: TextStyle(color: Colors.white),),
    colorText: Colors.white,
    backgroundColor: Colors.pinkAccent,
    snackPosition: SnackPosition.TOP
  );
}