import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/colors/main_colors.dart';
import '../utils/favorite_model.dart';
import '../data/product_card.dart';
import '../utils/cart_model.dart';
import 'home_page.dart' show ProductDetailPage;
import '../widgets/unified_appbar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void _openProductPage(BuildContext context, ProductCard product) {
    final cart = CartModel.of(context);
    final favorite = FavoriteModel.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductDetailPage(
        product: product,
        index: 0,
        inCart: cart.items.any((item) => item.product.title == product.title),
        inFavorite: favorite.contains(product),
        onCartChanged: (value) {
          if (value) {
            cart.add(product);
          } else {
            cart.remove(product);
          }
          setState(() {});
        },
        onFavoriteChanged: (value) {
          favorite.toggle(product);
          setState(() {});
        },
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favorite = FavoriteModel.of(context);
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: const UnifiedAppBar(title: 'Gift Finder'),
      body: ValueListenableBuilder<int>(
        valueListenable: favorite.notifier,
        builder: (context, _, __) {
          if (favorite.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: accentLightColor.withOpacity(0.7)),
                  const SizedBox(height: 16),
                  Text(
                    'Нет избранных товаров',
                    style: GoogleFonts.merriweather(
                      textStyle: TextStyle(fontSize: 22, color: accentLightColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Добавьте товары с главной страницы',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: favorite.items.length,
            itemBuilder: (context, index) {
              final ProductCard product = favorite.items[index];
              return GestureDetector(
                onTap: () => _openProductPage(context, product),
                child: Stack(
                  children: [
                    Container(
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
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                            child: Image.asset(
                              product.imageUrl,
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.store,
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${product.price.toStringAsFixed(2)} ₽',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: accentLightColor)),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          favorite.remove(product);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}