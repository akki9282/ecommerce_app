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
              id: Value(productList?.id ?? 0),
              title: productList?.title ?? '',
              price: productList?.price ?? 0.0,
              description: productList?.title ?? '',
              category: productList?.title ?? '',
              image_url: productList?.image ?? '',
              quantity: 1));

      print(a);
    }
  }

  deleteItemFromCart({required int id}) async {
    int a = await (database.delete(database.cartValues)
          ..where((t) => t.id.equals(id)))
        .go();
    print(a);
  }

  increseCartQuantity({required int id, required int quantity}) async {
    await (database.update(database.cartValues)..where((t) => t.id.equals(id)))
        .write(
      CartValuesCompanion(
        quantity: Value(
          (quantity + 1),
        ),
      ),
    );
  }

  decreseCartQuantity({required int id, required int quantity}) async {
    if (quantity == 1) {
      await deleteItemFromCart(id: id);
    } else {
      await (database.update(database.cartValues)
            ..where((t) => t.id.equals(id)))
          .write(
        CartValuesCompanion(
          quantity: Value(
            (quantity - 1),
          ),
        ),
      );
    }
  }
}
