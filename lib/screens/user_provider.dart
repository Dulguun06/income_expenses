import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = "Хэрэглэгч";
  double _balance = 0.0;

  String get userName => _userName;
  double get balance => _balance;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setBalance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }
}
