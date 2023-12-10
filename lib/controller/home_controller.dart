import 'package:e_commerce/consts/firebase_const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    getUsername();
    // TODO: implement onInit
    super.onInit();
  }

  var currNavIndex = 0.obs;

  var username = '';

  getUsername() async{
    var n = await firestore.collection(usersCollections).where('id', isEqualTo: currentUser!.uid).get().then((value){
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });

    username = n;
    // print(username);
  }
}