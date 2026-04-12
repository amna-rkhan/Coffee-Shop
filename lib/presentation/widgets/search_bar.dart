import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            const Icon(Icons.search, color: Colors.black, size: 24),
            const Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search coffee',
                  hintStyle: TextStyle(color: Color(0xFF989898), fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
        Container(
          margin: const EdgeInsets.all(4),
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding to scale the icon
            child: Image.asset(
              "asset/icons/setting-4.png", // Make sure this path matches your pubspec.yaml
              color: Colors.white,
              fit: BoxFit.contain,
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
