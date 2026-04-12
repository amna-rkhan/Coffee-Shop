// lib/coffee_provider.dart
import 'package:flutter/material.dart';

class CoffeeProvider extends ChangeNotifier {
  String _userEmail = "";
  String get userEmail => _userEmail;

  void loginUser(String email) {
    _userEmail = email;
    notifyListeners();
  }
}