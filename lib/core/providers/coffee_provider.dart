import 'package:flutter/material.dart';
import '../../data/models/coffee_model.dart';

class CoffeeProvider extends ChangeNotifier {
  final List<Coffee> _favoriteCoffee = [];
  final List<Coffee> _cart = [];

  List<Coffee> get favoriteCoffee => _favoriteCoffee;
  List<Coffee> get cart => _cart;

  // FIX: This solves the "getter 'cartItems' isn't defined" error
  List<Coffee> get cartItems => _cart;

  void toggleFavorite(Coffee coffee) {
    bool exists = _favoriteCoffee.any((item) => item.name == coffee.name);
    if (exists) {
      _favoriteCoffee.removeWhere((item) => item.name == coffee.name);
      coffee.isFavorite = false;
    } else {
      _favoriteCoffee.add(coffee);
      coffee.isFavorite = true;
    }
    notifyListeners();
  }

  void addToCart(Coffee coffee) {
    int index = _cart.indexWhere((item) => item.name == coffee.name);
    if (index != -1) {
      _cart[index].quantity++;
    } else {
      coffee.quantity = 1;
      _cart.add(coffee);
    }
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    _cart.removeWhere((item) => item.name == coffee.name);
    notifyListeners();
  }
}