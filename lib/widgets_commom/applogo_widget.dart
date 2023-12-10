import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget appLogoWidget(){
  //Using velocity_x here
  return Image.asset(icAppLogo).box.white.size(77, 77).padding(const EdgeInsets.all(8)).rounded.make();
}