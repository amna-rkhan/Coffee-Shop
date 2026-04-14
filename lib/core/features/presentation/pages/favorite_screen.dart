import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import 'package:finalboss/data/models/coffee_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();
    final favorites = provider.favoriteCoffee;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: favorites.length + 1, // +1 for the "Explore Menu" at the bottom
              itemBuilder: (context, index) {
                if (index == favorites.length) {
                  return _buildExploreMenuSection(context);
                }
                return _buildFavoriteCard(context, favorites[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text("Your heart is empty!", style: TextStyle(color: Colors.grey, fontFamily: 'Sora')),
          const SizedBox(height: 40),
          _buildExploreMenuSection(context),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Coffee item) {
    bool isLarge = item.name.contains("Espresso"); // Logic to vary card style like your screenshot

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLarge) ...[
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(item.imagePath, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (!isLarge) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(item.imagePath, width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 15),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                          const Icon(Icons.favorite, color: Colors.red, size: 20),
                        ],
                      ),
                      Text(item.description, style: const TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'Sora')),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$${item.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                          _buildAddButton(context, item, !isLarge),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, Coffee item, bool isSmall) {
    if (isSmall) {
      return ElevatedButton.icon(
        onPressed: () => context.read<CoffeeProvider>().addToCart(item),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF4F4F4),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        icon: const Text("Add", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        label: const Icon(Icons.shopping_bag_outlined, size: 16),
      );
    }
    return GestureDetector(
      onTap: () => context.read<CoffeeProvider>().addToCart(item),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Color(0xFF0C2111), shape: BoxShape.circle),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildExploreMenuSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
            child: const Icon(Icons.add, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          const Text("Discover more to love", style: TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'Sora')),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              // Navigation to Menu
            },
            child: const Text("Explore Menu", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontFamily: 'Sora')),
          ),
        ],
      ),
    );
  }
}
