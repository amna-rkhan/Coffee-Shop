import 'package:flutter/material.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String selected = "Cappuccino";
  final List<String> categories = ["Cappuccino", "Machiato", "Latte", "Americano"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38, // 1. MATCH FIGMA HEIGHT
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20), // 2. MATCH LEFT: 20px
        itemCount: categories.length,
        // 3. MATCH GAP: 8px
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          bool isSelected = selected == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selected = categories[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFC67C4E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                // 4. ADD LIGHT BORDER FOR UNSELECTED (Match Figma look)
                border: isSelected ? null : Border.all(color: const Color(0xFFEDEDED)),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 14,
                  // 5. MATCH FONT WEIGHT (600 for selected, 400 for regular)
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : const Color(0xFF2F2D2C),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}