import 'package:flutter/material.dart';
import 'package:finalboss/size_ext.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Back/Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.coffee_maker, color: Color(0xFF322421)),
                      const SizedBox(width: 8),
                      const Text("The Artisanal Coffee",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Text("Sign In", style: TextStyle(color: Colors.black)),
                    label: const Icon(Icons.arrow_forward, size: 16, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text("Create an account",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const Text("Start your journey through the world of specialty beans.",
                  style: TextStyle(color: Colors.black54)),

              const SizedBox(height: 30),
              _buildField("FULL NAME", "e.g. Julian Artis", Icons.person_outline),
              const SizedBox(height: 20),
              _buildField("EMAIL ADDRESS", "julian@example.com", Icons.alternate_email),
              const SizedBox(height: 20),
              _buildField("PASSWORD", "........", Icons.lock_outline, isPassword: true),
              const SizedBox(height: 20),
              _buildField("CONFIRM", "........", Icons.verified_user_outlined, isPassword: true),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF322421),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {},
                  child: const Text("Create Account", style: TextStyle(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 25),
              const Center(child: Text("OR SIGN UP WITH", style: TextStyle(fontSize: 10, color: Colors.grey))),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(child: _socialButton("Google", Icons.g_mobiledata)),
                  const SizedBox(width: 15),
                  Expanded(child: _socialButton("Facebook", Icons.facebook, color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "By joining, you agree to our Terms of Service and Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _socialButton(String label, IconData icon, {Color color = Colors.black}) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(label, style: const TextStyle(color: Colors.black)),
    );
  }
}