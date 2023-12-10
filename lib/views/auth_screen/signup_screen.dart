import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/lists.dart';
import 'package:e_commerce/controller/auth_controller.dart';
import 'package:e_commerce/views/home_screen/home.dart';
import 'package:e_commerce/widgets_commom/applogo_widget.dart';
import 'package:e_commerce/widgets_commom/bg_widget.dart';
import 'package:e_commerce/widgets_commom/custom_textfield.dart';
import 'package:e_commerce/widgets_commom/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordRetypeController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              'Join the $appname'.text.bold.white.size(18).make(),
              15.heightBox,
              Obx(
                ()=> Column(
                  children: [
                    customTextField(hint: nameHint, title: name, controller: nameController, isPass: false),
                    customTextField(hint: emailHint, title: email, controller: emailController, isPass: false),
                    customTextField(hint: passwordHint, title: password, controller: passwordController, isPass: true),
                    customTextField(hint: passwordHint, title: retypePassword, controller: passwordRetypeController, isPass: true),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPassword.text.make(),
                      ),
                    ),
                    5.heightBox,
                    // ourButton().box.width(context.screenWidth - 50).make(),
                    Row(
                      children: [
                        Checkbox(
                          value: isCheck,
                          activeColor: redColor,
                          checkColor: whiteColor,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                ),
                                TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    5.heightBox,
                    controller.isloading.value ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):
                    ourButton(
                      color:isCheck == true? redColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () async {
                        if(isCheck != false){
                          controller.isloading(true);
                          try{
                            await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value){
                              return controller.storeUserData(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text
                              );
                            }).then((value){
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(() => const Home());
                            });
                          } catch(e){
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isloading(false);
                          }
                        }
                      },
                    ).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    //wrapping into gesture detector of velocity X
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: alreadyHaveAccount,
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: login,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,
                            ),
                          ),
                        ],
                      ),
                    ).onTap(() {
                      Get.back();
                    }),
                  ],
                )
                    .box
                    .white
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .rounded
                    .shadowSm
                    .make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
