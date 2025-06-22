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
                  childAspectRatio: 0.68,
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
                                  // Изображение товара
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                                    child: Image.asset(
                                      product.imageUrl,
                                      height: 130,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Информация о товаре
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Название
                                          SizedBox(
                                            height: 32, // Фиксированная высота для названия
                                            child: Text(
                                              product.title,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Категория
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF7606EA).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                color: const Color(0xFF7606EA).withOpacity(0.3),
                                                width: 0.5,
                                              ),
                                            ),
                                            child: Text(
                                              product.category,
                                              style: const TextStyle(
                                                fontSize: 9,
                                                color: Color(0xFF7606EA),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Магазин
                                          Text(
                                            product.store,
                                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                                          ),
                                          const Spacer(),
                                          // Цена и действия
                                          Row(
                                            children: [
                                              // Кнопка добавления в избранное
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
                                              // Кнопка с ценой
                                              Expanded(
                                                child: SizedBox(
                                                  height: 32,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      backgroundColor: const Color(0xFFFFD700),
                                                      foregroundColor: Colors.black,
                                                      elevation: 2,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      _openProductPage(context, product, index);
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