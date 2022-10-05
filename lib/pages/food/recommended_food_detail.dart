import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/controllers/recommended_product_controller.dart';
import 'package:foot_delivery/routes/routes_helper.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/widgets/app_icon.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:foot_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../utils/dimensisons.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedProduct = Get.find<RecommendedProductController>().recommendedProductList[pageId];

    Get.find<PopularProductController>().initPopularProducts(recommendedProduct,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          //Sliver app bar
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensison.size80OP,
            // Icon
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page=="recommended") {
                      Get.toNamed(RoutesHelper.getCartPage());
                    }else{
                      Get.toNamed(RoutesHelper.initial);
                    }
                  },
                    child: AppIcon(icon: Icons.close)),
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
                          :Positioned(child: Container(),),
                      controller.totalItems>=1?
                      Positioned(
                          right: Dimensison.size2OP,
                          top: Dimensison.size2OP,
                          child: BigText(text: controller.totalItems.toString(),size: Dimensison.size10OP,color: Colors.white,))
                          :Positioned(child: Container(),),
                    ],
                  );
                })
              ],
            ),
            // FoodName text
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensison.size20OP),
              child: Container(
                padding: EdgeInsets.only(top: Dimensison.size5,bottom: Dimensison.size10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensison.size20OP),
                    topLeft: Radius.circular(Dimensison.size20OP)
                  )
                ),
                child: Center(child: BigText(text:recommendedProduct.name,size: Dimensison.size25OP,))
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: Dimensison.size300OP,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(recommendedProduct.img, width: double.maxFinite,fit: BoxFit.cover,),
            ),
          ),
          // Detail
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text:recommendedProduct.description),
                  margin: EdgeInsets.only(left: Dimensison.size20,right: Dimensison.size20,bottom: Dimensison.size10),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Number
            Container(
              padding: EdgeInsets.only(left: Dimensison.size20OP*2.5,  right:Dimensison.size20OP*2.5,top: Dimensison.size10,bottom: Dimensison.size10 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(icon: Icons.remove, backgoundColor: AppColors.mainColor,iconColor: Colors.white,)),
                  BigText(text: "\$"+"${recommendedProduct.price}" + " x "+ controller.inCartItems.toString()),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child: AppIcon(icon: Icons.add,backgoundColor: AppColors.mainColor,iconColor: Colors.white,)),
                ],
              ),
            ),
            // Add to cart
            Container(
              height:Dimensison.size80OP,
              padding: EdgeInsets.only(left: Dimensison.size30,right: Dimensison.size30),
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
                    child: Icon(Icons.favorite,color: AppColors.mainColor,),
                  ),
                  // Add cart Button
                  GestureDetector(
                    onTap: (){
                      controller.addItem(recommendedProduct);
                    },
                    child: Container(
                        padding: EdgeInsets.all(Dimensison.size20),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimensison.size20)
                        ),
                        child: BigText(text: '\$${recommendedProduct.price} | Add to cart',color: Colors.white,)
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },),
    );
  }
}
