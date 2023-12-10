import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/chats_controller.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/views/chat_screen/components/sender_bubble.dart';
import 'package:e_commerce/widgets_commom/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen ({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Title'.text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(()=> controller.isLoading.value
              ? Center(
              child: loadingIndicator(),
              )
              : Expanded(
                child: StreamBuilder(
                    stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else if(snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: 'Send a Message...'.text.color(darkFontGrey).make(),
                        );
                      }else{
                        return ListView(
                          children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                            var data = snapshot.data!.docs[index];

                            return SenderBubble(data);
                          }).toList(),
                        );
                      }
                    }
                )
              ),
            ),

            10.heightBox,
            
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )
                    ),
                    hintText: 'Type a message...',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        )
                    ),
                  ),
                )),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();

                }, icon: Icon(Icons.send, color: redColor,))
              ],
            ).box.height(80).padding(EdgeInsets.all(12)).margin(EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}
