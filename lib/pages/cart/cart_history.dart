import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/controllers/cart_controller.dart';
import 'package:foot_delivery/routes/routes_helper.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/app_icon.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:foot_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOder = Map();
    for(int i=0; i< getCartHistoryList.length; i++){
      if(cartItemsPerOder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOderToList(){
      return cartItemsPerOder.entries.map((e) => e.value).toList();
    }

    List<String> cartOderTimeToList(){
      return cartItemsPerOder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOder = cartItemsPerOderToList();

    var listCounter =0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length) {
        DateTime paseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
            getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(paseDate.toString());
        var outputFormat = DateFormat("dd-MM-yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          // App bar
          Container(
            color: AppColors.mainColor,
            height: Dimensison.size100,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensison.size45OP),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.home_outlined,),
                ),
                BigText(text: "Cart history", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: Dimensison.size10OP, left: Dimensison.size20OP, right: Dimensison.size20OP),
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                children: [
                  for(int i=0; i<itemsPerOder.length; i++)
                    Container(
                      height: Dimensison.size100,
                      margin: EdgeInsets.only(bottom: Dimensison.size20OP),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // BigText(text: getCartHistoryList[listCounter].time!),
                          timeWidget(listCounter),
                          SizedBox(height: Dimensison.size5OP,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image
                              Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(itemsPerOder[i], (index) {
                                  if(listCounter<getCartHistoryList.length){
                                    listCounter++;
                                  }
                                  return index<=2?Container(
                                    margin: EdgeInsets.only(right: Dimensison.size5OP),
                                    width: Dimensison.size60OP,
                                    height: Dimensison.size60OP,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensison.size10OP),
                                        image: DecorationImage(
                                            image: AssetImage(getCartHistoryList[listCounter-1].img!),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ):Container();
                                }),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(text: "Total"),
                                    BigText(text: itemsPerOder[i].toString()+" Items"),
                                    GestureDetector(
                                      onTap: (){
                                        var oderTime = cartOderTimeToList();
                                        Map<int, CartModel> moreOder={};
                                        for(int j=0; j<getCartHistoryList.length;j++){
                                          if(getCartHistoryList[j].time==oderTime[i]){
                                            moreOder.putIfAbsent(getCartHistoryList[j].id!, () => CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                          }
                                        }
                                        Get.find<CartController>().setItems = moreOder;
                                        Get.find<CartController>().addMoreOderToCartList();
                                        Get.toNamed(RoutesHelper.getCartPage());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensison.size5OP, vertical: Dimensison.size5OP/2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensison.size5OP),
                                          border: Border.all(width: 1, color: AppColors.mainColor)
                                        ),
                                        child: SmallText(text: "one more", color: AppColors.mainColor,),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
