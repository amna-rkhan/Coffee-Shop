import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Color(0xFFC67C4E)),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_vert, color: Colors.grey),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStayUpdatedBanner(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Today", "3 New"),
                  const SizedBox(height: 15),
                  _buildOrderNotification(),
                  const SizedBox(height: 15),
                  _buildOfferNotification(),
                  const SizedBox(height: 30),
                  _buildSectionHeader("Yesterday", ""),
                  const SizedBox(height: 15),
                  _buildArrivalNotification(),
                  const SizedBox(height: 15),
                  _buildPointsNotification(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStayUpdatedBanner() {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("STAY UPDATED", style: TextStyle(color: Color(0xFFC67C4E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                const Text(
                  "Your daily\nritual,\nsynchronized.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Sora', height: 1.2),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.coffee_rounded, color: Colors.white, size: 50),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String badge) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
        if (badge.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFFFF5EE), borderRadius: BorderRadius.circular(20)),
            child: Text(badge, style: const TextStyle(color: Color(0xFFC67C4E), fontSize: 10, fontWeight: FontWeight.bold)),
          )
      ],
    );
  }

  Widget _buildNotificationCard({required IconData icon, required String title, required String time, required String message, Widget? extra}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: const Color(0xFFC67C4E), size: 20),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(message, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4)),
                  ],
                ),
              )
            ],
          ),
          if (extra != null) ...[const SizedBox(height: 15), extra],
        ],
      ),
    );
  }

  Widget _buildOrderNotification() {
    return _buildNotificationCard(
      icon: Icons.local_shipping_outlined,
      title: "Order Status",
      time: "2H AGO",
      message: "Your order #AR-2940 is on the way!\nTrack it here.",
      extra: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4B3732),
          minimumSize: const Size(100, 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: () {},
        child: const Text("Track Order", style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }

  Widget _buildOfferNotification() {
    return _buildNotificationCard(
      icon: Icons.sell_outlined,
      title: "Special Offer!",
      time: "5H AGO",
      message: "20% off your next Caramel Macchiato. Claim now.",
      extra: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("MACCHIATO20", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 12)),
            Icon(Icons.copy, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildArrivalNotification() {
    return _buildNotificationCard(
      icon: Icons.coffee_outlined,
      title: "New Arrival",
      time: "1D AGO",
      message: "Try our limited edition Ethiopian Yirgacheffe beans. Freshly roasted this morning.",
      extra: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 120, width: double.infinity, color: Colors.grey.shade200,
              child: const Icon(Icons.image_outlined, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
          const Text("DISCOVER ORIGIN", style: TextStyle(color: Color(0xFFC67C4E), fontWeight: FontWeight.bold, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildPointsNotification() {
    return _buildNotificationCard(
      icon: Icons.history,
      title: "Points Credited",
      time: "1D AGO",
      message: "You earned 15 Beans from your last purchase at the Downtown branch.",
    );
  }
}
