import 'package:flutter/cupertino.dart';

class DarkModeConfig extends ChangeNotifier {
  bool isDark = false;

  void toggleDark() {
    isDark = !isDark;
    notifyListeners();
  }
}
