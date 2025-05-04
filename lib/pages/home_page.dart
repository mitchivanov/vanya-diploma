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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<bool> _inCart; // Список для отслеживания товаров в корзине
  late List<bool> _inFavorites; // Список для отслеживания избранных товаров

  @override
  void initState() {
    super.initState();
    final products = ProductData.getProducts();
    _inCart = List.generate(products.length, (index) => false);
    _inFavorites = List.generate(products.length, (index) => false);
  }

  void _openProductPage(BuildContext context, ProductCard product, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductDetailPage(
        product: product, 
        index: index,
        inCart: _inCart[index],
        inFavorite: _inFavorites[index],
        onCartChanged: (value) => setState(() => _inCart[index] = value),
        onFavoriteChanged: (value) => setState(() => _inFavorites[index] = value),
      )),
    );
  }

  void _toggleCart(int index) {
    setState(() {
      _inCart[index] = !_inCart[index];
      
      // Здесь вы можете вызвать метод добавления в корзину из родительского виджета
      // Например, если вы используете Provider, BLoC или передаете callback из DistributionPage
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      _inFavorites[index] = !_inFavorites[index];
      
      // Здесь вы можете вызвать метод добавления в избранное из родительского виджета
    });
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
                              Column(
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${product.price.toStringAsFixed(2)} ₽',
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accentLightColor),
                                        ),
                                        Row(
                                          children: [
                                            // Кнопка добавления в избранное
                                            GestureDetector(
                                              onTap: () => _toggleFavorite(index),
                                              child: Icon(
                                                _inFavorites[index] ? Icons.favorite : Icons.favorite_border,
                                                color: _inFavorites[index] ? Colors.red : Colors.grey,
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Кнопка добавления в корзину
                                            GestureDetector(
                                              onTap: () => _toggleCart(index),
                                              child: Icon(
                                                _inCart[index] ? Icons.shopping_cart : Icons.add_shopping_cart_outlined,
                                                color: _inCart[index] ? accentLightColor : Colors.grey,
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
      widget.onFavoriteChanged(_inFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: accentLightColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: accentBlueColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          // Кнопка добавления в избранное
          IconButton(
            icon: Icon(
              _inFavorite ? Icons.favorite : Icons.favorite_border,
              color: _inFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
          // Кнопка добавления в корзину
          IconButton(
            icon: Icon(
              _inCart ? Icons.shopping_cart : Icons.add_shopping_cart_outlined,
              color: _inCart ? accentGoldColor : Colors.white,
            ),
            onPressed: _toggleCart,
          ),
        ],
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