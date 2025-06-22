class ProductCard {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final String store;
  final String category;
  final String productUrl;

  ProductCard({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.store,
    required this.category,
    required this.productUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'title': title,
    'description': description,
    'price': price,
    'store': store,
    'category': category,
    'productUrl': productUrl,
  };

  factory ProductCard.fromJson(Map<String, dynamic> json) => ProductCard(
    id: json['id'],
    imageUrl: json['imageUrl'],
    title: json['title'],
    description: json['description'],
    price: (json['price'] as num).toDouble(),
    store: json['store'],
    category: json['category'],
    productUrl: json['productUrl'] ?? '',
  );
} 