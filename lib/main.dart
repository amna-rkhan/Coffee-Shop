import 'package:flutter/material.dart';

void main() {
  // We run MyApp as the root
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoffeeIntroScreen(), // This tells the app which screen to show
    );
  }
}

class CoffeeIntroScreen extends StatelessWidget {
  const CoffeeIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // 2. Then return the Scaffold
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.6,
            child: ClipRRect(
              child: Image.asset(
                'assets/images/coffee_intro.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Bottom Content Area
          Positioned(
            bottom: 0,
            child: Container(
              height: screenHeight * 0.45,
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              color: const Color(0xFF322421),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Time for a coffee break....',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Your daily dose of fresh brew delivered to your doorstep. Start your coffee journey now!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.white24),
                      const SizedBox(width: 5),
                      const Icon(Icons.circle, size: 8, color: Colors.white24),
                      const SizedBox(width: 5),
                      const Icon(Icons.circle, size: 8, color: Colors.white24),
                      const SizedBox(width: 5),
                      Container(
                        width: 25,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      print("Navigating...");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6771F),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}