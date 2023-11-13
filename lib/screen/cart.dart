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

  @override
  void dispose() {
    Get.delete<ProductListController>();
    super.dispose();
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
              onPressed: () {
                Navigator.pop(context);
              },
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
        body: Obx(
          () => productListController.cartProduct?.value == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : productListController.cartProduct?.value?.length == 0
                  ? Center(child: Text('There is no product added in the cart'))
                  : (MediaQuery.of(context).orientation ==
                              Orientation.portrait ||
                          MediaQuery.of(context).size.width <= 480)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                              Expanded(
                                child: cartItemProductList(h, w),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: payableTable(),
                              ),
                              buyButton()
                            ])
                      : Row(children: [
                          Expanded(flex: 2, child: cartItemProductList(h, w)),
                          Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  payableTable(),
                                  buyButton(),
                                ],
                              ),
                            ),
                          )
                        ]),
        ));
  }

  Container buyButton() {
    return Container(
      // width: double.,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 204, 228, 250)),
      child: Text(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        textAlign: TextAlign.center,
        'Buy',
      ),
    );
  }

  Container payableTable() {
    return Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 227, 227),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal:'),
                  Text(
                      '₹ ${productListController.subTotal.value.toStringAsFixed(2)}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Charge:'),
                  Text(
                      '₹ ${productListController.delivery.value.toStringAsFixed(2)}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('GST:'),
                  Text(
                      '₹ ${productListController.gst.value.toStringAsFixed(2)}'),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹ ${productListController.total.value.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Container cartItemProductList(double h, double w) {
    return Container(
      // height: double.infinity,
      child: Obx(
        () => ListView.builder(
          shrinkWrap: false,
          itemCount: productListController.cartProduct?.value?.length ?? 0,
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
                              color: const Color.fromARGB(255, 255, 209, 139)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                            loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                            fit: BoxFit.fill,
                            productListController
                                    .cartProduct?.value?[index]?.image_url ??
                                ''),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              '${productListController.cartProduct?.value?[index]?.title ?? ''}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  'Price: ₹ ${productListController.cartProduct?.value?[index]?.price ?? 0.0}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 160, 36),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await productListController
                                        .deleteProductFromCart(
                                            id: productListController
                                                    .cartProduct
                                                    ?.value?[index]
                                                    ?.id ??
                                                0);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[200],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    productListController.decreseCartQuantity(
                                        id: productListController.cartProduct
                                                ?.value?[index]?.id ??
                                            0,
                                        quantity: productListController
                                                .cartProduct
                                                ?.value?[index]
                                                ?.quantity ??
                                            0);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border:
                                          //     Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Icon(
                                        Icons.remove,
                                        size: 17,
                                      )),
                                ),
                                Text(
                                    '${productListController.cartProduct?.value?[index]?.quantity ?? 0}'),
                                GestureDetector(
                                  onTap: () {
                                    productListController.increseCartQuantity(
                                        id: productListController.cartProduct
                                                ?.value?[index]?.id ??
                                            0,
                                        quantity: productListController
                                                .cartProduct
                                                ?.value?[index]
                                                ?.quantity ??
                                            0);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border:
                                        //     Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(
                                      Icons.add,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
