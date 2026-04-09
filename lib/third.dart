import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. Data Model
class Coffee {
  final String name, description, price, image;
  Coffee({required this.name, required this.description, required this.price, required this.image});
}

// 2. State Manager
class CoffeeProvider extends ChangeNotifier {
  String _selectedSize = 'M';
  String get selectedSize => _selectedSize;

  void setSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }
}

// 3. Detail Screen
class CoffeeDetailScreen extends StatelessWidget {
  final Coffee coffee; // This defines the coffee object
  const CoffeeDetailScreen({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Using 'coffee' here works because it is defined in the class above
            Image.asset(coffee.image, height: 300, fit: BoxFit.contain),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(coffee.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(coffee.description, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 25),

                  const Text("Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),

                  Consumer<CoffeeProvider>(
                    builder: (context, provider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['S', 'M', 'L'].map((size) {
                          bool isSelected = provider.selectedSize == size;
                          return InkWell(
                            onTap: () => provider.setSize(size),
                            child: Container(
                              width: screenWidth * 0.28,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFFFF5EE) : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: isSelected ? Colors.orange : Colors.grey[300]!),
                              ),
                              child: Text(size, style: TextStyle(color: isSelected ? Colors.orange : Colors.black)),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Price", style: TextStyle(color: Colors.grey)),
                Text(coffee.price, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
            Container(
              width: screenWidth * 0.5,
              height: 50,
              decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: const Text("Buy Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}