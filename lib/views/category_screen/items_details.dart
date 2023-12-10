import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/lists.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/views/chat_screen/chat_screen.dart';
import 'package:e_commerce/widgets_commom/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemsDetails({super.key, required this.title, this.data});

    @override
    Widget build(BuildContext context) {

      var controller = Get.find<ProductController>();

      return WillPopScope(
        onWillPop: () async {
          controller.resetValues();
          return true;
        },
        child: Scaffold(
          backgroundColor: lightGrey,
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  controller.resetValues();
                  Get.back();
                },
                icon: Icon(Icons.arrow_back),
            ),
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline)),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Swiper Section

                        VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16/9,
                          viewportFraction: 1.0,
                          itemCount: data["p_imgs"].length,
                          itemBuilder: (context, index){
                            return Image.network(data["p_imgs"][index], width: double.infinity, fit: BoxFit.cover,);
                          }),
                        10.heightBox,

                        //title and details section
                        title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,

                        //rating
                        VxRating(
                          isSelectable: false,
                          value: double.parse(data["p_rating"]),
                          onRatingUpdate: (value){},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          maxRating: 5,
                        ),
                        10.heightBox,
                        "${data["p_price"]}".numCurrencyWithLocale().text.color(redColor).fontFamily(bold).size(18).make(),
                        10.heightBox,

                        Row(
                          children: [
                            Expanded(
                              child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "Seller".text.white.fontFamily(semibold).make(),
                                    5.heightBox,
                                    "${data["p_seller"]}".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                                  ],
                                )
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded, color: darkFontGrey),
                            ).onTap(() {
                              print(data);
                              // print(data['vendor_id']);
                              Get.to(
                                ()=>const ChatScreen(),
                                arguments: [data['p_seller'], data['vendor_id']],
                              );
                            }),
                          ],
                        ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                        //Colors Section
                        20.heightBox,
                        Obx(
                          () => Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Colors: ".text.color(textfieldGrey ).make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                        data["p_colors"].length,
                                        (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                              .size(40, 40).
                                              roundedFull.
                                              color(Color(data["p_colors"][index]).withOpacity(1.0))
                                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                                              .make()
                                              .onTap(() {
                                                controller.changeColorIndex(index);
                                              }),
                                            Visibility(
                                              visible: index == controller.colorIndex.value,
                                              child: Icon(Icons.done, color: Colors.white,)
                                            )
                                          ]
                                        ),
                                    ),
                                  )
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),

                              //quantity row
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity: ".text.color(textfieldGrey ).make(),
                                  ),
                                  Obx(
                                      ()=> Row(
                                      children: [
                                        IconButton(onPressed: (){
                                          controller.decreaseQuantity();
                                          controller.calcTotalPrice(int.parse(data["p_price"]));
                                        }, icon: const Icon(Icons.remove)),
                                        controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                        IconButton(onPressed: (){
                                          controller.increaseQuantity(int.parse(data["p_quantity"]));
                                          controller.calcTotalPrice(int.parse(data["p_price"]));
                                        }, icon: const Icon(Icons.add)),
                                        10.widthBox,
                                        "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                                      ],
                                    ),
                                  ),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),

                              //total row
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total: ".text.color(textfieldGrey ).make(),
                                  ),
                                  "${controller.totalPrice.value}".text.color(redColor).size(16).fontFamily(bold).make(),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ],
                          ).box.white.shadowSm.make(),
                        ),
                        10.heightBox,

                        //description
                        "Description:".text.color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,
                        "${data['p_desc']}".text.color(darkFontGrey).make(),
                        10.heightBox,

                        //buttons section
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            itemDetailButtonsList.length,
                            (index) => ListTile(
                              title: itemDetailButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                              trailing: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                        20.heightBox,

                        //products you may like section
                        productsyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                        10.heightBox,

                        // copied this widget from home screen featured products
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(6, (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(imgP1, width: 150, fit: BoxFit.cover),
                                "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                                "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                              ],
                            ).box.margin(const EdgeInsets.symmetric(horizontal: 4)).white.roundedSM.padding(const EdgeInsets.all(8)).make()),
                          ),
                        ),
                      ],

                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                  color: redColor,
                  onPress: (){
                    controller.addToCart(
                      color: data['p_color'][controller.colorIndex.value],
                      // color: 'redColor',
                      context: context,
                      img: data['p_imgs'][0],
                      qty: controller.quantity.value,
                      sellername: data['p_seller'],
                      title: data['p_name'],
                      tprice: controller.totalPrice.value
                    );
                    VxToast.show(context, msg: 'Added to cart');
                  },
                  textColor: whiteColor,
                  title: "Add to Cart",
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
