import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_chips.dart';
import '../widgets/coffee_card.dart';
import '../../data/models/coffee_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Coffee> coffees = [
    Coffee(name: "Cappucino", description: "with Chocolate", price: 4.53, rating: 4.8, imagePath: "asset/images/image1.png"),
    Coffee(name: "Cappucino", description: "with Oat Milk", price: 3.90, rating: 4.9, imagePath: "asset/images/image2.png"),
    Coffee(name: "Cappucino", description: "with Chocolate", price: 4.53, rating: 4.5, imagePath: "asset/images/image3.png"),
    Coffee(name: "Cappucino", description: "with Oat Milk", price: 3.90, rating: 4.0, imagePath: "asset/images/image4.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Allow content to scroll behind the rounded corners of the nav bar
      // extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 161,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF131313), Color(0xFF313131)],
                    ),
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
                            const Text(
                              "West, Balurghat ",
                              style: TextStyle(
                                color: Color(0xFFDDDDDD),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Sora',
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset("asset/icons/Arrow - Down 2.png", width: 14, height: 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset("asset/images/Frame 3195.png", width: 44, height: 44),
                  ),
                ),
                const Positioned(
                  bottom: -26,
                  left: 0,
                  right: 0,
                  child: CustomSearchBar(),
                ),
              ],
            ),
            const SizedBox(height: 45),
            const CategoryChips(),
            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: coffees.length,
              itemBuilder: (context, index) => CoffeeCard(coffee: coffees[index]),
            ),

            // Space so the bottom of the grid isn't hidden by the nav bar
            const SizedBox(height: 120),
          ],
        ),
      ),

      // FIXED BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        height: 75, // Increased slightly to prevent overflow
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem("asset/icons/home.png", true),
            _buildNavItem("asset/icons/heart.png", false),
            _buildNavItem("asset/icons/Bag 2.png", false),
            _buildNavItem("asset/icons/bell.png", false),
          ],
        ),
      ),
    );
  }

  // Helper method for the navigation items
  Widget _buildNavItem(String assetPath, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          assetPath,
          width: 24,
          height: 24,
          color: isSelected ? const Color(0xFFC67C4E) : const Color(0xFF8D8D8D),
        ),
        const SizedBox(height: 4),
        if (isSelected)
          Container(
            height: 5,
            width: 10,
            decoration: BoxDecoration(
              color: const Color(0xFFC67C4E),
              borderRadius: BorderRadius.circular(10),
            ),
          )
        else
          const SizedBox(height: 5), // Maintain spacing for unselected
      ],
    );
  }
}