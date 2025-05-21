import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gift_portal/widgets/categories_list_widget.dart';
import 'package:gift_portal/widgets/unified_appbar.dart';
import 'product_list_by_category_page.dart';

import '../data/colors/main_colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  static final List<Map<String, String>> categories = [
    {"title": "Электроника", "image": "lib/assets/category_placeholder.png"},
    {"title": "Одежда", "image": "lib/assets/category_placeholder.png"},
    {"title": "Книги", "image": "lib/assets/category_placeholder.png"},
    {"title": "Игрушки", "image": "lib/assets/category_placeholder.png"},
    {"title": "Дом", "image": "lib/assets/category_placeholder.png"},
    {"title": "Красота", "image": "lib/assets/category_placeholder.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: const UnifiedAppBar(title: 'Gift Portal', showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 0.95,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _CategoryCard(
              title: category["title"]!,
              image: category["image"]!,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductListByCategoryPage(category: category["title"]!),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;
  const _CategoryCard({required this.title, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF0A1A4A),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}