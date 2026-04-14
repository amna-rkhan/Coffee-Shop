import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
          "Edit Profile",
          style: TextStyle(color: Color(0xFF4B3732), fontWeight: FontWeight.bold, fontFamily: 'Sora'),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Save", style: TextStyle(color: Color(0xFF4B3732), fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Sora')),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildPhotoSection(),
            const SizedBox(height: 40),
            _buildInputField("FULL NAME", "Julian Alexander"),
            const SizedBox(height: 20),
            _buildInputField("EMAIL ADDRESS", "julian.a@artisanalcoffee.com"),
            const SizedBox(height: 20),
            _buildInputField("PHONE NUMBER", "+1 (555) 234-8901"),
            const SizedBox(height: 20),
            _buildInputField("COFFEE PHILOSOPHY", "Light roast enthusiast with a penchant for Ethiopian single-origin pour overs.", isTextArea: true),
            const SizedBox(height: 40),
            _buildSecurityButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 120, height: 120,
                color: Colors.grey.shade300,
                child: const Icon(Icons.person, size: 80, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C2111),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text("Change profile photo", style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Sora')),
      ],
    );
  }

  Widget _buildInputField(String label, String value, {bool isTextArea = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF4B3732), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            maxLines: isTextArea ? 4 : 1,
            style: const TextStyle(fontSize: 15, fontFamily: 'Sora', color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: value,
              hintStyle: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAEAEA),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, size: 16, color: Colors.grey),
            SizedBox(width: 8),
            Text("Security Settings", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Sora')),
          ],
        ),
      ),
    );
  }
}
