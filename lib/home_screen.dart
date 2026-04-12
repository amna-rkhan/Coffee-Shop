import 'package:flutter/material.dart';
import 'package:finalboss/size_ext.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: _buildBottomNav(),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildCategories(),
                  const SizedBox(height: 20),
                  _buildCoffeeGrid(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      color: const Color(0xFF131313),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Location", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Row(
                    children: const [
                      Text("West, Balurghat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder for user profile
              )
            ],
          ),
          const SizedBox(height: 25),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF313131),
              hintText: "Search coffee",
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              suffixIcon: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: const Color(0xFFC67C4E), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.tune, color: Colors.white),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    List<String> cats = ["Cappuccino", "Machiato", "Latte", "Americano"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFC67C4E) : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(cats[index],
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoffeeGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _buildCoffeeCard(context),
    );
  }

  Widget _buildCoffeeCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network('https://via.placeholder.com/150', fit: BoxFit.cover, height: 120, width: double.infinity),
              ),
              Positioned(
                top: 10, left: 10,
                child: Row(
                  children: const [
                    Icon(Icons.star, color: Color(0xFFFBBE21), size: 16),
                    Text(" 4.8", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Cappuccino", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text("with Chocolate", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("\$ 4.53", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: const Color(0xFFC67C4E), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFFC67C4E),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: ""),
      ],
    );
  }
}