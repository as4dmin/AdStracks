import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  String _currentPage = 'Home';

  String get currentPage => _currentPage;

  void setCurrentPage(String page) {
    _currentPage = page;
    notifyListeners();
  }
}
