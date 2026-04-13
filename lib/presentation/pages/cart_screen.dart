// lib/presentation/pages/cart_screen.dart
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback onCheckout;
  const CartScreen({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order", style: TextStyle(fontFamily: 'Sora', fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2, // Example
              itemBuilder: (context, index) => _buildCartItem(),
            ),
          ),
          _buildPaymentSummary(context),
        ],
      ),
    );
  }

  Widget _buildCartItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset("asset/images/image3.png", width: 80, height: 80, fit: BoxFit.cover)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Cappuccino", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text("with Chocolate", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
          Row(
            children: [
              _qtyBtn(Icons.remove),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("1")),
              _qtyBtn(Icons.add),
            ],
          )
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
      child: Icon(icon, size: 16),
    );
  }

  Widget _buildPaymentSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        children: [
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Price"), Text("\$ 4.53", style: TextStyle(fontWeight: FontWeight.bold))]),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC67C4E), minimumSize: const Size(double.infinity, 62), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            onPressed: onCheckout,
            child: const Text("Order", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}