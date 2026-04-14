import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import 'package:finalboss/core/features/presentation/pages/size_ext.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xFFC67C4E), size: 4.w(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: const Color(0xFF2F2D2C), 
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
            _buildProfileSummary(context, provider),
            SizedBox(height: 4.h(context)),
            
            _buildSectionHeader(context, "ACCOUNT SETTINGS"),
            _buildSettingsGroup(context, [
              _buildToggleItem(
                context,
                Icons.notifications_none_rounded, 
                "Notifications", 
                "Manage coffee alerts", 
                _notificationsEnabled,
                (val) => setState(() => _notificationsEnabled = val)
              ),
              _buildNavigationItem(context, Icons.lock_outline_rounded, "Privacy", "Security & data usage"),
              _buildNavigationItem(context, Icons.shield_outlined, "Security", "Passwords & 2FA"),
            ]),

            SizedBox(height: 3.h(context)),
            _buildSectionHeader(context, "APP PREFERENCES"),
            _buildSettingsGroup(context, [
              _buildNavigationItem(context, Icons.palette_outlined, "Theme", "Light, Dark or System", trailingText: "Light"),
              _buildNavigationItem(context, Icons.language_rounded, "Language", "Preferred app language", trailingText: "English"),
            ]),

            SizedBox(height: 3.h(context)),
            _buildSectionHeader(context, "SUPPORT"),
            _buildSettingsGroup(context, [
              _buildNavigationItem(context, Icons.help_outline_rounded, "Help Center", "FAQs & direct support"),
              _buildNavigationItem(context, Icons.gavel_rounded, "Terms of Service", "Legal documentation"),
            ]),

            SizedBox(height: 5.h(context)),
            _buildSignOutButton(context),
            
            SizedBox(height: 4.h(context)),
            _buildFooterText(context),
            SizedBox(height: 4.h(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSummary(BuildContext context, CoffeeProvider provider) {
    final double size = 18.w(context);
    final int cacheSize = (size * MediaQuery.of(context).devicePixelRatio).round();

    return Row(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
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
                        Icon(Icons.person, size: 8.w(context), color: Colors.white24),
                    ),
              ),
            ),
            Positioned(
              bottom: 0, right: 0,
              child: Container(
                padding: EdgeInsets.all(1.w(context)),
                decoration: const BoxDecoration(
                  color: Color(0xFFC67C4E),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: Colors.white, size: 3.w(context)),
              ),
            ),
          ],
        ),
        SizedBox(width: 4.w(context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.userName,
              style: TextStyle(fontSize: 4.5.w(context), fontWeight: FontWeight.bold, fontFamily: 'Sora', color: const Color(0xFF2F2D2C)),
            ),
            SizedBox(height: 0.5.h(context)),
            Text(
              "Premium Bean Member",
              style: TextStyle(color: Colors.grey, fontSize: 3.w(context), fontFamily: 'Sora'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w(context), bottom: 1.5.h(context)),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFFC67C4E), 
          fontSize: 2.5.w(context), 
          fontWeight: FontWeight.bold, 
          letterSpacing: 1.2,
          fontFamily: 'Sora'
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildToggleItem(BuildContext context, IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: EdgeInsets.all(4.w(context)),
      child: Row(
        children: [
          _buildIconContainer(context, icon),
          SizedBox(width: 4.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.8.w(context), fontFamily: 'Sora')),
                Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 3.w(context), fontFamily: 'Sora')),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8 * (MediaQuery.of(context).size.width / 400),
            child: Switch(
              value: value, 
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFFC67C4E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(BuildContext context, IconData icon, String title, String subtitle, {String? trailingText}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(4.w(context)),
        child: Row(
          children: [
            _buildIconContainer(context, icon),
            SizedBox(width: 4.w(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.8.w(context), fontFamily: 'Sora')),
                  Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 3.w(context), fontFamily: 'Sora')),
                ],
              ),
            ),
            if (trailingText != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w(context), vertical: 0.5.h(context)),
                margin: EdgeInsets.only(right: 2.w(context)),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDFBFA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  trailingText,
                  style: TextStyle(color: const Color(0xFFC67C4E), fontSize: 2.5.w(context), fontWeight: FontWeight.bold),
                ),
              ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 3.5.w(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(BuildContext context, IconData icon) {
    return Container(
      padding: EdgeInsets.all(2.5.w(context)),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xFF4B3732), size: 5.w(context)),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 7.h(context),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F5F5),
          foregroundColor: const Color(0xFFC67C4E),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, size: 5.w(context)),
            SizedBox(width: 3.w(context)),
            Text("Sign Out", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4.w(context), fontFamily: 'Sora')),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterText(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Artisan Roast v4.2.1-stable",
            style: TextStyle(color: Colors.grey, fontSize: 2.5.w(context), fontFamily: 'Sora'),
          ),
          SizedBox(height: 0.5.h(context)),
          Text(
            "Crafted with passion in Ethiopia",
            style: TextStyle(color: Colors.grey, fontSize: 2.5.w(context), fontFamily: 'Sora'),
          ),
        ],
      ),
    );
  }
}
