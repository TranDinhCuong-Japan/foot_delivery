import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/pages/home/food_page_body.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:foot_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    // print("current hight is "+MediaQuery.of(context).size.height.toString());
    // print("current hight is "+MediaQuery.of(context).size.width.toString());
    return RefreshIndicator(
        child: Column(
          children: [
            // header
            Container(
              child: Container(
                margin: EdgeInsets.only(top: Dimensison.size40,bottom: Dimensison.size10),
                padding: EdgeInsets.only(left: Dimensison.size10,right: Dimensison.size10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text
                      Column(
                        children: [
                          BigText(text: "Bangladesh",color: AppColors.mainColor,),
                          Row(
                            children: [
                              SmallText(text: 'Narshingdi',color: AppColors.mainBackColor,),
                              Icon(Icons.arrow_drop_down_rounded)
                            ],
                          )
                        ],
                      ),
                      // search icon
                      Container(
                        width: Dimensison.size45,
                        height: Dimensison.size45,
                        child: Icon(Icons.search, color: Colors.white),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensison.size15),
                          color: AppColors.mainColor,
                        ),
                      )
                    ]
                ),
              ),
            ),
            SizedBox(height: Dimensison.size10,),
            // Body
            Expanded(child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
          ],
        ),
        onRefresh: _loadResource);
  }
}
