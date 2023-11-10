import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_list_controller.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  ProductListController productListController =
      Get.put(ProductListController());

  @override
  void initState() {
    getCartProduct();
    super.initState();
  }

  getCartProduct() async {
    await productListController.getCartProduct();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        color: Colors.red,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: Container(
              // height: double.infinity,
              child: ListView.builder(
                shrinkWrap: false,
                itemCount:
                    productListController.cartProduct?.value?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(107, 177, 177, 177),
                          blurRadius: 5.0,
                          spreadRadius: 3.0,
                          offset: Offset(4.0, 8.0),
                        )
                      ],
                      color: Color.fromARGB(255, 221, 234, 245),
                      // Color.fromARGB(255, 255, 242, 220),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? h * 0.15
                                  : w * 0.15,
                              // width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 3,
                                    color: const Color.fromARGB(
                                        255, 255, 209, 139)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                                  fit: BoxFit.fill,
                                  productListController.productListModel?.value
                                          ?.productList?[index].image ??
                                      ''),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.start,
                                        'Price: ₹ ${productListController.productListModel?.value?.productList?[index].price ?? ''}',
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 160, 36),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            await productListController
                                                .addToCart(
                                                    productList:
                                                        productListController
                                                                .productListModel
                                                                ?.value
                                                                ?.productList?[
                                                            index]);
                                          },
                                          child: Image.asset(
                                              'assets/add_to_cart.png'))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              color: Colors.amber,
            ),
          ),
        ]),
      ),
    );
  }
}
