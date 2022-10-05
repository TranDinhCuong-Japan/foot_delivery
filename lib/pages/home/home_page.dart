import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foot_delivery/pages/account/account.dart';
import 'package:foot_delivery/pages/auth/sign_in_page.dart';
import 'package:foot_delivery/pages/auth/sign_up_page.dart';
import 'package:foot_delivery/pages/cart/cart_history.dart';
import 'package:foot_delivery/pages/cart/cart_page.dart';
import 'package:foot_delivery/pages/home/main_food_page.dart';
import 'package:foot_delivery/utils/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _pageIndex = 0;

  List _page =[
    MainFoodPage(),
    SignInPage(),
    CartHistory(),
    AccountPage()
  ];

  void onTapNav(int index){
    setState(() {
      _pageIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.titleColor,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: "Archive"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Me"),
        ],
      ),
    );
  }
}
