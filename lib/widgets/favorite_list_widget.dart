import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

void addToWishlist(Product product, List<Product> wishList) {
  wishList.add(product);
}

Widget wishListAdd(BuildContext context) {
  List<Product> wishList = [];
  return Column(
    children: [
      ElevatedButton(
        onPressed: () {
          // Пример добавления товара
          addToWishlist(Product(id: 1, name: 'Товар', price: 20.0), wishList);
        },
        child: Text('Добавить товар в список желаемого'),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: wishList.length,
          itemBuilder: (context, index) {
            final product = wishList[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
            );
          },
        ),
      ),
    ],
  );
}
