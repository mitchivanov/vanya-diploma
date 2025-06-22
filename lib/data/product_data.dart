import 'product_card.dart';

class SmartSearch {
  static const Map<String, List<String>> searchMappings = {
    // Книги
    'читать': ['Книги'],
    'книга': ['Книги'],
    'литература': ['Книги'],
    'роман': ['Книги'],
    'стулья': ['Книги'], // для "Двенадцати стульев"
    
    // Одежда
    'одежда': ['Одежда'],
    'носить': ['Одежда'],
    'кроссовки': ['Одежда'],
    'обувь': ['Одежда'],
    'спорт': ['Одежда'],
    'лето': ['Одежда'],
    'камуфляж': ['Одежда'],
    'военный': ['Одежда'],
    
    // Красота
    'красота': ['Красота'],
    'духи': ['Красота'],
    'парфюм': ['Красота'],
    'запах': ['Красота'],
    'принцесса': ['Красота'],
    
    // Электроника
    'электроника': ['Электроника'],
    'технологии': ['Электроника'],
    'часы': ['Электроника'],
    'смарт': ['Электроника'],
    'умный': ['Электроника'],
    'гаджет': ['Электроника'],
    
    // Игрушки
    'игрушки': ['Игрушки'],
    'дети': ['Игрушки'],
    'медведь': ['Игрушки'],
    'плюшевый': ['Игрушки'],
    'мягкий': ['Игрушки'],
    
    // Дом
    'дом': ['Дом'],
    'интерьер': ['Дом'],
    'подушка': ['Дом'],
    'декор': ['Дом'],
    'украшение': ['Дом'],
    
    // Новые категории
    'украшения': ['Украшения'],
    'кулон': ['Украшения'],
    'серебро': ['Украшения'],
    'ювелирные': ['Украшения'],
    
    'инструменты': ['Инструменты'],
    'ключ': ['Инструменты'],
    'ремонт': ['Инструменты'],
    'строительство': ['Инструменты'],
    
    'автотовары': ['Автотовары'],
    'авто': ['Автотовары'],
    'машина': ['Автотовары'],
    'стеклоочиститель': ['Автотовары'],
    'щетки': ['Автотовары'],
    'автомобиль': ['Автотовары'],
    
    // Подарки для разных людей
    'подарок папе': ['подарок_папе'],
    'папе': ['подарок_папе'],
    'отцу': ['подарок_папе'],
    'мужчине': ['подарок_папе'],
    'увлекающегося автомобилями': ['подарок_папе'],
    'автомобилями': ['подарок_папе'],
    'подарок папе увлекающегося автомобилями': ['подарок_папе'],
    
    'подарок бабушке': ['подарок_бабушке'],
    'бабушке': ['подарок_бабушке'],
    'пожилой женщине': ['подарок_бабушке'],
    'подарок бабушке на день рождения': ['подарок_бабушке'],
    'день рождения': ['подарок_универсальный'],
    
    // Магазины
    'вайлдберриз': ['Wildberies'],
    'wildberries': ['Wildberies'],
    'wb': ['Wildberies'],
    'озон': ['Ozon'],
    'ozon': ['Ozon'],
    
    // Цены
    'дешево': ['низкая_цена'],
    'дорого': ['высокая_цена'],
    'скидка': ['все'],
    'акция': ['все'],
  };
  
  static List<ProductCard> search(String query, List<ProductCard> allProducts) {
    if (query.isEmpty) return allProducts;
    
    query = query.toLowerCase().trim();
    List<ProductCard> results = [];
    
    // Прямой поиск по названию, описанию, категории, магазину
    for (var product in allProducts) {
      if (product.title.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query) ||
          product.store.toLowerCase().contains(query)) {
        if (!results.contains(product)) {
          results.add(product);
        }
      }
    }
    
    // Интеллектуальный поиск
    for (var entry in searchMappings.entries) {
      if (query.contains(entry.key)) {
        for (var category in entry.value) {
          if (category == 'все') {
            for (var product in allProducts) {
              if (!results.contains(product)) {
                results.add(product);
              }
            }
          } else if (category == 'низкая_цена') {
            for (var product in allProducts) {
              if (product.price < 2.0 && !results.contains(product)) {
                results.add(product);
              }
            }
          } else if (category == 'высокая_цена') {
            for (var product in allProducts) {
              if (product.price > 4.0 && !results.contains(product)) {
                results.add(product);
              }
            }
          } else if (category == 'подарок_папе') {
            // Подарки для папы: конкретные товары
            for (var product in allProducts) {
              if ((product.title.contains('Разводной ключ') || 
                   product.title.contains('Щетки стеклоочистителя')) && 
                  !results.contains(product)) {
                results.add(product);
              }
            }
          } else if (category == 'подарок_бабушке') {
            // Подарки для бабушки: конкретные товары  
            for (var product in allProducts) {
              if ((product.title.contains('Кулон серебряный') || 
                   product.title.contains('Princess Принцесс духи')) && 
                  !results.contains(product)) {
                results.add(product);
              }
            }
          } else if (category == 'подарок_универсальный') {
            // Универсальные подарки: красота, украшения, книги
            for (var product in allProducts) {
              if ((product.category == 'Красота' || 
                   product.category == 'Украшения' || 
                   product.category == 'Книги') && 
                  !results.contains(product)) {
                results.add(product);
              }
            }
          } else {
            for (var product in allProducts) {
              if ((product.category == category || product.store == category) && 
                  !results.contains(product)) {
                results.add(product);
              }
            }
          }
        }
      }
    }
    
    return results.isEmpty ? allProducts : results;
  }
}

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
        productUrl: "https://www.wildberries.ru/catalog/12345/detail.aspx",
      ),
      ProductCard(
        title: "Кроссовки летние спортивные для подростка",
        description: "Кроссовки для подростка.",
        imageUrl: 'lib/assets/pictures/good2.png',
        price: 0.99,
        store: "Ozon",
        category: "Одежда",
        productUrl: "https://www.ozon.ru/product/krossovki-letnie-podrostok-67890/",
      ),
      ProductCard(
        title: "Princess Принцесс духи женские",
        description: "Элегантные женские духи с нежным ароматом для повседневного использования.",
        imageUrl: 'lib/assets/pictures/good3.png',
        price: 2.49,
        store: "Ozon",
        category: "Красота",
        productUrl: "https://www.ozon.ru/product/princess-duhi-zhenskie-11223/",
      ),
      ProductCard(
        title: "Маскхалат камуфляжный летний костюм горка",
        description: "Летний камуфляжный костюм для активного отдыха и туризма.",
        imageUrl: 'lib/assets/pictures/good4.png',
        price: 2.49,
        store: "Ozon",
        category: "Одежда",
        productUrl: "https://www.ozon.ru/product/maskhalat-kamuflyaj-44556/",
      ),
      ProductCard(
        title: "Смарт-часы X1000",
        description: "Умные часы с множеством функций для спорта и жизни.",
        imageUrl: 'lib/assets/pictures/good1.png',
        price: 5.99,
        store: "Wildberies",
        category: "Электроника",
        productUrl: "https://www.wildberries.ru/catalog/smart-watch-x1000-77889/detail.aspx",
      ),
      ProductCard(
        title: "Мягкая игрушка Медведь",
        description: "Плюшевый медведь для детей и взрослых.",
        imageUrl: 'lib/assets/pictures/good2.png',
        price: 3.49,
        store: "Ozon",
        category: "Игрушки",
        productUrl: "https://www.ozon.ru/product/medved-myagkaya-igrushka-99112/",
      ),
      ProductCard(
        title: "Декоративная подушка",
        description: "Яркая подушка для украшения дома.",
        imageUrl: 'lib/assets/pictures/good3.png',
        price: 2.19,
        store: "Ozon",
        category: "Дом",
        productUrl: "https://www.ozon.ru/product/dekorativnaya-podushka-33445/",
      ),
      ProductCard(
        title: "Кулон серебряный с камнем",
        description: "Элегантный серебряный кулон с драгоценным камнем для особых случаев.",
        imageUrl: 'lib/assets/pictures/good10.png',
        price: 4.99,
        store: "Wildberies",
        category: "Украшения",
        productUrl: "https://www.wildberries.ru/catalog/kulon-serebryanyj-55667/detail.aspx",
      ),
      ProductCard(
        title: "Разводной ключ универсальный",
        description: "Профессиональный разводной ключ для ремонта и строительных работ.",
        imageUrl: 'lib/assets/pictures/good11.png',
        price: 1.79,
        store: "Ozon",
        category: "Инструменты",
        productUrl: "https://www.ozon.ru/product/klyuch-razvodnoy-s-tonkim-gubkami-200-mm-vira-974514137/?at=z6tOY5958cvKK5YZu7900y0f6P43m8SgWjkn7c0B1NAP",
      ),
      ProductCard(
        title: "Щетки стеклоочистителя BOSCH",
        description: "Гибридная щетка стеклоочистителя Bosch, артикул 3 397 118 912. Страна-производитель: Бельгия.",
        imageUrl: 'lib/assets/pictures/good12.png',
        price: 1.79,
        store: "Ozon",
        category: "Автотовары",
        productUrl: "https://www.ozon.ru/product/stekloochistiteli-aerotwin-retrofit-ar813s-650-450-mm-1705324480/?at=08tYX1Z1Jc2D0x2GhMKOg4At7mwA4RU2or9GkHw82DPJ",
      ),
    ];
  }
}