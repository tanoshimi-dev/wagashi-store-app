import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/product.dart';

class ProductsProvider extends StateNotifier<List<Product>> {
  ProductsProvider() : super([]);

  List<Product> _products = [];
  String _status = '';

  List<Product> get products => _products;
  String get status => _status;

  Future<void> searchProducts() async {
    // query the database

    _status = 'loading';

    // futureMenus.then((product) {
    //   _products = product;
    //   // notifyListeners();
    // });
  }
}

final productsProvider =
    StateNotifierProvider<ProductsProvider, List<Product>>((ref) {
  return ProductsProvider();
});
