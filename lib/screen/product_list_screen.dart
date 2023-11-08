import 'package:ecommerce_app/controller/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductListController productListController =
      Get.put(ProductListController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProductList();
    });

    super.initState();
  }

  getProductList() async {
    await productListController.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Product List',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          Icon(Icons.shopping_cart, color: Colors.black),
        ],
      ),
      body: SafeArea(
          child: Obx(
        () => productListController.productListModel?.value == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView.builder(
                itemCount: productListController
                    .productListModel?.value?.productList?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(107, 221, 217, 217),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(6.0, 8.0),
                        )
                      ],
                      color: Color.fromARGB(255, 255, 242, 220),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.sp,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Image.network(
                                  fit: BoxFit.fill,
                                  productListController.productListModel?.value
                                          ?.productList?[index].image ??
                                      ''),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(7),
                              height: 100,
                              // width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 3,
                                    color: Color.fromARGB(255, 255, 209, 139)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  // padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      // border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    '${productListController.productListModel?.value?.productList?[index].title ?? ''}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    '₹ ${productListController.productListModel?.value?.productList?[index].price ?? ''}',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 160, 36),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ]),
                  );
                },
              ),
      )),
    );
  }
}
