import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/product_card.dart';

class FavoriteModel extends InheritedWidget {
  final _FavoriteModelState _state = _FavoriteModelState();

  FavoriteModel({Key? key, required Widget child}) : super(key: key, child: child);

  static _FavoriteModelState of(BuildContext context) {
    final FavoriteModel? result = context.dependOnInheritedWidgetOfExactType<FavoriteModel>();
    assert(result != null, 'No FavoriteModel found in context');
    return result!._state;
  }

  @override
  bool updateShouldNotify(covariant FavoriteModel oldWidget) => true;
}

class _FavoriteModelState {
  final List<ProductCard> _items = [];
  final ValueNotifier<int> notifier = ValueNotifier<int>(0);

  List<ProductCard> get items => List.unmodifiable(_items);

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _items.map((e) => e.toJson()).toList();
    await prefs.setString('favorite_items', jsonEncode(jsonList));
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('favorite_items');
    if (str != null) {
      final List decoded = jsonDecode(str);
      _items.clear();
      _items.addAll(decoded.map((e) => ProductCard.fromJson(e)).toList());
      notifier.value++;
    }
  }

  bool contains(ProductCard product) => _items.any((e) => e.title == product.title);

  void add(ProductCard product) {
    if (!contains(product)) {
      _items.add(product);
      notifier.value++;
      _saveToPrefs();
    }
  }

  void remove(ProductCard product) {
    _items.removeWhere((e) => e.title == product.title);
    notifier.value++;
    _saveToPrefs();
  }

  void toggle(ProductCard product) {
    if (contains(product)) {
      remove(product);
    } else {
      add(product);
    }
  }

  void clear() {
    _items.clear();
    notifier.value++;
    _saveToPrefs();
  }
} 