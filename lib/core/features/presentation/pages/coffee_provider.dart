import 'package:flutter/material.dart';
import 'package:finalboss/data/models/coffee_model.dart';

class CoffeeProvider extends ChangeNotifier {
  String _userEmail = "";
  final List<Coffee> _favoriteCoffee = [];
  final List<Map<String, dynamic>> _cart = [];
  bool _isDarkMode = false;

  String get userEmail => _userEmail;
  List<Coffee> get favoriteCoffee => _favoriteCoffee;
  List<Map<String, dynamic>> get cart => _cart;
  bool get isDarkMode => _isDarkMode;

  void loginUser(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _userEmail = "";
    _cart.clear();
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  bool isFavorite(Coffee coffee) {
    return _favoriteCoffee.any((item) => 
      item.name == coffee.name && item.description == coffee.description);
  }

  void toggleFavorite(Coffee coffee) {
    final index = _favoriteCoffee.indexWhere((item) => 
      item.name == coffee.name && item.description == coffee.description);

    if (index != -1) {
      _favoriteCoffee.removeAt(index);
      coffee.isFavorite = false;
    } else {
      _favoriteCoffee.add(coffee);
      coffee.isFavorite = true;
    }
    notifyListeners();
  }

  void addToCart(Coffee coffee) {
    final index = _cart.indexWhere((item) => item['coffee'].name == coffee.name);
    if (index != -1) {
      _cart[index]['quantity']++;
    } else {
      _cart.add({'coffee': coffee, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    _cart.removeWhere((item) => item['coffee'].name == coffee.name);
    notifyListeners();
  }

  void updateQuantity(Coffee coffee, int delta) {
    final index = _cart.indexWhere((item) => item['coffee'].name == coffee.name);
    if (index != -1) {
      _cart[index]['quantity'] += delta;
      if (_cart[index]['quantity'] <= 0) {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
