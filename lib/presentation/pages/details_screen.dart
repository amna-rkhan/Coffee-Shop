import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/coffee_model.dart';
import 'package:finalboss/coffee_provider.dart';

class DetailsScreen extends StatefulWidget {
  final Coffee coffee;
  const DetailsScreen({super.key, required this.coffee});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    // Variable for width-based responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 375,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. Main Coffee Image
                  Positioned.fill(
                    child: Image.asset(
                      widget.coffee.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                          // Heart Icon with Provider Logic
                          Consumer<CoffeeProvider>(
                            builder: (context, provider, child) {
                              bool isFav = provider.favoriteCoffee.any((c) => c.name == widget.coffee.name);
                              return GestureDetector(
                                onTap: () => provider.toggleFavorite(widget.coffee),
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: isFav ? Colors.red : Colors.white,
                                  size: 24,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 2. Positioned Overlay (The Info Card)
                  Positioned(
                    bottom: -55,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.coffee.name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Sora'
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.coffee.category,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Sora'
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Color(0xFFFBBE21), size: 24),
                              const SizedBox(width: 4.8),
                              Text(
                                "${widget.coffee.rating}",
                                style: const TextStyle(
                                    color: Color(0xFF2F2D2C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sora'
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),

            // 3. Description & Size Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Sora')),
                    const SizedBox(height: 20),
                    Text(
                      widget.coffee.description,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Sora'
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Size", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['S', 'M', 'L'].map((size) => _buildSizeButton(size, screenWidth)).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 4. Price & Buy Button Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                              color: Color(0xFF9B9B9B),
                              fontSize: 14,
                              fontFamily: 'Sora'
                          ),
                        ),
                        Text(
                          "\$ ${widget.coffee.price}",
                          style: const TextStyle(
                              color: Color(0xFFE27D19),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sora'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Corrected Provider call
                          context.read<CoffeeProvider>().addToCart(widget.coffee);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${widget.coffee.name} added to cart!")),
                          );
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE27D19),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sora'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Responsive Size Button Method
  Widget _buildSizeButton(String size, double screenWidth) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        width: screenWidth * 0.24, // Scaling for responsiveness
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC67C4E).withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? const Color(0xFFC67C4E) : const Color(0xFFEAEAEA)),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? const Color(0xFFC67C4E) : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Sora',
          ),
        ),
      ),
    );
  }
}