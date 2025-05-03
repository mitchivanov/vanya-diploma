import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/colors/main_colors.dart';
import '../data/icons.dart';
import '../widgets/abs_widget.dart';
import '../widgets/discount_widget.dart';
import '../widgets/ideas_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/transition_clipper.dart';
import '../data/product_data.dart';
import '../data/product_card.dart';
import 'categories_page.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  void _openProductPage(BuildContext context, ProductCard product) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ProductData.getProducts();
    return MaterialApp(
      title: 'Gift app',
      theme: ThemeData(scaffoldBackgroundColor: primaryLightColor),
      home: Scaffold(
        backgroundColor: primaryLightColor,
        appBar: AppBar(
          toolbarHeight: 53,
          backgroundColor: accentLightColor,
          title: Text('Gift app',
            style: GoogleFonts.merriweather(
              textStyle: const TextStyle(fontSize: 28, color: accentGoldColor, fontWeight: FontWeight.bold, shadows: [Shadow(color: accentBlueColor, blurRadius: 8, offset: Offset(0, 0))]),
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)
              )
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Строка поиска
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Кнопка меню категорий
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: accentLightColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const CategoriesPage()),
                            );
                          },
                        ),
                      ),
                      // Текстовое поле поиска
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Найти товары',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 16),
                          enabled: false, // Заглушка для будущей функциональности
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Список товаров
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () => _openProductPage(context, product),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1.2,
                                  child: Image.asset(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                child: Text(
                                  product.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  product.store,
                                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text(
                                  '${product.price.toStringAsFixed(2)} ₽',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentLightColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final ProductCard product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: accentLightColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: 220,
                  height: 220,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 8),
            Text(product.store, style: const TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 8),
            Text('${product.price.toStringAsFixed(2)} ₽', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: accentLightColor)),
            const SizedBox(height: 18),
            Text(product.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}