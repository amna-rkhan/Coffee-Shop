import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/data/models/coffee_model.dart';
import 'package:finalboss/core/features/presentation/pages/coffee_provider.dart';

class DetailsScreen extends StatefulWidget {
  final Coffee coffee;
  const DetailsScreen({super.key, required this.coffee});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedSize = "M";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  widget.coffee.imagePath,
                  width: double.infinity,
                  height: 375,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        ),
                        Consumer<CoffeeProvider>(
                          builder: (context, provider, child) {
                            bool isFav = provider.favoriteCoffee.any((c) => c.name == widget.coffee.name);
                            return IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.white,
                                size: 28,
                              ),
                              onPressed: () => provider.toggleFavorite(widget.coffee),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.coffee.name,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
                              ),
                              Text(
                                widget.coffee.category,
                                style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Sora'),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFBBE21), size: 24),
                            const SizedBox(width: 4),
                            Text(
                              "${widget.coffee.rating}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Sora'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                  const SizedBox(height: 12),
                  Text(
                    widget.coffee.description,
                    style: TextStyle(color: Colors.grey.shade600, height: 1.6, fontSize: 14, fontFamily: 'Sora'),
                  ),
                  const SizedBox(height: 25),
                  const Text("Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["S", "M", "L"].map((size) => _buildSizeButton(size)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildSizeButton(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF5EE) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFC67C4E) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? const Color(0xFFC67C4E) : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
            fontFamily: 'Sora',
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Price", style: TextStyle(color: Colors.grey, fontFamily: 'Sora')),
              Text(
                "\$ ${widget.coffee.price}",
                style: const TextStyle(
                  color: Color(0xFFC67C4E),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sora',
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC67C4E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                minimumSize: const Size(double.infinity, 62),
              ),
              onPressed: () {
                context.read<CoffeeProvider>().addToCart(widget.coffee);
              },
              child: const Text(
                "Buy Now",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
