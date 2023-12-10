import 'dart:io';

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/profile_controller.dart';
import 'package:e_commerce/widgets_commom/bg_widget.dart';
import 'package:e_commerce/widgets_commom/custom_textfield.dart';
import 'package:e_commerce/widgets_commom/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //if data and image url is empty
                  data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                      ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()

                      //if data is not empty but controller path is empty
                      : data['imageUrl'] != '' &&
                              controller.profileImgPath.isEmpty
                          ? Image.network(
                              data['imageUrl'],
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()

                          //if both are empty
                          : Image.file(
                              File(controller.profileImgPath.value),
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),

                  10.heightBox,
                  ourButton(
                      color: redColor,
                      onPress: () {
                        controller.changeImage(context);
                      },
                      textColor: whiteColor,
                      title: "change"),
                  const Divider(),
                  20.heightBox,
                  customTextField(
                    controller: controller.nameController,
                    hint: nameHint,
                    title: name,
                    isPass: false,
                  ),
                  10.heightBox,
                  customTextField(
                    controller: controller.oldpassController,
                    hint: passwordHint,
                    title: oldpass,
                    isPass: true,
                  ),
                  10.heightBox,
                  customTextField(
                    controller: controller.newpassController,
                    hint: passwordHint,
                    title: newpass,
                    isPass: true,
                  ),
                  20.heightBox,
                  controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : SizedBox(
                          width: context.screenWidth - 60,
                          child: ourButton(
                              color: redColor,
                              onPress: () async {
                                controller.isLoading(true);

                                //if image is not selected
                                if(controller.profileImgPath.value.isNotEmpty){
                                  await controller.uploadProfileImage();
                                }else{
                                  controller.profileImageLink =data['imageUrl'];
                                }

                                //if old password matches the old password from database

                                if(data['password'] == controller.oldpassController.text){

                                  controller.changeAuthPassword(
                                    email: data['email'],
                                    password: controller.oldpassController.text,
                                    newpassword: controller.newpassController.text
                                  );

                                  await controller.updateProfile(
                                      imgUrl: controller.profileImageLink,
                                      name: controller.nameController.text,
                                      password: controller.newpassController.text);
                                  VxToast.show(context, msg: 'Updated');
                                }else{
                                  VxToast.show(context, msg: "Wrong Old Password");
                                  controller.isLoading(false);
                                }
                              },
                              textColor: whiteColor,
                              title: "Save")),
                ],
              )
                  .box
                  .white
                  .shadowSm
                  .padding(EdgeInsets.all(16))
                  .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
                  .rounded
                  .make(),
            )));
  }
}
