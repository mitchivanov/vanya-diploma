import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/colors/main_colors.dart';
import '../data/icons.dart';
import '../widgets/abs_widget.dart';
import '../widgets/discount_widget.dart';
import '../widgets/ideas_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/transition_clipper.dart';
import '../data/product_data.dart' show ProductData, SmartSearch;
import '../data/product_card.dart';
import 'categories_page.dart';
import 'distribution_page.dart';
import '../utils/favorite_model.dart';
import '../widgets/unified_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductCard> _filteredProducts = [];
  List<ProductCard> _allProducts = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _allProducts = ProductData.getProducts();
    _filteredProducts = _allProducts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) async {
    setState(() {
      _isSearching = true;
    });
    
    // Имитируем задержку загрузки для лучшего UX (2 секунды)
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _filteredProducts = SmartSearch.search(query, _allProducts);
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
    return MaterialApp(
      title: 'Gift Portal',
      theme: ThemeData(scaffoldBackgroundColor: primaryLightColor),
      home: Scaffold(
        backgroundColor: primaryLightColor,
        appBar: const UnifiedAppBar(title: 'Gift Portal'),
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
                          color: Color(0xFF7606EA),
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
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Найти товары',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: _searchController.text.isNotEmpty 
                              ? IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.grey),
                                  onPressed: () {
                                    _searchController.clear();
                                    _performSearch('');
                                  },
                                )
                              : null,
                          ),
                          style: const TextStyle(fontSize: 16),
                          onChanged: (value) => _performSearch(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Подсказки по поиску
              if (_searchController.text.isEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      _buildSearchChip('книги'),
                      _buildSearchChip('дешево'),
                      _buildSearchChip('подарок папе'),
                      _buildSearchChip('подарок бабушке'),
                      _buildSearchChip('автотовары'),
                      _buildSearchChip('украшения'),
                    ],
                  ),
                ),
              // Индикатор результатов поиска
              if (_searchController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                    'Найдено товаров: ${products.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              // Список товаров
              Expanded(
                child: _isSearching 
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(accentLightColor),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Поиск товаров...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                                    child: SizedBox(
                                                      height: 32, // Фиксированная высота для названия
                                                      child: Text(
                                                        product.title,
                                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  // Категория
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
                                                    child: Container(
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

  Widget _buildSearchChip(String label) {
    return GestureDetector(
      onTap: () {
        _searchController.text = label;
        _performSearch(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: accentGoldColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentGoldColor.withOpacity(0.5)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  final ProductCard product;
  final int index;
  final bool inFavorite;
  final Function(bool) onFavoriteChanged;

  const ProductDetailPage({
    super.key, 
    required this.product, 
    required this.index,
    required this.inFavorite,
    required this.onFavoriteChanged,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnifiedAppBar(
        title: widget.product.title,
        showBack: true,
        centerTitle: false,
        onBack: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              // Категория товара
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF7606EA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF7606EA).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.product.category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7606EA),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                  ValueListenableBuilder<int>(
                    valueListenable: FavoriteModel.of(context).notifier,
                    builder: (context, value, child) {
                      final isFavorite = FavoriteModel.of(context).contains(widget.product);
                      return ElevatedButton.icon(
                        onPressed: () {
                          FavoriteModel.of(context).toggle(widget.product);
                        },
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                        label: Text(isFavorite ? 'Убрать из избранного' : 'В избранное'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFavorite ? Colors.red.shade200 : accentGoldColor,
                          foregroundColor: Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(widget.product.description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              // Кнопка копирования ссылки
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: widget.product.productUrl));
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ссылка скопирована в буфер обмена!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.link, color: Colors.white),
                  label: const Text('Скопировать ссылку на товар', style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(vertical: 12),
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