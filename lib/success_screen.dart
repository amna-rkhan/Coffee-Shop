import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String email;
  const SuccessScreen({super.key, required this.email});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Color(0xFF322421)),
            const SizedBox(height: 20),
            Text(
              "Welcome,\n$email",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
