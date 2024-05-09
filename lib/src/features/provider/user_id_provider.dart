import 'package:flutter/material.dart';

class UserIdProvider extends ChangeNotifier {
  int? _userId;
  String? _userName;

  int? get userId => _userId;
  String? get userName => _userName;


  void setUserIdAndName(int userId, String userName) {
    _userId = userId;
    _userName = userName;
    notifyListeners();
  }
}
