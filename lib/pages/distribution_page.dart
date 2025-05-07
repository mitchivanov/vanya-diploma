//Page with navigation bar and taken from outside widgets
import 'package:flutter/material.dart';

import '../data/icons.dart';
import '../data/product_data.dart';
import '../data/colors/main_colors.dart';
import 'account_page.dart';
import 'categories_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'cart_page.dart';
import '../widgets/main_nav_bar.dart';
import '../utils/cart_model.dart';
import '../utils/favorite_model.dart';

class DistributionPage extends StatefulWidget {
  const DistributionPage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class Product {
  final String name;
  final String description;
  final String image;
  final double price;
  final String store;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.store,
  });
}

//Navigation logic
class _HomePageState extends State<DistributionPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CartPage(),
    FavoritePage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadLocalData();
  }

  Future<void> _loadLocalData() async {
    await CartModel.of(context).loadFromPrefs();
    await FavoriteModel.of(context).loadFromPrefs();
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: MainNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}