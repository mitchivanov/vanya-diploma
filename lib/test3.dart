import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, String>> cartItems = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeScreen(),
      ProductsScreen(addToCart: addToCart),
      CartScreen(cartItems: cartItems, removeFromCart: removeFromCart),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Обновляем корзину при переключении на нее
      if (index == 2) {
        _pages[2] = CartScreen(cartItems: cartItems, removeFromCart: removeFromCart);
      }
    });
  }

  void addToCart(Map<String, String> product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void removeFromCart(Map<String, String> product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce App'),
      ),
      body: _pages[_selectedIndex],
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Добро пожаловать на главную страницу!'),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  final Function(Map<String, String>) addToCart;

  ProductsScreen({required this.addToCart});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Map<String, String>> products = [
    {
      'name': 'Товар 1',
      'description': 'Описание товара 1',
      'price': '100₽',
    },
    {
      'name': 'Товар 2',
      'description': 'Описание товара 2',
      'price': '200₽',
    },
    {
      'name': 'Товар 3',
      'description': 'Описание товара 3',
      'price': '300₽',
    },
  ];

  late List<bool> _isAddedToCart;

  @override
  void initState() {
    super.initState();
    _isAddedToCart = List<bool>.filled(products.length, false);
  }

  void _toggleCart(int index) {
    setState(() {
      _isAddedToCart[index] = !_isAddedToCart[index];
      if (_isAddedToCart[index]) {
        widget.addToCart(products[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Товары'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondProductsScreen(addToCart: widget.addToCart),
                ),
              );
            },
            child: Text('Перейти на вторую страницу товаров'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(products[index]['name']!),
                    subtitle: Text('${products[index]['description']} - ${products[index]['price']}'),
                    trailing: IconButton(
                      icon: Icon(
                        _isAddedToCart[index] ? Icons.check : Icons.add,
                        color: _isAddedToCart[index] ? Colors.green : null,
                      ),
                      onPressed: () => _toggleCart(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SecondProductsScreen extends StatefulWidget {
  final Function(Map<String, String>) addToCart;

  SecondProductsScreen({required this.addToCart});

  @override
  _SecondProductsScreenState createState() => _SecondProductsScreenState();
}

class _SecondProductsScreenState extends State<SecondProductsScreen> {
  final List<Map<String, String>> additionalProducts = [
    {
      'name': 'Товар 4',
      'description': 'Описание товара 4',
      'price': '400₽',
    },
    {
      'name': 'Товар 5',
      'description': 'Описание товара 5',
      'price': '500₽',
    },
    {
      'name': 'Товар 6',
      'description': 'Описание товара 6',
      'price': '600₽',
    },
  ];

  late List<bool> _isAddedToCart;

  @override
  void initState() {
    super.initState();
    _isAddedToCart = List<bool>.filled(additionalProducts.length, false);
  }

  void _toggleCart(int index) {
    setState(() {
      _isAddedToCart[index] = !_isAddedToCart[index];
      if (_isAddedToCart[index]) {
        widget.addToCart(additionalProducts[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Дополнительные товары'),
      ),
      body: ListView.builder(
        itemCount: additionalProducts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(additionalProducts[index]['name']!),
              subtitle: Text('${additionalProducts[index]['description']} - ${additionalProducts[index]['price']}'),
              trailing: IconButton(
                icon: Icon(
                  _isAddedToCart[index] ? Icons.check : Icons.add,
                  color: _isAddedToCart[index] ? Colors.green : null,
                ),
                onPressed: () => _toggleCart(index),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cartItems;
  final Function(Map<String, String>) removeFromCart;

  CartScreen({required this.cartItems, required this.removeFromCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text('Корзина пуста. Добавьте товары!'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(cartItems[index]['name']!),
              subtitle: Text('${cartItems[index]['description']} - ${cartItems[index]['price']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Удаляем товар из корзины
                  removeFromCart(cartItems[index]);
                  // Обновляем состояние корзины
                  // Здесь не нужно использовать Navigator.pop() или Navigator.pushReplacement()
                  // Просто вызываем setState, чтобы обновить UI
                  // В этом случае, если CartScreen был создан с помощью StatefulWidget,
                  // вы можете использовать setState для обновления состояния.
                },
              ),
            ),
          );
        },
      ),
    );
  }
}