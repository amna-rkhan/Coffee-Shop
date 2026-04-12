// class CoffeeModel {
//   final String name;
//   final double rating;
//   final int reviews;
//   final double price;
//   final String description;
//   final String imageName;
//   final String category;
//
//   CoffeeModel({
//     required this.name,
//     required this.rating,
//     required this.reviews,
//     required this.price,
//     required this.description,
//     required this.imageName,
//     required this.category,
//   });
// }

class Coffee {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imagePath;

  Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
  });
}