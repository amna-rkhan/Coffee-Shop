// import 'package:flutter/material.dart';
// import '../../core/constants/app_spacing.dart';
// import 'coffee_card.dart';
// import '../../data/models/coffee_model.dart';
//
// class CoffeeList extends StatelessWidget {
//   const CoffeeList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<CoffeeModel> coffees = [
//       CoffeeModel(
//         name: 'Cappuccino with Chocolate',
//         rating: 4.8,
//         reviews: 230,
//         price: 4.53,
//         description: 'With chocolate syrup',
//         imageName: 'image1',
//         category: 'Cappuccino',
//       ),
//       CoffeeModel(
//         name: 'Cappuccino with Oat Milk',
//         rating: 4.9,
//         reviews: 189,
//         price: 3.90,
//         description: 'With oat milk',
//         imageName: 'image2',
//         category: 'Cappuccino',
//       ),
//       CoffeeModel(
//         name: 'Caramel Macchiato',
//         rating: 4.5,
//         reviews: 156,
//         price: 4.99,
//         description: 'With caramel drizzle',
//         imageName: 'image3',
//         category: 'Machiatto',
//       ),
//       CoffeeModel(
//         name: 'Iced Americano',
//         rating: 4.0,
//         reviews: 98,
//         price: 3.50,
//         description: 'With ice',
//         imageName: 'image4',
//         category: 'Americano',
//       ),
//     ];
//
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
//       itemCount: coffees.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: AppSpacing.md),
//           child: CoffeeCard(coffee: coffees[index]),
//         );
//       },
//     );
//   }
// }