import 'package:flutter/material.dart';
import 'package:foot_delivery/data/repository/cart_repo.dart';
import 'package:foot_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/app_color.dart';

class  CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items ={};
  Map<int, CartModel> get items =>_items;

  //only for storage and sharedPreferences
  List<CartModel> storageItems=[];

  // add or update item in cart
  void addItem(ProductModel product, int quantity){
    int totalQuantity=0;
    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity!+quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: value.product
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }else {
      if(quantity>0){
        _items.putIfAbsent(product.id!, () =>
            CartModel(
                id: product.id,
                name: product.name,
                price: product.price,
                img: product.img,
                quantity: quantity,
                isExist: true,
                time: DateTime.now().toString(),
                product: product
            ));
      }else{
        Get.snackbar("Add item", "You can't add 0 item in cart", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(listCartItems);
    update();
  }

  // check item exist in cart
  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  // get quantity
  int getQuantity(ProductModel product){
    int quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
    }
    return quantity;
  }

  // get total quantity
  int get totalQuantity{
   int totalQuantity =0;
   _items.forEach((key, value) {
     totalQuantity += value.quantity!;
   });
   return totalQuantity;
  }

  // Get item in cart
  List<CartModel> get listCartItems{
      return _items.entries.map((e){
        return e.value;
      }).toList();
  }

  // Get total amount
  int get totalAmount{
    int total =0;
    _items.forEach((key, value) {
      total+= value.quantity!*value.price!;
    });
    return total;
  }

  // Get cart data local
 List<CartModel> getCartData(){
   setCart=cartRepo.getCartList();
    return storageItems;
 }
  // Set cart data local
  set setCart(List<CartModel> items){
    storageItems=items;

    for(int i=0; i<storageItems.length;i++){
    _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  // Add to history
  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  // remove items in cart
  void clear() {
    _items={};
    update();
  }

  // get cart history
  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  //set item more oder
  set setItems(Map<int, CartModel> setItems){
    _items={};
    _items=setItems;
  }

  //add more oder to cart list
  void addMoreOderToCartList(){
    cartRepo.addToCartList(listCartItems);
    update();
  }

}