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
  RxDouble subTotal = 0.0.obs;
  RxDouble delivery = 50.0.obs;
  RxDouble gst = 0.0.obs;
  RxDouble total = 0.0.obs;

  Rx<ProductListModel?>? productListModel =
      RxNullable<ProductListModel?>().setNull();

  Rx<List<CartValue?>?>? cartProduct =
      RxNullable<List<CartValue?>?>().setNull();

  final sqlQuery = SQLQuery();

//product api
  Future<bool> getProductList({required int limit}) async {
    try {
      var response = await dio.request(
        'https://fakestoreapi.com/products?limit=$limit',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        productListModel?.value = ProductListModel.fromJson(response.data);
        // if (page == 1) {
        //   productListModel?.value = temp;
        // } else {
        //   productListModel?.value = temp;
        //   // productListModel?.value?.productList
        //   //     ?.addAll(temp.productList as Iterable<ProductList>);
        // }
        return productListModel?.value?.productList?.length == limit
            ? true
            : false;
      } else {
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '${e}');
      return false;
    }
  }

//SQL query
  addToCart({required ProductList? productList}) async {
    await sqlQuery.addToCart(productList: productList);
    Fluttertoast.showToast(msg: 'Product added cart successfully');
  }

  getCartProduct() async {
    cartProduct?.value = await sqlQuery.getCartProduct();
    subTotal.value = 0.0;
    gst.value = 0.0;
    total.value = 0.0;
    if (cartProduct?.value != null) {
      calculateTotalPayableAmt();
    }
  }

  deleteProductFromCart({required int id}) async {
    await sqlQuery.deleteItemFromCart(id: id);
    await getCartProduct();
  }

//helper fuction
  calculateTotalPayableAmt() {
    for (CartValue? element in cartProduct?.value ?? []) {
      subTotal.value = subTotal.value +
          ((element?.price ?? 0.0) * (element?.quantity ?? 0.0));
    }
    gst.value = (subTotal.value * 18) / 100;
    total.value = subTotal.value + delivery.value + gst.value;
  }

  increseCartQuantity({required int id, required int quantity}) async {
    await sqlQuery.increseCartQuantity(id: id, quantity: quantity);
    getCartProduct();
  }

  decreseCartQuantity({required int id, required int quantity}) async {
    await sqlQuery.decreseCartQuantity(id: id, quantity: quantity);
    getCartProduct();
  }
}
