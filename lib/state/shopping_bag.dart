import 'package:flutter/foundation.dart';
import 'package:shine_app/models/product.dart';

class ShoppingBagNotifier extends ChangeNotifier {
  final List<Product> _productsInBag = [];
  final List<Product> _productsInWishlist = [];

  double get totalPrice => _productsInBag.map((product) => product.price).reduce((value, element) => element + value);

  void add(Product item) {
    _productsInBag.add(item);
    notifyListeners();
  }

  void addToWishlist(Product item) {
    _productsInWishlist.add(item);
    notifyListeners();
  }

  void remove(Product item) {
    _productsInBag.removeWhere((product) => product.id == item.id);
    notifyListeners();
  }

  void removeFromWishlist(Product item) {
    _productsInWishlist.removeWhere((product) => product.id == item.id);
    notifyListeners();
  }

  void removeAll() {
    _productsInBag.clear();
    notifyListeners();
  }

  bool cartContainsProduct(String id) {
    return _productsInBag.map((e) => e.id).contains(id);
  }

  bool wishlistContainsProduct(String id) {
    return _productsInWishlist.map((e) => e.id).contains(id);
  }

  get products{
    return _productsInBag;
  }

  get wishlistProducts {
    return _productsInWishlist;
  }
}