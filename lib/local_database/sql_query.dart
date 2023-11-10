import 'package:drift/drift.dart';
import 'package:ecommerce_app/local_database/database_config.dart';

import '../model/product_list_model.dart';

class SQLQuery {
  final database = AppDatabase();

  Future<List<CartValue>> getCartProduct() async {
    return await database.select(database.cartValues).get();
  }

  addToCart({required ProductList? productList}) async {
    final checkExitingPresentOrNot = await (database.select(database.cartValues)
          ..where((t) => t.id.equals(productList?.id ?? 0)))
        .getSingleOrNull();

    if (checkExitingPresentOrNot != null) {
      await (database.update(database.cartValues)
            ..where((t) => t.id.equals(productList?.id ?? 0)))
          .write(
        CartValuesCompanion(
          quantity: Value(
            (checkExitingPresentOrNot.quantity + 1),
          ),
        ),
      );
    } else {
      int a = await database.into(database.cartValues).insert(
          CartValuesCompanion.insert(
              title: productList?.title ?? '',
              price: productList?.price ?? 0.0,
              description: productList?.title ?? '',
              category: productList?.title ?? '',
              image_url: productList?.title ?? '',
              quantity: 1));

      print(a);
    }
  }
}
