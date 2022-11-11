import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:shine_app/models/product.dart';

class ShoppingBagNotifier extends ChangeNotifier {
  final List<Product> _products = [];

  /// An unmodifiable view of the items in the cart.
  //UnmodifiableListView<Product> get items => UnmodifiableListView(_products);

  double get totalPrice => _products.map((product) => product.price).reduce((value, element) => element + value);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Product item) {
    _products.add(item);
    notifyListeners();
  }

  void remove(Product item) {
    _products.removeWhere((product) => product.id == item.id);
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _products.clear();
    notifyListeners();
  }

  bool cartContainsProduct(String id) {
    return _products.map((e) => e.id).contains(id);
  }

  get products{
    return _products;
  }
}