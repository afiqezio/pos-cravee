class Product {
  final String id;
  final String categoryId;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

final List<Product> products = [
  Product(
    id: '1',
    categoryId: '1',
    name: 'Parmesan Pretzel Bites',
    price: 3.20,
    imageUrl: 'assets/images/data/pretzel-ori.png',
  ),
  Product(
    id: '2',
    categoryId: '1',
    name: 'White Garlic Pretzel Bites',
    price: 4.50,
    imageUrl: 'assets/images/data/pretzel-ori.png',
  ),
  Product(
    id: '3',
    categoryId: '1',
    name: 'Unsalted Pretzel Bites',
    price: 6.30,
    imageUrl: 'assets/images/data/pretzel-ori.png',
  ),
  Product(
    id: '2',
    categoryId: '1',
    name: 'White Garlic Pretzel Bites',
    price: 4.50,
    imageUrl: 'assets/images/data/pretzel-ori.png',
  ),
  Product(
    id: '3',
    categoryId: '1',
    name: 'Unsalted Pretzel Bites',
    price: 6.30,
    imageUrl: 'assets/images/data/pretzel-ori.png',
  ),
  Product(
    id: '6',
    categoryId: '2',
    name: 'White Garlic',
    price: 4,
    imageUrl: 'assets/images/data/pretzel-ori.png',
  ),
  Product(
    id: '7',
    categoryId: '2',
    name: 'Cinnamon Pretzel',
    price: 5,
    imageUrl: 'assets/images/data/pretzel-ori.png',
  ),
];
