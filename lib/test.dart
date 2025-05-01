import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List<Map<String, dynamic>> items = [
    {
      "name": "Молоко",
      "image": 'lib/assets/pictures/idea1.jpg',
      "description": "Свежие молочные продукты.",
      "price": 1.99,
      "store": "Wildberies",
    },
    {
      "name": "Хлеб",
      "image": 'lib/assets/pictures/idea2.jpg',
      "description": "Хрустящий хлеб из муки высшего сорта.",
      "price": 0.99,
      "store": "Ozon",
    },
    {
      "name": "Яблоки",
      "image": 'lib/assets/pictures/idea3.jpg',
      "description": "Сочные яблоки, собранные с лучших садов.",
      "price": 2.49,
      "store": "Ozon",
    },
    {
      "name": "Бананы",
      "image": 'lib/assets/pictures/idea4.jpg',
      "description": "Спелые бананы, идеальные для перекуса.",
      "price": 1.29,
      "store": "Яндекс market",
    },
    {
      "name": "Кофе",
      "image": 'lib/assets/pictures/1.png',
      "description": "Ароматный кофе для бодрого утра.",
      "price": 3.99,
      "store": "Яндекс market",
    },
    {
      "name": "Вода",
      "image": 'lib/assets/pictures/disc1.jpg',
      "description": "Чистая питьевая вода.",
      "price": 0.50,
      "store": "Ozon",
    },
  ];

  final List<String> cartItems = [];
  String searchQuery = '';

  void updateCartItems(String item, bool isAdded) {
    setState(() {
      if (isAdded) {
        cartItems.add(item);
      } else {
        cartItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Фильтруем товары по поисковому запросу
    final filteredItems = items.where((item) {
      return item['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Товары')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Поиск',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  item: filteredItems[index],
                  isAddedToCart: cartItems.contains(filteredItems[index]['name']),
                  onCartUpdate: updateCartItems,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(
                      cartItems: cartItems,
                      onCartUpdate: updateCartItems,
                    ),
                  ),
                );
              },
              child: Text('Перейти в корзину'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isAddedToCart;
  final Function(String, bool) onCartUpdate;

  ProductCard({required this.item, required this.isAddedToCart, required this.onCartUpdate});

  void toggleCartStatus() {
    onCartUpdate(item['name'], !isAddedToCart);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(item['image']),
        title: Text(item['name']),
        subtitle: Text('${item['description']}\nЦена: ${item['price']}₽\nМагазин: ${item['store']}'),
        trailing: IconButton(
          icon: Icon(isAddedToCart ? Icons.check : Icons.add),
          onPressed: toggleCartStatus,
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final List<String> cartItems;
  final Function(String, bool) onCartUpdate;

  SecondPage({required this.cartItems, required this.onCartUpdate});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late List<String> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems); // Копируем список товаров
  }

  void removeItem(String item) {
    setState(() {
      cartItems.remove(item);
      widget.onCartUpdate(item, false); // Обновляем состояние корзины
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Корзина')),
      body: cartItems.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(cartItems[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  removeItem(cartItems[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}