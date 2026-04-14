import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/data/models/coffee_model.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import 'package:finalboss/core/features/presentation/pages/size_ext.dart';
import 'cart_screen.dart';

class DetailsScreen extends StatefulWidget {
  final Coffee coffee;
  const DetailsScreen({super.key, required this.coffee});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedSize = "M";

  double get adjustedPrice {
    if (selectedSize == "S") return widget.coffee.price - 0.50;
    if (selectedSize == "L") return widget.coffee.price + 1.25;
    return widget.coffee.price;
  }

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
                _buildHeroImage(context),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w(context), vertical: 1.h(context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCircleButton(context, Icons.arrow_back_ios_new, () => Navigator.pop(context)),
                        Consumer<CoffeeProvider>(
                          builder: (context, provider, child) {
                            bool isFav = provider.favoriteCoffee.any((c) => c.name == widget.coffee.name);
                            return _buildCircleButton(
                              context, 
                              isFav ? Icons.favorite : Icons.favorite_border, 
                              () => provider.toggleFavorite(widget.coffee),
                              iconColor: isFav ? Colors.red : Colors.white
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5.h(context),
                  left: 5.w(context),
                  right: 5.w(context),
                  child: _buildInfoCard(context),
                ),
              ],
            ),
            SizedBox(height: 8.h(context)),
            Padding(
              padding: EdgeInsets.all(6.w(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description", style: TextStyle(fontSize: 4.5.w(context), fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                  SizedBox(height: 1.5.h(context)),
                  Text(
                    widget.coffee.description,
                    style: TextStyle(color: Colors.grey.shade600, height: 1.6, fontSize: 3.5.w(context), fontFamily: 'Sora'),
                  ),
                  SizedBox(height: 3.h(context)),
                  Text("Size", style: TextStyle(fontSize: 4.5.w(context), fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                  SizedBox(height: 2.h(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["S", "M", "L"].map((size) => _buildSizeButton(context, size)).toList(),
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

  Widget _buildHeroImage(BuildContext context) {
    final double imgHeight = 45.h(context);
    final int cacheSize = (MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio).round();

    return Image.asset(
      widget.coffee.imagePath,
      width: double.infinity,
      height: imgHeight,
      fit: BoxFit.cover,
      cacheWidth: cacheSize,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) => Container(height: imgHeight, color: Colors.grey.shade200),
    );
  }

  Widget _buildCircleButton(BuildContext context, IconData icon, VoidCallback onTap, {Color iconColor = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 5.w(context)),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 10))
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
                  style: TextStyle(fontSize: 5.5.w(context), fontWeight: FontWeight.bold, fontFamily: 'Sora', color: const Color(0xFF2F2D2C)),
                ),
                Text(
                  widget.coffee.category,
                  style: TextStyle(color: Colors.grey, fontSize: 3.w(context), fontFamily: 'Sora'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBFA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFBBE21), size: 20),
                const SizedBox(width: 4),
                Text(
                  "${widget.coffee.rating}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4.w(context), fontFamily: 'Sora'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSizeButton(BuildContext context, String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        width: 28.w(context),
        height: 6.h(context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF5EE) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFC67C4E) : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        child: Text(
          size == "S" ? "Small" : size == "M" ? "Medium" : "Large",
          style: TextStyle(
            color: isSelected ? const Color(0xFFC67C4E) : const Color(0xFF2F2D2C),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 3.5.w(context),
            fontFamily: 'Sora',
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w(context), vertical: 2.h(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -10)),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Price", style: TextStyle(color: Colors.grey, fontFamily: 'Sora', fontSize: 3.5.w(context))),
                Text(
                  "\$ ${adjustedPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: const Color(0xFFC67C4E),
                    fontSize: 5.5.w(context),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sora',
                  ),
                ),
              ],
            ),
            SizedBox(width: 5.w(context)),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC67C4E),
                  shape: const StadiumBorder(),
                  minimumSize: Size(double.infinity, 7.h(context)),
                  elevation: 0,
                ),
                onPressed: () {
                  final Coffee sizedCoffee = Coffee(
                    name: widget.coffee.name,
                    category: "${widget.coffee.category} ($selectedSize)",
                    description: widget.coffee.description,
                    price: adjustedPrice,
                    rating: widget.coffee.rating,
                    imagePath: widget.coffee.imagePath,
                  );
                  
                  context.read<CoffeeProvider>().addToCart(sizedCoffee);
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white, fontSize: 4.5.w(context), fontWeight: FontWeight.bold, fontFamily: 'Sora'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
