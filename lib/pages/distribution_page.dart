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
  final List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> favoriteItems = [];

  void updateCartItems(Map<String, dynamic> item, bool isAdded) {
    setState(() {
      if (isAdded) {
        cartItems.add(item);
      } else {
        cartItems.removeWhere((cartItem) => cartItem['name'] == item['name']);
      }
    });
  }

  void updateFavoriteItems(Map<String, dynamic> item, bool isAdded) {
    setState(() {
      if (isAdded) {
        favoriteItems.add(item);
      } else {
        favoriteItems.removeWhere((favItem) => favItem['name'] == item['name']);
      }
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const CartPage(),
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
          buildNavItem(0, homeIcon, false, context),
          buildNavItem(1, Icons.shopping_cart, true, context),
          buildNavItem(2, favoriteIcon, false, context),
          buildNavItem(3, accountIcon, false, context),
        ],
      ),
    );
  }

  Column buildNavItem(int index, dynamic iconPath, bool isIconData, BuildContext context) {
    return Column(
      children: [
        IconButton(
          enableFeedback: false,
          icon: isIconData 
              ? Icon(iconPath as IconData, size: 24, color: _selectedIndex == index ? accentLightColor : Colors.grey)
              : Image.asset(iconPath as String, scale: 1.143, color: _selectedIndex == index ? accentLightColor : null),
          onPressed: () {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        _selectedIndex == index
            ? Image.asset(indicator)
            : Image.asset(indicator, color: Colors.transparent),
      ],
    );
  }
}