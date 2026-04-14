import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_chips.dart';
import 'package:finalboss/data/models/coffee_model.dart';
import 'package:finalboss/core/features/presentation/pages/coffee_provider.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "Cappuccino";

  final List<Coffee> allCoffees = [
    Coffee(name: "Cappuccino", description: "with Chocolate", price: 4.53, rating: 4.8, imagePath: "asset/images/image3.png", category: "Cappuccino"),
    Coffee(name: "Cappuccino", description: "with Oat Milk", price: 3.90, rating: 4.9, imagePath: "asset/images/image4.png", category: "Cappuccino"),
    Coffee(name: "Cappuccino", description: "with Chocolate", price: 4.53, rating: 4.5, imagePath: "asset/images/image2.png", category: "Cappuccino"),
    Coffee(name: "Cappuccino", description: "with Oat Milk", price: 3.90, rating: 4.0, imagePath: "asset/images/image1.png", category: "Cappuccino"),
    Coffee(name: "Machiato", description: "with Caramel", price: 5.10, rating: 4.7, imagePath: "asset/images/M1.jpg", category: "Machiato"),
    Coffee(name: "Machiato", description: "Rich Foam", price: 4.80, rating: 4.6, imagePath: "asset/images/M2.jpg", category: "Machiato"),
    Coffee(name: "Machiato", description: "Vanilla Macchiato", price: 5.20, rating: 4.9, imagePath: "asset/images/M3.jpg", category: "Machiato"),
    Coffee(name: "Machiato", description: "Iced Macchiato", price: 4.90, rating: 4.4, imagePath: "asset/images/M5.jpg", category: "Machiato"),
    Coffee(name: "Latte", description: "Vanilla Cream", price: 4.20, rating: 4.8, imagePath: "asset/images/L1.jpg", category: "Latte"),
    Coffee(name: "Latte", description: "Steamed Milk", price: 3.50, rating: 4.5, imagePath: "asset/images/L2.jpg", category: "Latte"),
    Coffee(name: "Latte", description: "Hazelnut Latte", price: 4.40, rating: 4.7, imagePath: "asset/images/L3.jpg", category: "Latte"),
    Coffee(name: "Latte", description: "Spanish Latte", price: 4.60, rating: 4.9, imagePath: "asset/images/L4.jpg", category: "Latte"),
    Coffee(name: "Americano", description: "With Hot Water", price: 4.50, rating: 4.5, imagePath: "asset/images/A1.jpg", category: "Americano"),
    Coffee(name: "Americano", description: "Deep Roast", price: 3.33, rating: 4.8, imagePath: "asset/images/A2.jpg", category: "Americano"),
    Coffee(name: "Americano", description: "Double Shot", price: 5.55, rating: 4.9, imagePath: "asset/images/A3.jpg", category: "Americano"),
    Coffee(name: "Americano", description: "Iced Americano", price: 3.50, rating: 4.2, imagePath: "asset/images/A4.jpg", category: "Americano"),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCoffees = allCoffees
        .where((coffee) => coffee.category == selectedCategory)
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderStack(),
          const SizedBox(height: 55),
          CategoryChips(
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() => selectedCategory = category);
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredCoffees.length,
              itemBuilder: (context, index) {
                final coffee = filteredCoffees[index];
                return _buildCoffeeCard(context, coffee);
              },
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildCoffeeCard(BuildContext context, Coffee coffee) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(coffee: coffee)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(coffee.imagePath, height: 132, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 0, left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.16),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFBBE21), size: 12),
                        const SizedBox(width: 4),
                        Text(
                          coffee.rating.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(coffee.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sora', color: Color(0xFF2F2D2C))),
                  const SizedBox(height: 4),
                  Text(coffee.description, style: const TextStyle(color: Color(0xFF9B9B9B), fontSize: 12, fontFamily: 'Sora')),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$ ${coffee.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Sora', color: Color(0xFF2F4B4E))),
                      GestureDetector(
                        onTap: () {
                          context.read<CoffeeProvider>().addToCart(coffee);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${coffee.name} added to cart!", style: const TextStyle(fontFamily: 'Sora')),
                              duration: const Duration(seconds: 1),
                              backgroundColor: const Color(0xFFC67C4E),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: const Color(0xFFC67C4E), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.add, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStack() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 161,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF131313),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text("Location", style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 12, fontFamily: 'Sora')),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text("West, Balurghat ", style: TextStyle(color: Color(0xFFDDDDDD), fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Sora')),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 50, right: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 44, height: 44,
              color: Colors.grey.shade800,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
        const Positioned(bottom: -26, left: 0, right: 0, child: CustomSearchBar()),
      ],
    );
  }
}
