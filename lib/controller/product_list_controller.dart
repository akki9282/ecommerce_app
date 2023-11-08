import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

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

  getProductList() async {
    var response = await dio.request(
      'https://fakestoreapi.com/products',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      productListModel?.value = ProductListModel.fromJson(response.data);
    } else {}
  }
}
