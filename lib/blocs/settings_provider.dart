// ------------------------------------------
// PROVIDER CONTROLLING THE SETTINGS SCREEN
// ------------------------------------------

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String oddFormatSelection = 'decimal'; // Default to decimal
  String themeColorSelection = 'navy';
  bool darkModeSetting = false; // Dark mode setting

  Color? primaryThemeColor = Color(0xFF091353);
  Color? primaryLightThemeColor = Colors.indigo[50];

  SettingsProvider() {
    getSharedPreferencesThemeColor();
    getSharedPreferencesOddFormat();
    getDarkModeSettings();
  }

  // -------------- THEME COLOR SETTINGS ------------//

// Set te color theme to be used by the app
  setSharedPreferencesThemeColor(String colorName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('color', colorName);
    print("Theme color set: $colorName");
    themeColorSelection = colorName;
    switch (themeColorSelection) {
      case 'indigo':
        primaryThemeColor = Colors.indigo[400];
        primaryLightThemeColor = Colors.indigo[50];
        break;
      case 'green':
        primaryThemeColor = Color(0xFF326B83);
        primaryLightThemeColor = Colors.blueGrey[50];
        break;
      case 'deeppurple':
        primaryThemeColor = Colors.deepPurple; //Colors.deepPurple;
        primaryLightThemeColor = Colors.deepPurple[50];
        break;
      /*  case 'brown':
        primaryThemeColor = Color(0xFF4A403A);
        primaryLightThemeColor = Colors.brown[50];
        break;
      case 'red':
        primaryThemeColor = Colors.red[900];
        primaryLightThemeColor = Colors.red[50];
        break; */
      case 'navy':
        primaryThemeColor = Color(0xFF091353);
        primaryLightThemeColor = Colors.indigo[50];
        break;
      default:
        primaryThemeColor = Colors.deepPurple;

        primaryLightThemeColor = Colors.deepPurple[50];
        break;
    }
    notifyListeners();
  }

// Get the color theme to be used by the app
  Future<String> getSharedPreferencesThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    themeColorSelection = prefs.getString('color') ?? 'navy';

    print("Theme color: $themeColorSelection");
    switch (themeColorSelection) {
      case 'indigo':
        primaryThemeColor = Colors.indigo[400];
        primaryLightThemeColor = Colors.indigo[50];
        break;
      case 'green':
        primaryThemeColor = Color(0xFF326B83);
        primaryLightThemeColor = Colors.blueGrey[50];
        break;
      case 'deeppurple':
        primaryThemeColor = Colors.deepPurple;
        primaryLightThemeColor = Colors.deepPurple[50];
        break;
      /* case 'brown':
        primaryThemeColor = Color(0xFF4A403A);
        primaryLightThemeColor = Colors.brown[100];
        break; */
      /* case 'red':
        primaryThemeColor = Colors.red[900];
        primaryLightThemeColor = Colors.red[50];
        break; */
      case 'navy':
        primaryThemeColor = Color(0xFF091353);
        primaryLightThemeColor = Colors.indigo[50];
        break;
      default:
        primaryThemeColor = Color(0xFF091353);
        primaryLightThemeColor = Colors.indigo[50];
        break;
    }
    notifyListeners();
    return themeColorSelection;
  }

  // ----------  ODD FORMAT SETTING ------------- //

  // Set te odd format to be used by the app
  setSharedPreferencesOddFormat(String formatName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('format', formatName);
    print("Odd format set: $formatName");
    oddFormatSelection = formatName;

    notifyListeners();
  }

  // Get the stored odd format to be used by the app
  Future<String> getSharedPreferencesOddFormat() async {
    final prefs = await SharedPreferences.getInstance();
    oddFormatSelection = prefs.getString('format') ?? 'decimal';
    notifyListeners();
    print("Odd Format: $oddFormatSelection");
    return oddFormatSelection;
  }

  // Return the current odd format in use
  String getOddFormatSelection() {
    return oddFormatSelection;
  }

  // ---------- DARK MODE SETTING ------------- //

  // Set app dark mode
  setDarkModeSetting(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', mode);
    print("Dark mode is : $mode");
    darkModeSetting = mode;
    notifyListeners();
  }

  // Get app dark mode and update
  Future<bool> getDarkModeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    darkModeSetting = prefs.getBool('darkMode') ?? false;
    notifyListeners();
    print("Dark mode : $darkModeSetting");
    return darkModeSetting;
  }
}
