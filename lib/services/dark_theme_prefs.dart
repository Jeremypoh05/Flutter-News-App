import 'package:shared_preferences/shared_preferences.dart';
// ---------- The purpose of this file -----------
// managing the user's preference for the dark theme using the shared_preferences package.


class ThemePreferences {
  static const THEME_STATUS = "THEMESTATUS";
  //this method used to set the value of the dark theme preference.
  //value as an argument, which represents whether the dark theme is enabled or not.
  setDarkTheme(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance(); //SharedPreferences.getInstance() method to retrieve an instance of the SharedPreferences object
    //once the instance get, calls the prefs.setBool() method to store the value of the dark theme preference under the key "THEMESTATUS".
    prefs.setBool(THEME_STATUS, value);
  }

  //getTheme method used to retrieve the value of the dark theme preference
  Future <bool> getTheme() async {
    //initialize SharedPreferences to retrieve an instance of the SharedPreferences object
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false; // retrieve the boolean value stored under the key "THEMESTATUS". If no value is found, it returns false as a default value.
  }
}