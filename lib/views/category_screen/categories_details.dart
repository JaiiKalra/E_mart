import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/provider/ProductProvider.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/views/category_screen/items_details.dart';
import 'package:e_commerce/widgets_commom/bg_widget.dart';
import 'package:e_commerce/widgets_commom/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});



  @override
  Widget build(BuildContext context) {
    print(Colors.purple.value);

    final productsProvider = Provider.of<ProductProvider>(context);
    List<Map<String, dynamic>> allData = productsProvider.getProducts;
    List<Map<String, dynamic>> categoryData = allData; // filter by category
    categoryData = categoryData.where((item) => item['p_category'] == title).toList();

    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            title: title!.text.fontFamily(bold).white.make(),
          ),
          body:  GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categoryData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 8),
                  itemBuilder: (context, index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            categoryData[index]["p_imgs"][0],
                            height: 150,
                            width: 200,
                            fit: BoxFit.cover
                        ),
                        // "${data[index]["p_imgs"][0]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                        "${categoryData[index]["p_name"]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                        "${categoryData[index]["p_price"]}".numCurrencyWithLocale().text.color(redColor).fontFamily(bold).size(16).make(),
                      ],
                    ).box.margin(EdgeInsets.symmetric(horizontal: 4)).white.roundedSM.outerShadowSm.padding(EdgeInsets.all(12)).make().onTap(() {
                      Get.to(()=>ItemsDetails(title: "${categoryData[index]["p_name"]}", data: categoryData[index],));
                    });
                  }
              ),
      ),
    );

  // @override
  // Widget build(BuildContext context) {
  //   print(Colors.purple.value);
  //   var controller = Get.find<ProductController>();
  //
  //
  //
  //   return bgWidget(
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: title!.text.fontFamily(bold).white.make(),
  //       ),
  //       body: StreamBuilder(
  //         stream: FirestoreServices.getProducts(title),
  //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
  //           if(!snapshot.hasData){
  //             return Center(
  //               child: loadingIndicator(),
  //             );
  //           } else if(snapshot.data!.docs.isEmpty){
  //             return Center(
  //               child: "No Products Found !!!".text.color(darkFontGrey).make(),
  //             );
  //           }else{
  //
  //             var data =  snapshot.data!.docs;
  //             print(data[0]['p_imgs'][0]);
  //
  //             return Container(
  //               padding: EdgeInsets.all(12),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SingleChildScrollView(
  //                     physics: BouncingScrollPhysics(),
  //                     scrollDirection: Axis.horizontal,
  //                     child: Row(
  //                       children: List.generate(
  //                           controller.subcat.length,
  //                               (index) => "${controller.subcat[index]}"
  //                               .text
  //                               .size(12)
  //                               .fontFamily(semibold)
  //                               .color(darkFontGrey)
  //                               .makeCentered()
  //                               .box
  //                               .rounded
  //                               .white
  //                               .size(120, 60)
  //                               .margin(EdgeInsets.symmetric(horizontal: 4))
  //                               .make()
  //                       ),
  //                     ),
  //                   ),
  //                   20.heightBox,
  //
  //                   //Items Container
  //                   Expanded(
  //                     child: GridView.builder(
  //                         physics: BouncingScrollPhysics(),
  //                         shrinkWrap: true,
  //                         itemCount: data.length,
  //                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 8),
  //                         itemBuilder: (context, index){
  //                           return Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Image.network(
  //                                   data[index]["p_imgs"][0],
  //                                   height: 150,
  //                                   width: 200,
  //                                   fit: BoxFit.cover
  //                               ),
  //                               // "${data[index]["p_imgs"][0]}".text.fontFamily(semibold).color(darkFontGrey).make(),
  //                               "${data[index]["p_name"]}".text.fontFamily(semibold).color(darkFontGrey).make(),
  //                               "${data[index]["p_price"]}".numCurrencyWithLocale().text.color(redColor).fontFamily(bold).size(16).make(),
  //                             ],
  //                           ).box.margin(EdgeInsets.symmetric(horizontal: 4)).white.roundedSM.outerShadowSm.padding(EdgeInsets.all(12)).make().onTap(() {
  //                             Get.to(()=>ItemsDetails(title: "${data[index]["p_name"]}", data: data[index],));
  //                           });
  //                         }
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             );
  //           }
  //         }
  //       )
  //     ),
  //   );
  }
}
