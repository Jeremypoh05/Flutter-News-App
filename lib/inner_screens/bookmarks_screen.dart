import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/empty_screen.dart';
import '../services/utils.dart';
import '../widgets/articles_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    //creates an instance of the Utils class with the current BuildContext as a parameter
    // and gets the current color scheme and screen size using the getColor getter method and getScreenSize
    // from the ThemeProvider provider.
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: true,
          title: Text('Bookmarks',
              style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.8),
              )),
        ),
        body: const EmptyNewsWidget(
          text: "Oops, it seems that you haven't added any bookmarks here.",
          imagePath: "assets/images/bookmark.png",
        )
        // ListView.builder(
        //     itemCount: 10, //display 10 articles
        //     itemBuilder: (context, index) {
        //       return const ArticleWidget();
        //     }),
        );
  }
}
