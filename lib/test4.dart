import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MainPage(),
    ProductsPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Главная',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Товары'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExtraPage()),
            );
          },
          child: Text('Открыть дополнительную страницу'),
        ),
      ),
    );
  }
}

class ExtraPage extends StatefulWidget {
  @override
  _ExtraPageState createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
  final List<String> _products = ['Товар 1', 'Товар 2', 'Товар 3'];
  final Map<String, bool> _selectedProducts = {};

  @override
  void initState() {
    super.initState();
    // Загружаем состояние выбранных товаров из корзины
    _loadSelectedProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addToCart(String product) {
    if (!CartPage.cartItems.contains(product)) {
      setState(() {
        _selectedProducts[product] = true;
      });
      CartPage.cartItems.add(product);
    }
  }

  void _removeFromCart(String product) {
    setState(() {
      _selectedProducts[product] = false;
    });
    CartPage.cartItems.remove(product);
  }

  void _loadSelectedProducts() {
    for (var product in _products) {
      _selectedProducts[product] = CartPage.cartItems.contains(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Дополнительная страница'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product),
            trailing: _selectedProducts[product] == true
                ? IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () => _removeFromCart(product),
            )
                : IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _addToCart(product),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  static List<String> cartItems = [];

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeFromCart(String product) {
    setState(() {
      CartPage.cartItems.remove(product);
    });
    // Уведомляем ExtraPage, чтобы удалить продукт из состояния выбора
    final extraPageState = context.findAncestorStateOfType<_ExtraPageState>();
    if (extraPageState != null) {
      extraPageState._removeFromCart(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: CartPage.cartItems.isEmpty
          ? Center(
        child: Text(
          'Корзина пуста',
          style: TextStyle(fontSize: 24),
        ),
      )
          : ListView.builder(
        itemCount: CartPage.cartItems.length,
        itemBuilder: (context, index) {
          final product = CartPage.cartItems[index];
          return ListTile(
            title: Text(product),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeFromCart(product),
            ),
          );
        },
      ),
    );
  }
}