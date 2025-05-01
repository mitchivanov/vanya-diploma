import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      home: MainPage(),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String image;
  final double price;
  final String store;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.store,
  });
}

class ProductData {
  static List<Product> getProducts() {
    return [
      Product(
        name: "Молоко",
        description: "Свежие молочные продукты.",
        image: 'lib/assets/pictures/idea1.jpg',
        price: 1.99,
        store: "Wildberies",
      ),
      Product(
        name: "Хлеб",
        description: "Хрустящий хлеб из муки высшего сорта.",
        image: 'lib/assets/pictures/idea2.jpg',
        price: 0.99,
        store: "Ozon",
      ),
      Product(
        name: "Яблоки",
        description: "Сочные яблоки, собранные с лучших садов."*10,
        image: 'lib/assets/pictures/idea3.jpg',
        price: 2.49,
        store: "Ozon",
      ),
      Product(
        name: "Бананы",
        description: "Спелые бананы, идеальные для перекуса.",
        image: 'lib/assets/pictures/idea3.jpg',
        price: 2.49,
        store: "Ozon",
      ),
    ];
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Product> products = ProductData.getProducts();
  final List<Product> cartItems = [];

  void updateCartItems(Product item, bool isAdded) {
    setState(() {
      if (isAdded) {
        cartItems.add(item);
      } else {
        cartItems.removeWhere((cartItem) => cartItem.name == item.name);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? HomePage()
          : _selectedIndex == 1
          ? ProductsPage(
        products: products,
        cartItems: cartItems,
        onCartUpdate: updateCartItems,
      )
          : CartPage(
        cartItems: cartItems,
        onCartUpdate: updateCartItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Добро пожаловать в магазин!',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  final List<Product> products;
  final List<Product> cartItems;
  final Function(Product, bool) onCartUpdate;

  ProductsPage({required this.products, required this.cartItems, required this.onCartUpdate});

  @override
  Widget build(BuildContext context) {
    String searchQuery = '';

    // Фильтруем товары по поисковому запросу
    final filteredItems = products.where((item) {
      return item.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Убираем фокус с текстового поля
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Поиск',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchQuery = value;
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  item: filteredItems[index],
                  isAddedToCart: cartItems.any((cartItem) => cartItem.name == filteredItems[index].name),
                  onCartUpdate: onCartUpdate,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product item;
  final bool isAddedToCart;
  final Function(Product, bool) onCartUpdate;

  ProductCard({required this.item, required this.isAddedToCart, required this.onCartUpdate});

  void toggleCartStatus() {
    onCartUpdate(item, !isAddedToCart);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(item.image),
        title: Text(item.name),
        subtitle: Text('${item.description}\nЦена: ${item.price}₽\nМагазин: ${item.store}'),
        trailing: IconButton(
          icon: Icon(isAddedToCart ? Icons.check : Icons.add),
          onPressed: toggleCartStatus,
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> cartItems;
  final Function(Product, bool) onCartUpdate;

  CartPage({required this.cartItems, required this.onCartUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Корзина')),
      body: cartItems.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Card(
            child: ListTile(
              leading: Image.asset(item.image),
              title: Text(item.name),
              subtitle: Text('${item.description}\nЦена: ${item.price}₽\nМагазин: ${item.store}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  onCartUpdate(item, false); // Удаляем товар из корзины
                },
              ),
            ),
          );
        },
      ),
    );
  }
}