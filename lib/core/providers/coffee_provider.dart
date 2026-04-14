import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/models/coffee_model.dart';

class Order {
  final String id;
  final List<Map<String, dynamic>> items;
  final double total;
  final DateTime date;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    this.status = "Delivered",
  });
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final bool isNew;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? imagePath;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    this.isNew = true,
    this.actionLabel,
    this.onAction,
    this.imagePath,
  });
}

class CoffeeProvider extends ChangeNotifier {
  String _userName = "Julian Thorne";
  String _userEmail = "julian.a@artisanalcoffee.com";
  String _userPhone = "+1 (555) 234-8901";
  String _userPhilosophy = "Light roast enthusiast with a penchant for Ethiopian single-origin pour overs.";
  
  Uint8List? _profileImageBytes;
  
  int _cupsOrdered = 128;
  int _beanPoints = 2450;
  final int _pointsToNextReward = 3000;
  
  final List<Coffee> _favoriteCoffee = [];
  final List<Map<String, dynamic>> _cart = [];
  final List<Order> _orderHistory = [];
  bool _isDarkMode = false;

  final List<AppNotification> _notifications = [
    AppNotification(
      id: '1',
      title: "Order Status",
      message: "Your order #AR-2940 is on the way!\nTrack it here.",
      time: "2H AGO",
      icon: Icons.local_shipping_outlined,
      actionLabel: "Track Order",
    ),
  ];

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  String get userPhilosophy => _userPhilosophy;
  Uint8List? get profileImageBytes => _profileImageBytes;
  
  int get cupsOrdered => _cupsOrdered;
  int get beanPoints => _beanPoints;
  double get rewardProgress => (_beanPoints % _pointsToNextReward) / _pointsToNextReward;
  int get pointsNeeded => _pointsToNextReward - (_beanPoints % _pointsToNextReward);

  List<Coffee> get favoriteCoffee => _favoriteCoffee;
  List<Map<String, dynamic>> get cart => _cart;
  List<Map<String, dynamic>> get cartItems => _cart;
  List<Order> get orderHistory => _orderHistory;
  bool get isDarkMode => _isDarkMode;
  List<AppNotification> get notifications => _notifications;
  int get newNotificationCount => _notifications.where((n) => n.isNew).length;

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String philosophy,
    Uint8List? imageBytes,
  }) {
    _userName = name;
    _userEmail = email;
    _userPhone = phone;
    _userPhilosophy = philosophy;
    if (imageBytes != null) _profileImageBytes = imageBytes;
    notifyListeners();
  }

  void placeOrder() {
    if (_cart.isEmpty) return;

    double total = 0;
    for (var item in _cart) {
      total += (item['coffee'].price * item['quantity']);
    }

    final newOrder = Order(
      id: "AR-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
      items: List.from(_cart),
      total: total,
      date: DateTime.now(),
    );

    _orderHistory.insert(0, newOrder);
    _cupsOrdered += _cart.length;
    _beanPoints += (total * 10).toInt();
    
    _cart.clear();
    
    addNotification(
      title: "Order Placed!",
      message: "Order #${newOrder.id} has been placed successfully. It's being prepared!",
      icon: Icons.check_circle_outline,
    );
    
    notifyListeners();
  }

  void loginUser(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _userEmail = "";
    _cart.clear();
    notifyListeners();
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

  void addNotification({required String title, required String message, required IconData icon, String? actionLabel, String? imagePath}) {
    _notifications.insert(0, AppNotification(id: DateTime.now().toString(), title: title, message: message, time: "JUST NOW", icon: icon, actionLabel: actionLabel, imagePath: imagePath));
    notifyListeners();
  }

  void markAllAsRead() {
    for (var i = 0; i < _notifications.length; i++) {
      if (_notifications[i].isNew) {
        final n = _notifications[i];
        _notifications[i] = AppNotification(id: n.id, title: n.title, message: n.message, time: n.time, icon: n.icon, isNew: false, actionLabel: n.actionLabel, imagePath: n.imagePath);
      }
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

  void updateQuantity(Coffee coffee, int delta) {
    final index = _cart.indexWhere((item) => item['coffee'].name == coffee.name);
    if (index != -1) {
      _cart[index]['quantity'] += delta;
      if (_cart[index]['quantity'] <= 0) _cart.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() { _cart.clear(); notifyListeners(); }
}
