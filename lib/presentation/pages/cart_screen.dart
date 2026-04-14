// lib/presentation/pages/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/coffee_provider.dart';
import '../widgets/order_summary_card.dart';
import 'checkout_screen.dart';
import '../../core/constants/app_colors.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onCheckout; // Add this line

  const CartScreen({super.key, this.onCheckout}); // Update this line

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CoffeeProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Your Basket", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(20)),
            child: Center(child: Text("${cart.cartItems.length} Items", style: const TextStyle(color: AppColors.grey, fontSize: 12))),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) => _buildCartTile(cart.cartItems[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const OrderSummaryCard(subtotal: 19.75, deliveryFee: 2.50),
                const SizedBox(height: 24),
                _mainActionButton(
                  context: context,
                  label: "Proceed to Checkout",
                  onPressed: () async {
                    // Navigate to Checkout
                    await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CheckoutScreen())
                    );
                    // Call the onCheckout callback after returning from Checkout
                    if (onCheckout != null) {
                      onCheckout!();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartTile(coffee) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(coffee.imagePath, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffee.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(coffee.description, style: const TextStyle(color: AppColors.grey, fontSize: 12)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _qtyIcon(Icons.remove),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("1")),
                    _qtyIcon(Icons.add),
                  ],
                )
              ],
            ),
          ),
          Text("\$${coffee.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _qtyIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Icon(icon, size: 18, color: AppColors.black),
    );
  }
}

// Shared Button Widget
Widget _mainActionButton({required BuildContext context, required String label, required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4B3732),
      minimumSize: const Size(double.infinity, 62),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
    ),
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(width: 10),
        const Icon(Icons.arrow_forward, color: AppColors.white, size: 20),
      ],
    ),
  );
}