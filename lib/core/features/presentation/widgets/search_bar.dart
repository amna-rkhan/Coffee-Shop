import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF313131), // Darker background to match header integration
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Inner white box for the actual bar
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 15),
              const Icon(Icons.search, color: Color(0xFF2F2D2C), size: 24),
              const Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Sora'),
                  decoration: InputDecoration(
                    hintText: 'Search coffee',
                    hintStyle: TextStyle(
                      color: Color(0xFF989898),
                      fontSize: 14,
                      fontFamily: 'Sora',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFC67C4E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune, // The filter/slider icon
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
