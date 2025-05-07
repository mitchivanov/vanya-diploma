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
import 'distribution_page.dart';
import '../utils/cart_model.dart';
import '../utils/favorite_model.dart';
import '../widgets/unified_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final products = ProductData.getProducts();
    final cart = CartModel.of(context);
    return MaterialApp(
      title: 'Gift app',
      theme: ThemeData(scaffoldBackgroundColor: primaryLightColor),
      home: Scaffold(
        backgroundColor: primaryLightColor,
        appBar: const UnifiedAppBar(title: 'Gift Finder'),
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
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final inCart = CartModel.of(context).items.any((item) => item.product.title == product.title);
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
                              // 1. Фоновое изображение
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
                                                      child: IconButton(
                                                        padding: EdgeInsets.zero,
                                                        iconSize: 20,
                                                        icon: Icon(
                                                          FavoriteModel.of(context).contains(product) ? Icons.favorite : Icons.favorite_border,
                                                          color: FavoriteModel.of(context).contains(product) ? Colors.red : Colors.grey,
                                                        ),
                                                        onPressed: () => _toggleFavorite(product),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    // Кнопка/счетчик
                                                    Expanded(
                                                      child: Builder(
                                                        builder: (context) {
                                                          final cartItem = CartModel.of(context).items.firstWhere(
                                                            (item) => item.product.title == product.title,
                                                            orElse: () => CartItem(product: product, quantity: 0),
                                                          );
                                                          final quantity = cartItem.quantity;
                                                          if (quantity == 0) {
                                                            return SizedBox(
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
                                                                  CartModel.of(context).add(product);
                                                                  setState(() {});
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                    '${product.price.toStringAsFixed(0)} ₽',
                                                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            return Container(
                                                              height: 32,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(color: accentLightColor, width: 0.8),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 32,
                                                                    height: 32,
                                                                    child: IconButton(
                                                                      padding: EdgeInsets.zero,
                                                                      iconSize: 16,
                                                                      icon: const Icon(Icons.remove, color: Colors.red),
                                                                      onPressed: () {
                                                                        CartModel.of(context).remove(product);
                                                                        setState(() {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '$quantity',
                                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 32,
                                                                    height: 32,
                                                                    child: IconButton(
                                                                      padding: EdgeInsets.zero,
                                                                      iconSize: 16,
                                                                      icon: const Icon(Icons.add, color: Colors.green),
                                                                      onPressed: () {
                                                                        CartModel.of(context).add(product);
                                                                        setState(() {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        },
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
              ),
            ],
          ),
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
        inCart: CartModel.of(context).items.any((item) => item.product.title == product.title),
        inFavorite: favoriteModel.contains(product),
        onCartChanged: (value) {
          if (value) {
            CartModel.of(context).add(product);
          } else {
            CartModel.of(context).remove(product);
          }
          setState(() {});
        },
        onFavoriteChanged: (value) {
          favoriteModel.toggle(product);
          setState(() {});
        },
      )),
    );
  }

  void _toggleFavorite(ProductCard product) {
    FavoriteModel.of(context).toggle(product);
    setState(() {});
  }
}

class ProductDetailPage extends StatefulWidget {
  final ProductCard product;
  final int index;
  final bool inCart;
  final bool inFavorite;
  final Function(bool) onCartChanged;
  final Function(bool) onFavoriteChanged;

  const ProductDetailPage({
    super.key, 
    required this.product, 
    required this.index,
    required this.inCart,
    required this.inFavorite,
    required this.onCartChanged,
    required this.onFavoriteChanged,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late bool _inCart;
  late bool _inFavorite;

  @override
  void initState() {
    super.initState();
    _inCart = widget.inCart;
    _inFavorite = widget.inFavorite;
  }

  void _toggleCart() {
    setState(() {
      _inCart = !_inCart;
      widget.onCartChanged(_inCart);
    });
  }

  void _toggleFavorite() {
    setState(() {
      _inFavorite = !_inFavorite;
      if (_inFavorite) {
        FavoriteModel.of(context).add(widget.product);
      } else {
        FavoriteModel.of(context).remove(widget.product);
      }
      widget.onFavoriteChanged(_inFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnifiedAppBar(
        title: widget.product.title,
        showBack: true,
        centerTitle: false,
        onBack: () => Navigator.of(context).pop(),
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
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                  width: 220,
                  height: 220,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(widget.product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 8),
            Text(widget.product.store, style: const TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.product.price.toStringAsFixed(2)} ₽', 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: accentLightColor)
                ),
                ElevatedButton.icon(
                  onPressed: _toggleCart,
                  icon: Icon(_inCart ? Icons.shopping_cart : Icons.add_shopping_cart),
                  label: Text(_inCart ? 'Убрать из корзины' : 'В корзину'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _inCart ? Colors.red.shade200 : accentGoldColor,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(widget.product.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}