import 'package:flutter/material.dart';
import '../../data/models/coffee_model.dart';

class CoffeeProvider extends ChangeNotifier {
  // 1. Rename to favoriteCoffee to match your DetailsScreen Consumer
  final List<Coffee> _favoriteCoffee = [];
  final List<Coffee> _cart = [];

  // Getters
  List<Coffee> get favoriteCoffee => _favoriteCoffee;
  List<Coffee> get cart => _cart;

  // 2. Updated Toggle Logic
  void toggleFavorite(Coffee coffee) {
    // Check if it's already in the list by name
    bool exists = _favoriteCoffee.any((item) => item.name == coffee.name);

    if (exists) {
      _favoriteCoffee.removeWhere((item) => item.name == coffee.name);
      coffee.isFavorite = false;
    } else {
      _favoriteCoffee.add(coffee);
      coffee.isFavorite = true;
    }

    notifyListeners(); // Refreshes the heart icons across the app
  }

  // 3. Updated Add to Cart Logic
  void addToCart(Coffee coffee) {
    // Check if the item is already in the cart
    int index = _cart.indexWhere((item) => item.name == coffee.name);

    if (index != -1) {
      // If it exists, increase quantity (Make sure 'quantity' is in your Coffee model)
      _cart[index].quantity++;
    } else {
      // If new, ensure quantity is reset to 1 and add to cart
      coffee.quantity = 1;
      _cart.add(coffee);
    }

    notifyListeners(); // Refreshes the cart count/screen
  }

  // 4. Helper to remove from cart (Useful for the Cart Screen later)
  void removeFromCart(Coffee coffee) {
    _cart.removeWhere((item) => item.name == coffee.name);
    notifyListeners();
  }
}