import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/product_data.dart';
import '../data/product_card.dart';
import '../widgets/unified_appbar.dart';
import '../data/colors/main_colors.dart';
import '../utils/favorite_model.dart';
import 'home_page.dart';

class ProductListByCategoryPage extends StatefulWidget {
  final String category;
  const ProductListByCategoryPage({super.key, required this.category});

  @override
  _ProductListByCategoryPageState createState() => _ProductListByCategoryPageState();
}

class _ProductListByCategoryPageState extends State<ProductListByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final products = ProductData.getProducts().where((p) => p.category == widget.category).toList();
    
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: UnifiedAppBar(title: widget.category, showBack: true),
      body: products.isEmpty
          ? const Center(child: Text('Нет товаров в этой категории'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () => _openProductPage(context, product, index),
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
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              child: Column(
                                children: [
                                  // Фиксированное изображение 
                                  SizedBox(
                                    width: double.infinity,
                                    height: 130,
                                    child: Image.asset(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Нижняя белая часть с закруглениями
                                  Expanded(
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Название
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 2),
                                            child: Text(
                                              product.title,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          // Магазин
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                                            child: Text(
                                              product.store,
                                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          // Кнопка и сердечко в отдельном контейнере с закруглениями
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                            child: Row(
                                              children: [
                                                // Сердечко
                                                SizedBox(
                                                  width: 28,
                                                  height: 32,
                                                  child: ValueListenableBuilder<int>(
                                                    valueListenable: FavoriteModel.of(context).notifier,
                                                    builder: (context, value, child) {
                                                      final isFavorite = FavoriteModel.of(context).contains(product);
                                                      return IconButton(
                                                        padding: EdgeInsets.zero,
                                                        iconSize: 20,
                                                        icon: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey,
                                                        ),
                                                        onPressed: () => _toggleFavorite(product),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                // Кнопка/счетчик
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 32,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.zero,
                                                        backgroundColor: accentGoldColor,
                                                        foregroundColor: Colors.black,
                                                        elevation: 2,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) => ProductDetailPage(
                                                              product: product,
                                                              index: index,
                                                              inFavorite: FavoriteModel.of(context).contains(product),
                                                              onFavoriteChanged: (value) {
                                                                FavoriteModel.of(context).toggle(product);
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          '${product.price.toStringAsFixed(0)} ₽',
                                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
  
  void _openProductPage(BuildContext context, ProductCard product, int index) {
    final favoriteModel = FavoriteModel.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductDetailPage(
        product: product,
        index: index,
        inFavorite: favoriteModel.contains(product),
        onFavoriteChanged: (value) {
          favoriteModel.toggle(product);
          setState(() {});
        },
      )),
    );
  }

  void _toggleFavorite(ProductCard product) {
    FavoriteModel.of(context).toggle(product);
  }
} 