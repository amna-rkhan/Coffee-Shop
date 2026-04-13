import 'package:flutter/material.dart';
import 'package:finalboss/data/models/coffee_model.dart';

class CoffeeProvider extends ChangeNotifier {
  String _userEmail = "";
  final List<Coffee> _favoriteCoffee = [];
  final List<Coffee> _cart = [];

  String get userEmail => _userEmail;
  List<Coffee> get favoriteCoffee => _favoriteCoffee;
  List<Coffee> get cart => _cart;

  void loginUser(String email) {
    _userEmail = email;
    notifyListeners();
  }

  // Check if a specific coffee is favorited by its unique name/description combo
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
    _cart.add(coffee);
    notifyListeners();
  }
}
