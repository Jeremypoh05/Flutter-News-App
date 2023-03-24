import 'package:flutter/material.dart';
import 'package:news_app/consts/theme_data.dart';
import 'package:news_app/provider/dark_theme_provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //allows us to provide multiple providers to the child widgets of the app. Here, we are providing only one provider, themeChangeProvider.
    return MultiProvider(
      providers: [
        //This provider is used to manage the app's state using the themeChangeProvider instance of DarkThemeProvider class.
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
      //Consumer widget listens to the changes in the app's state and
      // rebuilds the UI whenever there is a change in the state.
      // Here, it rebuilds the MaterialApp widget whenever the app theme changes.
      Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          //hide the initial app banner on screen
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context), //property that sets the app's theme based on the value returned from the getCurrentAppTheme() method.
          home: HomeScreen(), //sets the default home screen of the app to HomeScreen().
        );
      }),
    );
  }
}
