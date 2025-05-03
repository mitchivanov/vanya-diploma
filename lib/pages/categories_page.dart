import 'package:flutter/material.dart';
import 'package:gift_app/widgets/button_with_image_widget.dart';
import 'package:gift_app/widgets/categories_list_widget.dart';
import 'package:gift_app/pages/product_list_page.dart';
import '../data/colors/main_colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        toolbarHeight: 53,
        backgroundColor: accentLightColor,
        title: const Text('Категории'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20)
            )
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    print('Поисковый запрос: $value');
                  },
                  decoration: const InputDecoration(
                    hintText: 'Поиск...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            // Список категорий
            Expanded(
              child: categoriesList(context),
            ),
          ],
        ),
      ),
    );
  }
}