import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  int _counter = 1;
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
