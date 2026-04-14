import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;

  const OrderSummaryCard({super.key, required this.subtotal, required this.deliveryFee});

  @override
  Widget build(BuildContext context) {
    double tax = subtotal * 0.08;
    double total = subtotal + deliveryFee + tax;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _summaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          const SizedBox(height: 12),
          _summaryRow("Delivery Fee", "\$${deliveryFee.toStringAsFixed(2)}"),
          const SizedBox(height: 12),
          _summaryRow("Tax (8%)", "\$${tax.toStringAsFixed(2)}"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Color(0xFFEAEAEA), thickness: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sora',
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC67C4E),
                  fontFamily: 'Sora',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Sora',
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Sora',
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
