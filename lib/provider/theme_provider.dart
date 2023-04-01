import 'package:flutter/cupertino.dart';
import 'package:news_app/services/dark_theme_prefs.dart';
// ---------- The purpose of this file -----------
//manage the user's preference for the dark theme using the DarkThemePrefs class, and to notify any interested widgets of changes in the preference.

//this ChangeNotifier will always keep listening to the changes
class ThemeProvider with ChangeNotifier {
  ThemePreferences darkThemePrefs = ThemePreferences();
  bool _darkTheme = false; //represents the dark theme is currently false
  bool get getDarkTheme => _darkTheme; //returns the value of _darkTheme.

  //takes a boolean 'value' as an argument, representing whether the dark theme is enabled or not.
  // The setter updates the value of _darkTheme with the new value, calls the darkThemePrefs.setDarkTheme(value)
  // method to update the preference stored in SharedPreferences,
  // and then calls notifyListeners() to notify any listeners of the change.
  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}
