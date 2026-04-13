import 'package:flutter/material.dart';
import 'home_page.dart';
import 'favorite_screen.dart';
import 'cart_screen.dart';
import 'notification_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const FavoriteScreen(),
      CartScreen(onCheckout: () {
        // Handle checkout logic or navigation
        setState(() => _currentIndex = 0); // Example: go back to home after checkout
      }),
      const NotificationScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem("asset/icons/home.png", 0),
          _buildNavItem("asset/icons/heart.png", 1),
          _buildNavItem("asset/icons/Bag 2.png", 2),
          _buildNavItem("asset/icons/bell.png", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String assetPath, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
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
            const SizedBox(height: 5),
        ],
      ),
    );
  }
}
