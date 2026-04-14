import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import '../widgets/order_summary_card.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();
    final cart = provider.cart;
    double subtotal = cart.fold(0, (sum, item) => sum + (item['coffee'].price * item['quantity']));

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
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Sora'),
            ),
            const SizedBox(height: 15),
            const Text(
              "Jl. Kp. Baru No. 12, South Jakarta",
              style: TextStyle(color: Colors.grey, fontFamily: 'Sora'),
            ),
            const Divider(height: 40),
            OrderSummaryCard(subtotal: subtotal, deliveryFee: 2.50),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC67C4E),
                minimumSize: const Size(double.infinity, 62),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                // First save the order to history, then clear cart
                context.read<CoffeeProvider>().placeOrder();
                
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Success!", style: TextStyle(fontFamily: 'Sora')),
                    content: const Text("Your order has been placed successfully.", style: TextStyle(fontFamily: 'Sora')),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back from checkout
                        },
                        child: const Text("OK", style: TextStyle(color: Color(0xFFC67C4E), fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                );
              },
              child: const Text(
                "Order Now",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
