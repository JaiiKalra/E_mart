

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{

  static List<Map<String, dynamic>> _productsList = [];

  List<Map<String, dynamic>> get getProducts {
    return _productsList;
  }

  fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      // _productsList.clear();
      productSnapshot.docs.forEach((element) {

        Map<String, dynamic> data = {
          'p_name' : element.get('p_name'),
          'p_imgs' : element.get('p_imgs'),
          'p_category': element.get('p_category'),
          'p_rating': element.get('p_rating'),
          'p_price':element.get('p_price'),
          'p_quantity' : element.get('p_quantity'),
          // 'p_rating' : element.get('p_rating'),
          'p_seller' : element.get('p_seller'),
          'p_subcategory': element.get('p_subcategory'),
          'p_wishlist' : element.get('p_wishlist'),
          'p_colors' : element.get('p_colors'),
          'p_desc': element.get('p_desc')

        };
        _productsList.add(data);
      });
    });
    print("product fetched $_productsList");
    notifyListeners();
  }

}