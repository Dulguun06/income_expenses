import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = "Хэрэглэгч";
  double _balance = 0.0;
  String _uid = "";
  double _income=0.0;
  double _expense=0.0;

  String get userName => _userName;
  String get uid => _uid;
  double get balance => _balance;
  double get income => _income;
  double get expense => _expense;

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
  void setIncome (double value) {
    _income= value;
    notifyListeners();
  }
  void setExpense (double value) {
    _expense= value;
    notifyListeners();
  }
}
