import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/provider/ProductProvider.dart';
import 'package:e_commerce/views/auth_screen/login_screen.dart';
import 'package:e_commerce/views/home_screen/home.dart';
import 'package:e_commerce/views/home_screen/home_screen.dart';
import 'package:e_commerce/widgets_commom/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //creating a method to change screen

  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      //using getx
      // Get.to(()=>LoginScreen());
      auth.authStateChanges().listen((User ? user) {
        if(user == null && mounted){
          Get.to(()=>const LoginScreen());
        } else{
          Get.to(()=>const Home());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
      Provider.of<ProductProvider>(context, listen: false);

      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await productsProvider.fetchProducts();
      }
    });
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg,width: 300,)
            ),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //our splashscreen ui is completed...
          ],
        ),
      ),
    );
  }
}
