class Category {
  final String id;
  final String name;
  final String description;
  // final int quantity;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.description,
    // required this.quantity,
    required this.imageUrl,
  });
}

final List<Category> categories = [
  Category(
      id: '1',
      name: 'Original',
      // quantity: 5,
      imageUrl: 'assets/images/data/pretzel.png',
      description: 'Original Pretzel Bites'),
  Category(
      id: '2',
      name: 'Mini Dogs',
      // quantity: 2,
      imageUrl: 'assets/images/data/minidogs.png',
      description: 'Mini Dog Bites'),
  Category(
      id: '3',
      name: 'Combos',
      // quantity: 2,
      imageUrl: 'assets/images/data/combos.png',
      description: 'Combos Pretzel Bites'),
];
