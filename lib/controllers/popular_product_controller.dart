import 'package:flutter/material.dart';
import 'package:foot_delivery/controllers/cart_controller.dart';
import 'package:foot_delivery/data/repository/popular_product_repo.dart';
import 'package:foot_delivery/utils/app_color.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';

class PopularProductController extends GetxController{
 final PopularProductRepo popularProductRepo;

 PopularProductController({required this.popularProductRepo});

 late CartController _cart;

 List<dynamic> _popularProductList =[];
 List<dynamic> get popularProductList => _popularProductList;

 bool _isLoaded = false;
 bool get isLoaded => _isLoaded;

 int _quantity=0;
 int _inCartItems=0;

 int get quantity=>_quantity;
 int get inCartItems=>_inCartItems+_quantity;


 // Get Popular products
 Future<void> getPopularProductList() async{
   Response response = await popularProductRepo.getPopularProductList();
   if(response.statusCode==200){
     _isLoaded=true;
     print("data lost");
     _popularProductList=[];
     _popularProductList.addAll(Product.fromJson(response.body).products);
     update();
   }else{
     print("that bai: "+ response.statusText.toString());
   }
 }

 // Set quantity popular product
 void setQuantity(bool isQuantity){
   if(isQuantity){
     _quantity=checkQuantity(_quantity+1);
   }else{
     _quantity=checkQuantity(_quantity-1);
   }
   update();
 }

 // check quantity popular product <1 & >20
 int checkQuantity(int quantity){
   if((_inCartItems+quantity)<0){
     Get.snackbar("Item count", "You can't reduce more !",backgroundColor: AppColors.mainColor, colorText: Colors.white);
     if(_inCartItems>0){
       _quantity=-_inCartItems;
       return _quantity;
     }
    return 0;
   }else if((_inCartItems+quantity)>20){
     Get.snackbar("Item count", "You can't add more !",backgroundColor: AppColors.mainColor, colorText: Colors.white);
     if(_inCartItems>0){
       _quantity=-_inCartItems+20;
       return _quantity;
     }
     return  20;
   }else{
    return quantity;
   }
 }

 // run init
 void initPopularProducts(ProductModel product,CartController cart){
   _quantity=0;
   _inCartItems=0;
   _cart =cart;
   var exist= false;
   exist = _cart.existInCart(product);
   if(exist){
     _inCartItems=_cart.getQuantity(product);
   }
 }

 // add item in cart
 void addItem(ProductModel product){
     _cart.addItem(product, _quantity);
     _quantity=0;
     _inCartItems= _cart.getQuantity(product);
     _cart.items.forEach((key, value) {
     });
    update();
 }

 // get total items
int get totalItems{
   return _cart.totalQuantity;
}

}