import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/controllers/cart_controller.dart';
import 'package:foot_delivery/controllers/popular_product_controller.dart';
import 'package:foot_delivery/routes/routes_helper.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/app_column.dart';
import 'package:foot_delivery/widgets/app_icon.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:foot_delivery/widgets/expandable_text_widget.dart';
import 'package:foot_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../widgets/icon_and_text_widget.dart';
import '../cart/cart_page.dart';
import '../home/main_food_page.dart';

class PopularFoodDetail extends StatelessWidget {
 final int pageId;
 final String page;
 const PopularFoodDetail({Key? key,required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>().initPopularProducts(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          children: [
            // Image
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                 width: double.maxFinite,
                  height: Dimensison.size350OP,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(product.img),
                      fit: BoxFit.cover
                    )
                  ),
                )
            ),
            // Icon
            Positioned(
                top: Dimensison.size50OP,
                right: Dimensison.size20,
                left: Dimensison.size20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(page=="popular") {
                          Get.toNamed(RoutesHelper.getCartPage());
                        }else{
                          Get.toNamed(RoutesHelper.getInitial());
                        }
                      },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    GetBuilder<PopularProductController>(builder: (controller){
                      return Stack(
                        children: [
                          GestureDetector(
                              onTap: (){
                                Get.toNamed(RoutesHelper.getCartPage());
                              },
                              child: AppIcon(icon: Icons.shopping_cart)),
                          controller.totalItems>=1?
                          Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(icon: Icons.circle, backgoundColor: AppColors.mainColor, iconColor: Colors.transparent,size: Dimensison.size20,))
                              :Container(),
                          controller.totalItems>=1?
                          Positioned(
                              right: Dimensison.size2OP,
                              top: Dimensison.size2OP,
                              child: BigText(text: controller.totalItems.toString(),size: Dimensison.size10OP,color: Colors.white,))
                              :Container(),
                        ],
                      );
                    })
              ],
            )),
            // Text
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensison.size350OP-Dimensison.size20OP,
                child: Container(
                padding: EdgeInsets.only(left: Dimensison.size10, top: Dimensison.size20,right: Dimensison.size10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensison.size20OP),topLeft: Radius.circular(Dimensison.size20OP))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name,size: Dimensison.size25OP,stars: 5.0,),
                      SizedBox(height: Dimensison.size20,),
                      BigText(text: 'Introduce',size: Dimensison.size15OP,),
                      SizedBox(height: Dimensison.size5,),
                      Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(text:product.description)),
                      ),
                    ],
                  ),
            )),
          ],
        ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProducts) {
          return Container(
            height:Dimensison.size80OP,
            padding: EdgeInsets.only(left: Dimensison.size20,right: Dimensison.size20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensison.size30),
                topRight: Radius.circular(Dimensison.size30)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Number
                Container(
                  padding: EdgeInsets.all(Dimensison.size20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensison.size20)
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            popularProducts.setQuantity(false);
                          },
                          child: Icon(Icons.remove,color: AppColors.signColor,)),
                      SizedBox(width: Dimensison.size10,),
                      BigText(text: popularProducts.inCartItems.toString()),
                      SizedBox(width: Dimensison.size10,),
                      GestureDetector(
                          onTap: (){
                            popularProducts.setQuantity(true);
                          },
                          child: Icon(Icons.add,color: AppColors.signColor,)),
                    ],
                  ),
                ),
                // Add cart Button
                Container(
                  padding: EdgeInsets.all(Dimensison.size20),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensison.size20)
                  ),
                  child: GestureDetector(
                      onTap: (){
                      popularProducts.addItem(product);
                      },
                      child: BigText(text: '\$${product.price} | Add to cart',color: Colors.white,))
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
