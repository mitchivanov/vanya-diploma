import 'package:flutter/material.dart';
import 'package:gift_app/widgets/button_with_image_widget.dart';
import 'package:gift_app/widgets/categories_list_widget.dart';
import 'package:gift_app/pages/product_list_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift app',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF00FFF0)),
      home: Scaffold(
          // extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            toolbarHeight: 53,
            title: Container(
              margin: const EdgeInsets.all(15),
              height: 37,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  print('Submitted: $value');
                },
                decoration: const InputDecoration(
                  hintText: 'Поиск...',
                  hintStyle: TextStyle(fontSize: 18),
                  contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20)
                )
            ),
          ),
        body: categoriesList(context)
      ),
    );
  }
}