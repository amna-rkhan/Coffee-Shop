// lib/presentation/pages/notification_screen.dart
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("asset/icons/bell.png", width: 100, height: 100, color: const Color(0xFFC67C4E)),
              const SizedBox(height: 24),
              const Text("Order Successful!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Sora')),
              const SizedBox(height: 12),
              const Text("Your delicious coffee is on the way. You can track it in the order history.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC67C4E), minimumSize: const Size(200, 50)),
                onPressed: () => Navigator.pop(context),
                child: const Text("Track Order", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}