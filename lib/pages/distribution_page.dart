//Page with navigation bar and taken from outside widgets
import 'package:flutter/material.dart';

import '../data/icons.dart';
import '../data/product_data.dart';
import 'account_page.dart';
import 'categories_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';

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
  // final List<Product> products = ProductData.getProducts();
  // final List<Product> cartItems = [];

  // void updateCartItems(Product item, bool isAdded) {
  //   setState(() {
  //     if (isAdded) {
  //       cartItems.add(item);
  //     } else {
  //       cartItems.removeWhere((cartItem) => cartItem.name == item.name);
  //     }
  //   });
  // }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const CategoriesPage(),
    const FavoritePage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: navBar(context),
    );
  }

  //Custom navigation bar
  Container navBar(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height - screenSize.height * 0.27 - screenSize.height * 0.25 - (screenSize.height - ((screenSize.height * 0.27) + (screenSize.height * 0.25)) - 54),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(0, homeIcon, context),
          buildNavItem(1, searchListIcon, context),
          buildNavItem(2, favoriteIcon, context),
          buildNavItem(3, accountIcon, context),
        ],
      ),
    );
  }

  Column buildNavItem(int index, String iconPath, BuildContext context) {
    return Column(
      children: [
        IconButton(
          enableFeedback: false,
          icon: Image.asset(iconPath, scale: 1.143),
          onPressed: () {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        _selectedIndex == index
            ? Image.asset(indicator)
            : Image.asset(
            indicator, color: Colors.transparent),
      ],
    );
  }
}