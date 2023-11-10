import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../local_database/database_config.dart';
import '../local_database/sql_query.dart';
import '../model/product_list_model.dart';

class RxNullable<T> {
  Rx<T> setNull() {
    return (null as T).obs;
  }
}

class ProductListController extends GetxController {
  var dio = Dio();

  Rx<ProductListModel?>? productListModel =
      RxNullable<ProductListModel?>().setNull();

  Rx<List<CartValue?>?>? cartProduct =
      RxNullable<List<CartValue?>?>().setNull();

  getProductList() async {
    try {
      var response = await dio.request(
        'https://fakestoreapi.com/products',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        productListModel?.value = ProductListModel.fromJson(response.data);
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: '${e}');
    }
  }

  addToCart({required ProductList? productList}) async {
    SQLQuery().addToCart(productList: productList);
  }

  getCartProduct() async {
    cartProduct?.value = await SQLQuery().getCartProduct();
  }
}
