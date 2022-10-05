import 'package:foot_delivery/pages/cart/cart_history.dart';
import 'package:foot_delivery/pages/cart/cart_page.dart';
import 'package:foot_delivery/pages/food/popular_food_detail.dart';
import 'package:foot_delivery/pages/food/recommended_food_detail.dart';
import 'package:foot_delivery/pages/home/main_food_page.dart';
import 'package:foot_delivery/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';

class RoutesHelper{
  static const String splash="/splash-screen";
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";
  static const String historyPage="/history-page";

  static String getInitial()=>"$initial";
  static String getSplash()=>"$splash";
  static String getPopularFood(int pageId, String page)=>"$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page)=>"$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage()=>"$cartPage";
  static String getHistoryPage()=>"$historyPage";

  static List<GetPage> routes =[
    GetPage(name: splash, page: ()=>SplashScreen()),

    GetPage(name: initial, page: ()=>HomePage()),

    GetPage(name: popularFood, page: (){
      var pageId =Get.parameters["pageId"];
      var page =Get.parameters["page"];
      return PopularFoodDetail(pageId: int.parse(pageId!), page:page!);
      },transition: Transition.fadeIn),

    GetPage(name: recommendedFood, page: (){
      var pageId= Get.parameters["pageId"];
      var page= Get.parameters["page"];
      return RecommendedFoodDetail(pageId: int.parse(pageId!),page: page!);
    }, transition: Transition.fadeIn),
    
    GetPage(name: cartPage, page: ()=>CartPage(),
    transition: Transition.fadeIn),
    GetPage(name: historyPage, page: ()=>CartHistory(),
    transition: Transition.fadeIn)
  ];
}