import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gift_portal/data/icons.dart';
import 'package:gift_portal/pages/wishlist_page.dart';
import 'package:gift_portal/utils/card_of_products.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/colors/main_colors.dart';
import '../widgets/unified_appbar.dart';

import 'distribution_page.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, dynamic>> items = [
    {
      "name": "Молоко",
      "image": 'lib/assets/pictures/idea1.jpg',
      "description": "Свежие молочные продукты.",
      "price": 1.99,
      "store": "Wildberies",
    },
    {
      "name": "Хлеб",
      "image": 'lib/assets/pictures/idea2.jpg',
      "description": "Хрустящий хлеб из муки высшего сорта.",
      "price": 0.99,
      "store": "Ozon",
    },
    {
      "name": "Яблоки",
      "image": 'lib/assets/pictures/idea3.jpg',
      "description": "Сочные яблоки, собранные с лучших садов."*10,
      "price": 2.49,
      "store": "Ozon",
    },
    {
      "name": "Бананы",
      "image": 'lib/assets/pictures/idea4.jpg',
      "description": "Спелые бананы, идеальные для перекуса.",
      "price": 1.29,
      "store": "Яндекс market",
    },
    {
      "name": "Кофе",
      "image": 'lib/assets/pictures/1.png',
      "description": "Ароматный кофе для бодрого утра.",
      "price": 3.99,
      "store": "Яндекс market",
    },
    {
      "name": "Вода",
      "image": 'lib/assets/pictures/disc1.jpg',
      "description": "Чистая питьевая вода.",
      "price": 0.50,
      "store": "Ozon",
    },
  ];

  final List<Map<String, dynamic>> cartItems = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = items;
    searchController.addListener(() {
      filterProducts();
    });
  }

  void filterProducts() {
    setState(() {
      filteredProducts = items
          .where((product) =>
          product["name"].toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void updateCartItems(Map<String, dynamic> item, bool isAdded) {
    setState(() {
      if (isAdded) {
        cartItems.add(item);
      } else {
        cartItems.removeWhere((cartItem) => cartItem['name'] == item['name']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gift Portal',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF00FFF0)),
        home: Scaffold(
          extendBody: true,
          appBar: UnifiedAppBar(
            title: 'Gift Portal',
            showBack: true,
            onBack: () {
              FocusScope.of(context).unfocus();
              Timer(const Duration(milliseconds: 150), () {
                Navigator.of(context).pop(MaterialPageRoute(builder: (ctx) => const DistributionPage()));
              });
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    int originalIndex = items.indexOf(filteredProducts[index]);
                    return ProductCard(
                      item: items[originalIndex],
                      isAddedToCart: cartItems.any((cartItem) => cartItem['name'] == filteredProducts[index]['name']),
                      onCartUpdate: updateCartItems,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistPage(
                          cartItems: cartItems,
                          onCartUpdate: updateCartItems,
                        ),
                      ),
                    );
                  },
                  child: Text('Перейти в корзину'),
                ),
              ),
            ],
          ),
        )
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isAddedToCart;
  final Function(Map<String, dynamic>, bool) onCartUpdate;

  ProductCard({required this.item, required this.isAddedToCart, required this.onCartUpdate});

  void toggleCartStatus() {
    onCartUpdate(item, !isAddedToCart);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              showProductDetails(context,
                  item["name"],
                  item["image"],
                  item["description"],
                  item["price"],
                  item["store"]
              );
            },
            child: Container(
              height: screenSize.height * 0.22,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.22 * 0.92,
                    width: screenSize.width * 0.375,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(item["image"], fit: BoxFit.fill)
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.42,
                        child: Text(item["name"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: GoogleFonts.afacad(
                              textStyle: const TextStyle(fontSize: 25)
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.42,
                        child: Text(item["description"],
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: GoogleFonts.afacad(
                              textStyle: const TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                      Text('\$${item["price"].toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      isAddedToCart ? Icons.favorite : Icons.favorite_border,
                      color: isAddedToCart ? Colors.red : null,
                      size: 35,
                    ),
                    onPressed: toggleCartStatus,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
