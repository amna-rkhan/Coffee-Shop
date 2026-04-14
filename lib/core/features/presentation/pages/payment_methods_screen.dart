import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4B3732)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Payment Methods",
          style: TextStyle(color: Color(0xFF4B3732), fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "CURRENT DEFAULT",
              style: TextStyle(color: Color(0xFF4B3732), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 15),
            _buildDefaultCard(),
            const SizedBox(height: 30),
            const Text(
              "OTHER METHODS",
              style: TextStyle(color: Color(0xFF4B3732), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 15),
            _buildOtherMethodItem(Icons.apple, "Apple Pay", "Default for Mobile Orders", hasCheck: true),
            const SizedBox(height: 12),
            _buildOtherMethodItem(Icons.credit_card, "Mastercard •••• 8842", "Expires 09/25", hasArrow: true),
            const SizedBox(height: 12),
            _buildOtherMethodItem(Icons.account_balance_wallet, "Google Pay", "Not connected", buttonText: "Link"),
            const SizedBox(height: 30),
            _buildAddNewMethod(),
            const SizedBox(height: 40),
            _buildSecurityNotice(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF965F37),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: const Color(0xFF965F37).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Primary Coffee Wallet", style: TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Sora')),
                  SizedBox(height: 4),
                  Text("Visa Platinum", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                ],
              ),
              const Text("VISA", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
            ],
          ),
          const SizedBox(height: 30),
          const Text("••••  ••••  ••••  1 2 3 4", style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2, fontWeight: FontWeight.w600)),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("HOLDER", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.1)),
                  SizedBox(height: 4),
                  Text("Alex Sterling", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("EXPIRY", style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.1)),
                  SizedBox(height: 4),
                  Text("12/26", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
              const Icon(Icons.contactless, color: Colors.white70, size: 24),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOtherMethodItem(IconData icon, String title, String subtitle, {bool hasCheck = false, bool hasArrow = false, String? buttonText}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Sora')),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Sora')),
              ],
            ),
          ),
          if (hasCheck) const Icon(Icons.check_circle, color: Color(0xFFE6DED5), size: 20),
          if (hasArrow) const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
          if (buttonText != null)
            TextButton(
              onPressed: () {},
              child: Text(buttonText, style: const TextStyle(color: Color(0xFFC67C4E), fontWeight: FontWeight.bold, fontSize: 14)),
            ),
        ],
      ),
    );
  }

  Widget _buildAddNewMethod() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add, color: Color(0xFFC67C4E), size: 20),
          SizedBox(width: 10),
          Text("Add New Payment Method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Sora')),
        ],
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: Colors.grey, size: 24),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "Your payment details are encrypted and stored securely. We use industry-standard SSL to protect your information and never share your CVV.",
              style: TextStyle(color: Colors.grey, fontSize: 11, height: 1.4, fontFamily: 'Sora'),
            ),
          ),
        ],
      ),
    );
  }
}
