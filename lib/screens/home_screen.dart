import 'package:flutter/material.dart';
import 'package:news_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //The current theme state is obtained using the Provider.of method, which listens to changes in the DarkThemeProvider instance that was registered as a provider in the MyApp widget.
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Center(
        //SwitchListTile widget displays a switch to toggle between light and dark mode.
        child: SwitchListTile(
            title: Text('Theme'),
            secondary: Icon(themeState.getDarkTheme
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            //When the switch is toggled, the onChanged callback is called,
            // which sets the new theme state using the setDarkTheme method of the DarkThemeProvider instance
            onChanged: (bool value) {
              setState(() {
                themeState.setDarkTheme = value;
              });
            },
            value: themeState.getDarkTheme),
      ),
    );
  }
}
