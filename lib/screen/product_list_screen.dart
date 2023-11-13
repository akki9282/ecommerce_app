import 'package:ecommerce_app/controller/product_list_controller.dart';
import 'package:ecommerce_app/screen/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int page = 1;
  int limit = 5;
  bool hasMoreItem = true;
  RxBool isLoading = false.obs;
  final scrollController = ScrollController();

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
    hasMoreItem = await productListController.getProductList(limit: limit);
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        print('detect scroll lister');
        if (hasMoreItem) {
          isLoading.value = true;
          limit = limit + 5;
          hasMoreItem =
              await productListController.getProductList(limit: limit);
          isLoading.value = false;
        }
        // if (!isLoading) {
        //   isLoading = !isLoading;
        //   // Perform event when user reach at the end of list (e.g. do Api call)
        // }
      }
    });

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Product List',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Cart())),
                child: Image.asset('assets/go_to_cart.png'))
            // Icon(Icons.shopping_cart, color: Colors.black),
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
              : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: scrollController,
                        shrinkWrap: false,
                        itemCount: productListController
                            .productListModel?.value?.productList?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      backgroundColor: Colors.white,
                                      // backgroundColor: Colors.white,
                                      iconPadding: EdgeInsets.all(3),
                                      icon: Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.cancel_presentation_sharp,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                      insetPadding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 20.0),
                                      contentPadding: EdgeInsets.all(15),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(0.0))),
                                      title: const Text(
                                        'Product Details',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                // padding: EdgeInsets.all(5),
                                                height: h * 0.4,
                                                // width: 500,
                                                width: double.infinity,
                                                child: Image.network(
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.black,
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.fill,
                                                    productListController
                                                            .productListModel
                                                            ?.value
                                                            ?.productList?[
                                                                index]
                                                            .image ??
                                                        ''),
                                              ),
                                            ),
                                            Text(
                                                '${productListController.productListModel?.value?.productList?[index].category.toString().capitalizeFirst ?? ''}'),
                                            Text(
                                                '${productListController.productListModel?.value?.productList?[index].title ?? ''}',
                                                style: TextStyle(
                                                    // overflow: TextOverflow.ellipsis,
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              '₹ ${productListController.productListModel?.value?.productList?[index].price ?? ''}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Color.fromARGB(
                                                      255, 255, 160, 36),
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        91, 70, 70, 70)),
                                                textAlign: TextAlign.justify,
                                                '${productListController.productListModel?.value?.productList?[index].description ?? ''}'),
                                            Center(
                                                child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.all(15),
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color.fromARGB(
                                                        255, 204, 228, 250)),
                                                child: Text(
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                  'Add Cart',
                                                ),
                                              ),
                                            ))
                                          ],
                                        ),
                                      ));
                                },
                              );
                            },
                            child: Container(
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
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(10),
                                            height: MediaQuery.of(context)
                                                        .orientation ==
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Image.network(loadingBuilder:
                                                    (context, child,
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.black,
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                                fit: BoxFit.fill,
                                                productListController
                                                        .productListModel
                                                        ?.value
                                                        ?.productList?[index]
                                                        .image ??
                                                    ''),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                // padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    // border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  '${productListController.productListModel?.value?.productList?[index].title ?? ''}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.start,
                                                      'Price: ₹ ${productListController.productListModel?.value?.productList?[index].price ?? ''}',
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              160,
                                                              36),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await productListController.addToCart(
                                                            productList:
                                                                productListController
                                                                    .productListModel
                                                                    ?.value
                                                                    ?.productList?[index]);
                                                      },
                                                      child:
                                                          //  Icon(
                                                          //   Icons
                                                          //       .add_shopping_cart,
                                                          //   color: Colors.green,
                                                          // )
                                                          Image.asset(
                                                              'assets/add_to_cart.png'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RatingBar.builder(
                                            itemSize: 23,
                                            ignoreGestures: true,
                                            itemCount: 5,
                                            allowHalfRating: true,
                                            direction: Axis.horizontal,
                                            minRating: 1,
                                            initialRating: productListController
                                                    .productListModel
                                                    ?.value
                                                    ?.productList?[index]
                                                    .rating
                                                    ?.rate ??
                                                0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.green,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                          Text(
                                            ' (${productListController.productListModel?.value?.productList?[index].rating?.count ?? 0})',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.5,
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 1
                                    : 2),
                      ),
                    ),
                    if (isLoading.value)
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                ),
        )));
  }
}
