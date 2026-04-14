// lib/presentation/widgets/order_summary_card.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';


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
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _summaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          _summaryRow("Delivery Fee", "\$${deliveryFee.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          _summaryRow("Tax (8%)", "\$${tax.toStringAsFixed(2)}"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.lightGrey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total", style: TextStyle(fontSize: 16, fontFamily: 'Sora')),
              Text("\$${total.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black)),
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
        Text(label, style: const TextStyle(color: AppColors.grey, fontFamily: 'Sora')),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.black)),
      ],
    );
  }
}