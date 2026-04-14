import 'package:flutter/material.dart';
import 'package:finalboss/core/features/presentation/pages/size_ext.dart';

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
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4B3732), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Payment Methods",
          style: TextStyle(
            color: const Color(0xFF4B3732), 
            fontWeight: FontWeight.bold, 
            fontSize: 5.w(context),
            fontFamily: 'Sora'
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h(context)),
            Text(
              "CURRENT DEFAULT",
              style: TextStyle(
                color: const Color(0xFF4B3732), 
                fontSize: 11, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 1.2,
                fontFamily: 'Sora'
              ),
            ),
            SizedBox(height: 2.h(context)),
            _buildDefaultCard(context),
            SizedBox(height: 4.h(context)),
            Text(
              "OTHER METHODS",
              style: TextStyle(
                color: const Color(0xFF4B3732), 
                fontSize: 11, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 1.2,
                fontFamily: 'Sora'
              ),
            ),
            SizedBox(height: 2.h(context)),
            _buildOtherMethodItem(context, Icons.apple, "Apple Pay", "Default for Mobile Orders", hasCheck: true),
            SizedBox(height: 1.5.h(context)),
            _buildOtherMethodItem(context, Icons.credit_card, "Mastercard •••• 8842", "Expires 09/25", hasArrow: true),
            SizedBox(height: 1.5.h(context)),
            _buildOtherMethodItem(context, Icons.account_balance_wallet, "Google Pay", "Not connected", buttonText: "Link"),
            SizedBox(height: 4.h(context)),
            _buildAddNewMethod(context),
            SizedBox(height: 4.h(context)),
            _buildSecurityNotice(context),
            SizedBox(height: 4.h(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w(context)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC67C4E), Color(0xFF965F37)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC67C4E).withOpacity(0.3), 
            blurRadius: 20, 
            offset: const Offset(0, 10)
          )
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
                children: [
                  Text(
                    "Primary Coffee Wallet", 
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontFamily: 'Sora')
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Visa Platinum", 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora')
                  ),
                ],
              ),
              const Text(
                "VISA", 
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)
              ),
            ],
          ),
          SizedBox(height: 4.h(context)),
          Text(
            "••••  ••••  ••••  1 2 3 4", 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 6.w(context), 
              letterSpacing: 2, 
              fontWeight: FontWeight.w600,
              fontFamily: 'Sora'
            )
          ),
          SizedBox(height: 4.h(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HOLDER", 
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, letterSpacing: 1.1, fontFamily: 'Sora')
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Alex Sterling", 
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Sora')
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EXPIRY", 
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, letterSpacing: 1.1, fontFamily: 'Sora')
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "12/26", 
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Sora')
                  ),
                ],
              ),
              const Icon(Icons.contactless, color: Colors.white70, size: 28),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOtherMethodItem(BuildContext context, IconData icon, String title, String subtitle, {bool hasCheck = false, bool hasArrow = false, String? buttonText}) {
    return Container(
      padding: EdgeInsets.all(4.w(context)),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9), 
              borderRadius: BorderRadius.circular(12)
            ),
            child: Icon(icon, color: const Color(0xFF2F2D2C), size: 24),
          ),
          SizedBox(width: 4.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Sora', color: Color(0xFF2F2D2C))
                ),
                Text(
                  subtitle, 
                  style: const TextStyle(color: Color(0xFF9B9B9B), fontSize: 12, fontFamily: 'Sora')
                ),
              ],
            ),
          ),
          if (hasCheck) 
            const Icon(Icons.check_circle, color: Color(0xFFC67C4E), size: 22),
          if (hasArrow) 
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF9B9B9B), size: 14),
          if (buttonText != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFBFA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFC67C4E).withOpacity(0.2))
              ),
              child: Text(
                buttonText, 
                style: const TextStyle(color: Color(0xFFC67C4E), fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Sora')
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddNewMethod(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2), style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: Color(0xFFC67C4E), size: 20),
          SizedBox(width: 2.w(context)),
          const Text(
            "Add New Payment Method", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sora', color: Color(0xFF2F2D2C))
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNotice(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w(context)),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), 
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: Color(0xFF9B9B9B), size: 22),
          SizedBox(width: 4.w(context)),
          const Expanded(
            child: Text(
              "Your payment details are encrypted and stored securely. We use industry-standard SSL to protect your information and never share your CVV.",
              style: TextStyle(color: Color(0xFF9B9B9B), fontSize: 11, height: 1.4, fontFamily: 'Sora'),
            ),
          ),
        ],
      ),
    );
  }
}
