import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

// ------Purpose of this file ------ //
//creating a Utils object, you can access these getters and use them to retrieve
// the current theme or color of the app in different parts of your code.
class Utils{
  //constructor that takes a BuildContext object as a parameter.
  BuildContext context;
  Utils(this.context);

  //getter uses Provider.of to get the current DarkThemeProvider object
  // and retrieves the current theme (i.e., whether it is dark or not) from it.
  // This getter returns a boolean value indicating whether the current theme is dark or not.
  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  //getColor getter returns a Color object that corresponds to the current theme.
  //If the current theme is dark, the method returns Colors.white, otherwise it returns Colors.black.
  Color get getColor => getTheme ? Colors.white : Colors.black;
  //getScreenSize which returns the Size of the current screen.
  //MediaQuery.of(context) returns the MediaQueryData object associated with the current context,
  // which contains information about the current screen.
  Size get getScreenSize => MediaQuery.of(context).size;

  Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;

  Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;

  Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;
}