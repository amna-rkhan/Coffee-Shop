import 'package:flutter/material.dart';
import 'package:finalboss/coffee_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/order_summary_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();
    final cart = provider.cart;
    double subtotal = cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "DELIVERY ADDRESS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black, fontFamily: 'Sora'),
            ),
            const SizedBox(height: 16),
            _buildAddressCard(),
            const SizedBox(height: 30),
            const Text(
              "PAYMENT METHOD",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black, fontFamily: 'Sora'),
            ),
            const SizedBox(height: 16),
            _paymentOption("Apple Pay", Icons.apple, true),
            _paymentOption("Mastercard", Icons.credit_card, false),
            const SizedBox(height: 30),
            OrderSummaryCard(subtotal: subtotal, deliveryFee: 2.50),
            const SizedBox(height: 40),
            _mainActionButton(context),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "By placing this order you agree to our Terms of Service",
                style: TextStyle(color: Colors.grey, fontSize: 11, fontFamily: 'Sora'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFC67C4E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.location_on, color: Colors.white),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Work Office", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sora')),
                const Text(
                  "123 Innovation Drive, Suite 400",
                  style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Sora'),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(String title, IconData icon, bool selected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF312522) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: selected ? Colors.transparent : const Color(0xFFEAEAEA)),
      ),
      child: Row(
        children: [
          Icon(icon, color: selected ? Colors.white : Colors.black),
          const SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Sora',
            ),
          ),
          const Spacer(),
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? Colors.white : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _mainActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC67C4E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () => _showOrderSuccessDialog(context),
        child: const Text(
          "Order Now",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
      ),
    );
  }

  void _showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),
                const SizedBox(height: 20),
                const Text(
                  "Order Successful!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Your coffee is being prepared and will be delivered shortly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontFamily: 'Sora'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC67C4E),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Back to Cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tracking feature coming soon!", style: TextStyle(fontFamily: 'Sora')),
                        backgroundColor: Color(0xFFC67C4E),
                      ),
                    );
                  },
                  child: const Text("Track Order", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
