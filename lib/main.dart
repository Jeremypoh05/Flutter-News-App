//Packages
import 'package:flutter/material.dart';
import 'package:news_app/inner_screens/blog_details.dart';
import 'package:provider/provider.dart';

//Consts
import 'package:news_app/consts/theme_data.dart';

//Providers
import 'package:news_app/provider/theme_provider.dart';
//screens
import 'package:news_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //fetch the current theme
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
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
      Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          //hide the initial app banner on screen
          title: 'News App',
          theme: Styles.themeData(themeProvider.getDarkTheme, context), //property that sets the app's theme based on the value returned from the getCurrentAppTheme() method.
          home: const HomeScreen(), //sets the default home screen of the app to HomeScreen().
          routes: {
            NewsDetailsScreen.routeName: (context)=> const NewsDetailsScreen(),
          },
        );
      }),
    );
  }
}
