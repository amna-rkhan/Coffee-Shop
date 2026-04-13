class Coffee {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imagePath;
  final String category;
  bool isFavorite;
  int quantity; // ADD THIS LINE

  Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.category,
    this.isFavorite = false,
    this.quantity = 1, // ADD THIS DEFAULT VALUE
  });
}