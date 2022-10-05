import 'package:flutter/material.dart';
import 'package:foot_delivery/controllers/cart_controller.dart';
import 'package:foot_delivery/controllers/popular_product_controller.dart';
import 'package:foot_delivery/controllers/recommended_product_controller.dart';
import 'package:foot_delivery/pages/cart/cart_page.dart';
import 'package:foot_delivery/pages/food/popular_food_detail.dart';
import 'package:foot_delivery/pages/food/recommended_food_detail.dart';
import 'package:foot_delivery/pages/home/main_food_page.dart';
import 'package:foot_delivery/pages/splash/splash_screen.dart';
import 'package:foot_delivery/routes/routes_helper.dart';
import 'package:get/get.dart';

import '../helper/denpendencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(FootDelivery());
}

class FootDelivery extends StatelessWidget {
  const FootDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // home: SplashScreen(),
            initialRoute: RoutesHelper.getSplash(),
            getPages: RoutesHelper.routes,
          );
        });
      });
  }
}
