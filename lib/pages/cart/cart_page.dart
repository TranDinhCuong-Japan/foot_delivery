import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/controllers/cart_controller.dart';
import 'package:foot_delivery/controllers/recommended_product_controller.dart';
import 'package:foot_delivery/routes/routes_helper.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:foot_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../utils/dimensisons.dart';
import '../../widgets/app_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Icon
          Positioned(
            top: Dimensison.size50OP,
            right: Dimensison.size20,
            left: Dimensison.size20,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RoutesHelper.initial);
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios, backgoundColor: AppColors.mainColor,iconColor: Colors.white,)),
                  SizedBox(width: Dimensison.size30,),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RoutesHelper.initial);
                      },
                      child: AppIcon(icon: Icons.home_outlined, backgoundColor: AppColors.mainColor,iconColor: Colors.white,)),
                  GetBuilder<CartController>(builder: (controller){
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.to(()=>CartPage());
                            },
                            child: AppIcon(icon: Icons.shopping_cart, backgoundColor: AppColors.mainColor,iconColor: Colors.white,)),
                        controller.totalQuantity>=1?
                        Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(icon: Icons.circle, backgoundColor: Colors.red, iconColor: Colors.transparent,size: Dimensison.size20,))
                            :Container(),
                        controller.totalQuantity>=1?
                        Positioned(
                            right: Dimensison.size2OP,
                            top: Dimensison.size2OP,
                            child: BigText(text: controller.totalQuantity.toString(),size: Dimensison.size10OP,color: Colors.white,))
                            :Container(),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          Positioned(
              top: Dimensison.size50OP*2,
              right: Dimensison.size20,
              left: Dimensison.size20,
              bottom: 0,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    return cartController.totalQuantity>0?
                        Container(
                      child: ListView.builder(
                          itemCount: cartController.listCartItems.length,
                          itemBuilder: (_,index){
                            return Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.only(bottom: Dimensison.size10OP),
                              child: Row(
                                children: [
                                  // image
                                  GestureDetector(
                                    onTap: (){
                                      var popularProductIndex = Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(cartController.listCartItems[index].product);
                                      if(popularProductIndex>=0){
                                        Get.toNamed(RoutesHelper.getPopularFood(popularProductIndex, "popular"));
                                      }else{
                                        var recommendedProductIndex = Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(cartController.listCartItems[index].product);
                                        if(recommendedProductIndex<0){
                                          Get.snackbar("History product", "Can't view item to History product", backgroundColor: Colors.red, colorText: Colors.white);
                                        }else{
                                          Get.toNamed(RoutesHelper.getRecommendedFood(recommendedProductIndex,"recommended"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimensison.size100,
                                      height: Dimensison.size100,
                                      decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(Dimensison.size20OP),
                                          image: DecorationImage(
                                              image: AssetImage(cartController.listCartItems[index].img!),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                  ),
                                  // Detail
                                  Expanded(
                                    child: Container(
                                      height: Dimensison.size80OP,
                                      padding: EdgeInsets.only(left: Dimensison.size10OP),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.listCartItems[index].name!),
                                          SmallText(text: "Quán phở"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  child: BigText(text: "\$${cartController.listCartItems[index].price!}")),
                                              Container(
                                                width: Dimensison.size80OP,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(cartController.listCartItems[index].product!, -1);
                                                        },
                                                        child: AppIcon(icon: Icons.remove, backgoundColor: AppColors.mainColor, iconColor: Colors.white,size: Dimensison.size20OP,)),
                                                    BigText(text: cartController.listCartItems[index].quantity!.toString()),
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(cartController.listCartItems[index].product!, 1);
                                                        },
                                                        child: AppIcon(icon: Icons.add, backgoundColor: AppColors.mainColor, iconColor: Colors.white,size: Dimensison.size20OP,))
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                        :Container(
                      child: Center(child: SmallText(text: "Cart is empty!",)),
                    );
                  }
                ),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return cartController.listCartItems.length>0?Container(
            height: Dimensison.size80OP,
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensison.size10OP), topLeft: Radius.circular(Dimensison.size10OP))
            ),
            child: Padding(
              padding: EdgeInsets.only(left: Dimensison.size20OP, right: Dimensison.size20OP),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        SmallText(text: "Total: ",),
                        BigText(text: cartController.totalAmount.toString()),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(Dimensison.size10OP),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(Dimensison.size10OP)
                    ),
                    child: GestureDetector(
                        onTap: (){
                          cartController.addToHistory();
                          Get.toNamed(RoutesHelper.getHistoryPage());
                        },
                        child: BigText(text: "Check out",color: Colors.white,)),
                  )
                ],
              ),
            ),
          ):Container(height: Dimensison.size80OP,
                decoration: BoxDecoration(
                color: Colors.white,
            ),);
        }
      ),
    );
  }
}
