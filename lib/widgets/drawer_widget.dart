import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/inner_screens/bookmarks_screen.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    //The current theme state is obtained using the Provider.of method, which listens to changes in the DarkThemeProvider instance that was registered as a provider in the MyApp widget.
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              //set the DrawerHeader color to primaryColor which has been declared in global_colors.dart
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/images/newspaper.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const VerticalSpacing(20),
                  //call the VerticalSpacing class which will return the height of SizeBox
                  Flexible(
                    child: Text('News App',
                        style: GoogleFonts.lobster(
                          textStyle:
                              const TextStyle(fontSize: 20, letterSpacing: 0.8),
                        )), //using google_fonts package
                  )
                ],
              ),
            ),
            const VerticalSpacing(20),
            ListTilesWidget(
              label: "Home",
              icon: IconlyBold.home,
              function: () {},
            ),
            ListTilesWidget(
              label: "Bookmark",
              icon: IconlyBold.bookmark,
              function: () {
                Navigator.push(
                  context,
                  //this is the package from flutter. For more details, read here: https://pub.dev/packages/page_transition
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const BookmarkScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
            ),
            const Divider(
              thickness: 2,
            ),
            //SwitchListTile widget displays a switch to toggle between light and dark mode.
            SwitchListTile(
              title: Text(
                themeProvider.getDarkTheme ? 'Dark' : 'Light',
                style: const TextStyle(fontSize: 20),
              ),
              secondary: Icon(
                themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: themeProvider.getDarkTheme,
              //When the switch is toggled, the onChanged callback is called,
              // which sets the new theme state using the setDarkTheme method of the DarkThemeProvider instance
              onChanged: (bool value) {
                setState(() {
                  themeProvider.setDarkTheme = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//since we will have multiple ListTile widget, we refactor it to new flutter widget to avoid duplicate codes
class ListTilesWidget extends StatelessWidget {
  const ListTilesWidget({
    super.key,
    required this.label,
    required this.function,
    required this.icon,
  });

  // to make it more dynamic
  final String label; //initialize label variable
  final IconData icon; //initialize icon variable
  final Function function; //initialize function

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: () {
        function();
      },
    );
  }
}
