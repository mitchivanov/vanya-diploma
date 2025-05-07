// import '../pages/distribution_page.dart';
//
// class ProductData {
//   static List<Product> getProducts() {
//     return [
//       Product(
//         name: "Молоко",
//         description: "Свежие молочные продукты.",
//         image: 'lib/assets/pictures/idea1.jpg',
//         price: 1.99,
//         store: "Wildberies",
//       ),
//       Product(
//         name: "Хлеб",
//         description: "Хрустящий хлеб из муки высшего сорта.",
//         image: 'lib/assets/pictures/idea2.jpg',
//         price: 0.99,
//         store: "Ozon",
//       ),
//       Product(
//         name: "Яблоки",
//         description: "Сочные яблоки, собранные с лучших садов."*10,
//         image: 'lib/assets/pictures/idea3.jpg',
//         price: 2.49,
//         store: "Ozon",
//       ),
//       Product(
//         name: "Бананы",
//         description: "Спелые бананы, идеальные для перекуса.",
//         image: 'lib/assets/pictures/idea3.jpg',
//         price: 2.49,
//         store: "Ozon",
//       ),
//     ];
//   }
// }

import 'product_card.dart';

class ProductData {
  static List<ProductCard> getProducts() {
    return [
      ProductCard(
        title: "Книга \"Двенадцать стульев\"",
        description: "Книга о приключениях мальчика, который отправился в путешествие по миру.",
        imageUrl: 'lib/assets/pictures/good1.png',
        price: 1.99,
        store: "Wildberies",
        category: "Книги",
      ),
      ProductCard(
        title: "Кроссовки летние спортивные для подростка",
        description: "Кроссовки для подростка, которые помогут ему в путешествии по миру.",
        imageUrl: 'lib/assets/pictures/good2.png',
        price: 0.99,
        store: "Ozon",
        category: "Одежда",
      ),
      ProductCard(
        title: "Princess Принцесс духи женские",
        description: "Духи для женщин, которые помогут ей в путешествии по миру.",
        imageUrl: 'lib/assets/pictures/good3.png',
        price: 2.49,
        store: "Ozon",
        category: "Красота",
      ),
      ProductCard(
        title: "Маскхалат камуфляжный летний костюм горка",
        description: "Стрелять нациков пиф паф СВО Россия вперёд! За Путина!",
        imageUrl: 'lib/assets/pictures/good4.png',
        price: 2.49,
        store: "Ozon",
        category: "Одежда",
      ),
      ProductCard(
        title: "Смарт-часы X1000",
        description: "Умные часы с множеством функций для спорта и жизни.",
        imageUrl: 'lib/assets/pictures/good1.png',
        price: 5.99,
        store: "Wildberies",
        category: "Электроника",
      ),
      ProductCard(
        title: "Мягкая игрушка Медведь",
        description: "Плюшевый медведь для детей и взрослых.",
        imageUrl: 'lib/assets/pictures/good2.png',
        price: 3.49,
        store: "Ozon",
        category: "Игрушки",
      ),
      ProductCard(
        title: "Декоративная подушка",
        description: "Яркая подушка для украшения дома.",
        imageUrl: 'lib/assets/pictures/good3.png',
        price: 2.19,
        store: "Ozon",
        category: "Дом",
      ),
    ];
  }
}