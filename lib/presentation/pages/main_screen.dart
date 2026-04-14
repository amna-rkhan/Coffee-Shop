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

  // This function is what gets called when 'onCheckout' is triggered
  void _handleCheckoutRedirect() {
    setState(() {
      _currentIndex = 0; // Jump back to Home tab
    });
  }

  @override
  Widget build(BuildContext context) {
    // Note: No 'const' before CartScreen here
    final List<Widget> pages = [
      const HomePage(),
      const FavoriteScreen(),
      CartScreen(onCheckout: _handleCheckoutRedirect),
      const NotificationScreen(),
    ];

    return Scaffold(
      // IndexedStack keeps your page scroll positions saved
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(color: Colors.white),
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
      behavior: HitTestBehavior.opaque,
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
          Container(
            height: 5,
            width: 10,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFC67C4E) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}