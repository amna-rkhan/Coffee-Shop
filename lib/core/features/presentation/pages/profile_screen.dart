import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 60),
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildStatsRow(),
            const SizedBox(height: 40),
            _buildAccountManagement(context),
            const SizedBox(height: 40),
            _buildLogoutButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 100, height: 100,
                color: Colors.grey.shade300,
                child: const Icon(Icons.person, size: 70, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFC67C4E),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Julian Thorne",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
        const SizedBox(height: 4),
        const Text(
          "Curating moments, one cup at a time.",
          style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Sora', fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.coffee, color: Color(0xFF4B3732), size: 24),
                const SizedBox(height: 15),
                const Text("128", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                const Text("Cups Ordered", style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Sora')),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0E6),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.sell_outlined, color: Color(0xFF4B3732), size: 24),
                const SizedBox(height: 15),
                const Text("2,450", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
                const Text("Bean Points", style: TextStyle(color: Color(0xFFC67C4E), fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountManagement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ACCOUNT MANAGEMENT",
          style: TextStyle(color: Color(0xFF4B3732), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 15, offset: const Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              _buildMenuItem(context, Icons.person_outline, "Edit Profile", onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              }),
              _buildMenuItem(context, Icons.history, "Order History"),
              _buildMenuItem(context, Icons.account_balance_wallet_outlined, "Payment Methods"),
              _buildMenuItem(context, Icons.settings_outlined, "Settings", showDivider: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, {bool showDivider = true, VoidCallback? onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: const Color(0xFF4B3732), size: 22),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sora'),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF9F9F9)),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Color(0xFFC62828), size: 20),
          SizedBox(width: 10),
          Text(
            "Logout",
            style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sora'),
          ),
        ],
      ),
    );
  }
}
