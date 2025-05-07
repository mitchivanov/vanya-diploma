class ProductCard {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final String store;
  final String category;

  ProductCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.store,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'title': title,
    'description': description,
    'price': price,
    'store': store,
    'category': category,
  };

  factory ProductCard.fromJson(Map<String, dynamic> json) => ProductCard(
    imageUrl: json['imageUrl'],
    title: json['title'],
    description: json['description'],
    price: (json['price'] as num).toDouble(),
    store: json['store'],
    category: json['category'],
  );
} 