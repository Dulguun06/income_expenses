import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = "Хэрэглэгч";
  double _balance = 0.0;
  String _uid = "";

  String get userName => _userName;
  String get uid => _uid;
  double get balance => _balance;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setBalance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }
  void setUserID(String uid) {
    _uid = uid;
    notifyListeners();
  }
  
}
