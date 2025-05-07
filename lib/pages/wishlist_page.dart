import 'package:flutter/material.dart';
import '../widgets/unified_appbar.dart';

class WishlistPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>, bool) onCartUpdate;

  WishlistPage({required this.cartItems, required this.onCartUpdate});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<Map<String, dynamic>> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems); // Копируем список товаров
  }

  void removeItem(Map<String, dynamic> item) {
    setState(() {
      cartItems.removeWhere((cartItem) => cartItem['name'] == item['name']);
      widget.onCartUpdate(item, false); // Обновляем состояние корзины
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UnifiedAppBar(title: 'Gift Finder', showBack: true),
      body: cartItems.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Card(
            child: ListTile(
              leading: Image.network(item['image']),
              title: Text(item['name']),
              subtitle: Text('${item['description']}\nЦена: ${item['price']}₽\nМагазин: ${item['store']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Удаляем товар из корзины
                  removeItem(item);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}