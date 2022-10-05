import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/controllers/popular_product_controller.dart';
import 'package:foot_delivery/controllers/recommended_product_controller.dart';
import 'package:foot_delivery/models/products_model.dart';
import 'package:foot_delivery/pages/food/popular_food_detail.dart';
import 'package:foot_delivery/routes/routes_helper.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:foot_delivery/utils/dimensisons.dart';
import 'package:foot_delivery/widgets/app_column.dart';
import 'package:foot_delivery/widgets/big_text.dart';
import 'package:foot_delivery/widgets/icon_and_text_widget.dart';
import 'package:foot_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height= Dimensison.size250;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider image
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
            height: Dimensison.size350,
            child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),
          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        // Dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: Dimensison.size30,),
        // Recommended text
        Padding(
          padding: EdgeInsets.only(left: Dimensison.size30),
          child: Row(
            children: [
              BigText(text: 'Recommended',),
              SizedBox(width: Dimensison.size10,),
              SmallText(text: '・ Food pairing')
            ],
          ),
        ),
        // Listview recommended
        GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
            return recommendedProducts.isLoaded?ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProducts.recommendedProductList.length,
                itemBuilder:(context, index){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesHelper.getRecommendedFood(index, "home"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensison.size20,right: Dimensison.size20,bottom: Dimensison.size10),
                      child: Row(
                        children: [
                          // Popular Image
                          Container(
                            height: Dimensison.size120,
                            width: Dimensison.size120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensison.size20),
                                image: DecorationImage(
                                    image: AssetImage(recommendedProducts.recommendedProductList[index].img),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          // Popular text
                          Expanded(
                            child: Container(
                              height: Dimensison.size100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensison.size20),
                                  bottomRight: Radius.circular(Dimensison.size20),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensison.size10,right: Dimensison.size5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: recommendedProducts.recommendedProductList[index].name),
                                    SizedBox(height: Dimensison.size10,),
                                    SmallText(text: 'Món rau củ quả'),
                                    SizedBox(height: Dimensison.size10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(icon: Icons.circle_sharp, text: 'Normal', iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(icon: Icons.location_on, text: '1.7km', iconColor: AppColors.mainColor),
                                        IconAndTextWidget(icon: Icons.access_time_rounded, text: '32min', iconColor: AppColors.iconColor2)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }):CircularProgressIndicator(color: AppColors.mainColor,);
          }),
    ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {

    Matrix4 matrix4 = new Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans= _height*(1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index==_currPageValue.floor()+1){
      var currScale =_scaleFactor +(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans= _height*(1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index==_currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans= _height*(1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale =0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-currScale)/2, 0);
    }

    return Transform(
      transform: matrix4,
      child: GestureDetector(
        onTap: (){
          Get.toNamed(RoutesHelper.getPopularFood(index, "home"));
        },
        child: Stack(
          children: [
              Container(
                height: Dimensison.size250,
                margin: EdgeInsets.only(left: Dimensison.size5, right: Dimensison.size5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensison.size30),
                    color: index.isEven ? AppColors.mainColor : AppColors.yellowColor,
                    image: DecorationImage(
                        image: AssetImage(popularProduct.img!),
                        fit: BoxFit.cover)
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensison.size130,
                margin: EdgeInsets.only(left: Dimensison.size30, right: Dimensison.size30, bottom: Dimensison.size30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensison.size30), color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: Dimensison.size5,
                      offset: Offset(0,5)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5,0)
                    )
                  ]
                ),
                child: Container(
                  padding: EdgeInsets.only(top:Dimensison.size20,left: Dimensison.size15, right: Dimensison.size15,),
                  child: AppColumn(text: popularProduct.name!,stars: popularProduct.stars!),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
