import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}