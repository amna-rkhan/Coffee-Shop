import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import 'package:finalboss/core/features/presentation/pages/size_ext.dart';
import 'edit_profile_screen.dart';
import 'order_history_screen.dart';
import 'payment_methods_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w(context)),
        child: Column(
          children: [
            SizedBox(height: 7.h(context)),
            _buildProfileHeader(context, provider),
            SizedBox(height: 4.h(context)),
            _buildStatsRow(context, provider),
            SizedBox(height: 4.h(context)),
            _buildLoyaltyCard(context, provider),
            SizedBox(height: 4.h(context)),
            _buildAccountManagement(context),
            SizedBox(height: 4.h(context)),
            _buildLogoutButton(context),
            SizedBox(height: 5.h(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, CoffeeProvider provider) {
    final double size = 25.w(context);
    final int cacheSize = (size * MediaQuery.of(context).devicePixelRatio).round();

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFC67C4E), width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: size,
                    height: size,
                    color: const Color(0xFF2F2D2C),
                    child: provider.profileImageBytes != null 
                      ? Image.memory(
                          provider.profileImageBytes!, 
                          fit: BoxFit.cover,
                          cacheWidth: cacheSize,
                          cacheHeight: cacheSize,
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                        )
                      : Image.asset(
                          'asset/images/user.png', 
                          fit: BoxFit.cover,
                          cacheWidth: cacheSize,
                          cacheHeight: cacheSize,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, error, stackTrace) => 
                            Icon(Icons.person, size: 12.w(context), color: Colors.white24),
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFC67C4E),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.verified, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h(context)),
        Text(
          provider.userName,
          style: TextStyle(fontSize: 6.w(context), fontWeight: FontWeight.bold, fontFamily: 'Sora', color: const Color(0xFF2F2D2C)),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF2F2D2C),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "GOLD MEMBER",
            style: TextStyle(color: Color(0xFFC67C4E), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, CoffeeProvider provider) {
    return Row(
      children: [
        _buildStatItem(context, provider.cupsOrdered.toString(), "Cups Ordered", Icons.coffee_rounded, const Color(0xFF4B3732)),
        SizedBox(width: 4.w(context)),
        _buildStatItem(context, provider.beanPoints.toString(), "Bean Points", Icons.auto_awesome, const Color(0xFFC67C4E)),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(4.w(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(height: 1.5.h(context)),
            Text(value, style: TextStyle(fontSize: 5.5.w(context), fontWeight: FontWeight.bold, fontFamily: 'Sora', color: const Color(0xFF2F2D2C))),
            Text(label, style: TextStyle(color: Colors.grey, fontSize: 3.w(context), fontFamily: 'Sora')),
          ],
        ),
      ),
    );
  }

  Widget _buildLoyaltyCard(BuildContext context, CoffeeProvider provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.w(context)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2F2D2C), Color(0xFF131313)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Rewards Progress", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
              Text("${provider.pointsNeeded} to next level", style: TextStyle(color: const Color(0xFFC67C4E), fontSize: 2.5.w(context), fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 2.h(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: provider.rewardProgress,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC67C4E)),
              minHeight: 8,
            ),
          ),
          SizedBox(height: 2.h(context)),
          const Text(
            "Redeem your points for a free 'Artisanal Latte' or any medium roast.",
            style: TextStyle(color: Colors.white60, fontSize: 11, height: 1.4, fontFamily: 'Sora'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountManagement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            "ACCOUNT MANAGEMENT",
            style: TextStyle(color: Color(0xFF4B3732), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              _buildMenuItem(context, Icons.person_outline, "Edit Profile", onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
              }),
              _buildMenuItem(context, Icons.history, "Order History", onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
              }),
              _buildMenuItem(context, Icons.account_balance_wallet_outlined, "Payment Methods", onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethodsScreen()));
              }),
              _buildMenuItem(context, Icons.settings_outlined, "Settings", showDivider: false, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
              }),
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
            padding: EdgeInsets.all(4.w(context)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: const Color(0xFF4B3732), size: 22),
                ),
                SizedBox(width: 3.w(context)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.8.w(context), fontFamily: 'Sora', color: const Color(0xFF2F2D2C)),
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

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          "Logout",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 4.w(context), fontFamily: 'Sora'),
        ),
      ),
    );
  }
}
