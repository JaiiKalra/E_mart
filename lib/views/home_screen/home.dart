import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/views/cart_screen/cart_screen.dart';
import 'package:e_commerce/views/category_screen/category_screen.dart';
import 'package:e_commerce/views/home_screen/home_screen.dart';
import 'package:e_commerce/views/profile_screen/profile_screen.dart';
import 'package:e_commerce/widgets_commom/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26), label: account),

    ];

    var navBody =[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=> Expanded(
                child: navBody.elementAt(controller.currNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.currNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value){
              controller.currNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
