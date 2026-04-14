import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "DELIVERY ADDRESS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.black),
            ),
            const SizedBox(height: 16),
            _buildAddressCard(),
            const SizedBox(height: 30),
            const Text(
              "PAYMENT METHOD",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.black),
            ),
            const SizedBox(height: 16),
            _paymentOption("Apple Pay", Icons.apple, true),
            _paymentOption("Mastercard", Icons.credit_card, false),
            const SizedBox(height: 30),
            _buildTotalAmount(),
            const SizedBox(height: 40),
            // FIX: Now calling the method defined below
            _mainActionButton(),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "By placing this order you agree to our Terms of Service",
                style: TextStyle(color: AppColors.grey, fontSize: 11),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // UI Component: Address Card
  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4B3732),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.location_on, color: AppColors.white),
          ),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Work Office", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("123 Innovation Drive, Suite 400", style: TextStyle(color: AppColors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // UI Component: Payment Option
  Widget _paymentOption(String title, IconData icon, bool selected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF312522) : AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: selected ? AppColors.white : AppColors.black),
          const SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              color: selected ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? AppColors.white : AppColors.grey,
          ),
        ],
      ),
    );
  }

  // UI Component: Total Calculation
  Widget _buildTotalAmount() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(
          "\$14.20",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.black),
        ),
      ],
    );
  }

  // FIX: The missing button method added inside the State class
  Widget _mainActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          // Add your Navigation or Order Logic here
          print("Order Placed!");
        },
        child: const Text(
          "Order Now",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}