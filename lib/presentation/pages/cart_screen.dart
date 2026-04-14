import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/coffee_provider.dart';
import '../widgets/order_summary_card.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onCheckout;

  const CartScreen({super.key, this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();
    final cart = provider.cart;

    // Calculate subtotal
    double subtotal = cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Your Basket",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "${cart.length} Items",
                style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Sora'),
              ),
            ),
          )
        ],
      ),
      body: cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_basket_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 20),
                  const Text(
                    "Your basket is empty",
                    style: TextStyle(color: Colors.grey, fontFamily: 'Sora', fontSize: 16),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemBuilder: (context, index) => _buildCartTile(cart[index]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      OrderSummaryCard(subtotal: subtotal, deliveryFee: 2.50),
                      const SizedBox(height: 24),
                      _mainActionButton(
                        context: context,
                        label: "Proceed to Checkout",
                        onPressed: () async {
                          if (cart.isNotEmpty) {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CheckoutScreen())
                            );
                            if (onCheckout != null) {
                              onCheckout!();
                            }
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
            child: Image.asset(
              coffee.imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80, height: 80, color: Colors.grey.shade200,
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sora'),
                ),
                Text(
                  coffee.category,
                  style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Sora'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _qtyIcon(Icons.remove),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("1", style: TextStyle(fontFamily: 'Sora')),
                    ),
                    _qtyIcon(Icons.add),
                  ],
                )
              ],
            ),
          ),
          Text(
            "\$${coffee.price}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sora'),
          ),
        ],
      ),
    );
  }

  Widget _qtyIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Icon(icon, size: 18, color: Colors.black),
    );
  }

  Widget _mainActionButton({required BuildContext context, required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC67C4E),
        minimumSize: const Size(double.infinity, 62),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
