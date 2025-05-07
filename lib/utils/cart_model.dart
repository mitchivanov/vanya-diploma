import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/product_card.dart';

class CartItem {
  final ProductCard product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    product: ProductCard.fromJson(json['product']),
    quantity: json['quantity'],
  );
}

class CartModel extends InheritedWidget {
  final List<CartItem> _items = [];
  final _CartModelState _state = _CartModelState();

  CartModel({Key? key, required Widget child}) : super(key: key, child: child);

  static _CartModelState of(BuildContext context) {
    final CartModel? result = context.dependOnInheritedWidgetOfExactType<CartModel>();
    assert(result != null, 'No CartModel found in context');
    return result!._state;
  }

  @override
  bool updateShouldNotify(CartModel oldWidget) => true;
}

class _CartModelState {
  final List<CartItem> _items = [];
  final ValueNotifier<int> notifier = ValueNotifier<int>(0);

  List<CartItem> get items => List.unmodifiable(_items);

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _items.map((e) => e.toJson()).toList();
    await prefs.setString('cart_items', jsonEncode(jsonList));
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('cart_items');
    if (str != null) {
      final List decoded = jsonDecode(str);
      _items.clear();
      _items.addAll(decoded.map((e) => CartItem.fromJson(e)).toList());
      notifier.value++;
    }
  }

  void add(ProductCard product) {
    final idx = _items.indexWhere((e) => e.product.title == product.title);
    if (idx >= 0) {
      _items[idx].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifier.value++;
    _saveToPrefs();
  }

  void remove(ProductCard product) {
    final idx = _items.indexWhere((e) => e.product.title == product.title);
    if (idx >= 0) {
      if (_items[idx].quantity > 1) {
        _items[idx].quantity--;
      } else {
        _items.removeAt(idx);
      }
      notifier.value++;
      _saveToPrefs();
    }
  }

  void removeAll(ProductCard product) {
    _items.removeWhere((e) => e.product.title == product.title);
    notifier.value++;
    _saveToPrefs();
  }

  void clear() {
    _items.clear();
    notifier.value++;
    _saveToPrefs();
  }

  double get total => _items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
} 