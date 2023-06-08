import 'package:flutter/material.dart';

class BannerMenuProvider with ChangeNotifier {
  String currentTitle = 'Menu Principal - Cojapan';

  get getTitleBanner => this.currentTitle;

  void setTitleBanner(String value) {
    this.currentTitle = value;
    notifyListeners();
  }
}
