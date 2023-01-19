import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLang = 'ar';
  ThemeMode currentTheme = ThemeMode.light;

  void changeLanguage(String newLang) async {
    final prefs = await SharedPreferences.getInstance();
    if (currentLang == newLang) {
      return;
    }
    currentLang = newLang;
    prefs.setString("lang", currentLang);
    notifyListeners();
  }

  String getMainBackGround() {
    return isDark()
        ? 'assets/images/main_background_dark.png'
        : 'assets/images/main_background.png';
  }

  String getTasbehBackGround() {
    return isDark()
        ? 'assets/images/body_sebha_dark.png'
        : 'assets/images/body_sebha_logo.png';
  }

  String getTasbehHeadBackGround() {
    return isDark()
        ? 'assets/images/head_sebha_dark.png'
        : 'assets/images/head_sebha_logo.png';
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }

  void changeTheme(ThemeMode newMode) async{
    final prefs = await SharedPreferences.getInstance();
    if (newMode == currentTheme) {
      return;
    }
    currentTheme = newMode;
    prefs.setString("theme", currentTheme == ThemeMode.light? "light" : "dark");
    notifyListeners();
  }
}
