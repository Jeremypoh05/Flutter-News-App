import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/bookmarks.model.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';
import '../consts/vars.dart';
import '../provider/bookmarks_provider.dart';
import '../services/utils.dart';
import '../widgets/articles_widget.dart';
import '../widgets/loading_widget.dart';

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
      drawer: DrawerWidget(),
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
      body: //FutureBuilder widget is used to asynchronously fetch and display the news articles.
      FutureBuilder<List<BookmarksModel>>(
        //The future property of the FutureBuilder is set to a call to the fetchBookmarks() method of
        // the BookmarksProvider using Provider.of.
        // The listen parameter is set to false to indicate that the FutureBuilder does not need to listen for changes to the provider.
          future: Provider.of<BookmarksProvider>(context, listen: false)
              .fetchBookmarks(),
          //In the builder callback, it checks the snapshot object's connectionState to see if the data is still loading,
          // and returns a loading widget if it is. If there is an error, it returns an error widget. If the data is null, it returns an empty news widget
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget(newsType: NewsType.allNews);
            } else if (snapshot.hasError) {
              return EmptyNewsWidget(
                text: "${snapshot.error}",
                imagePath: 'assets/images/no_news.png',
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const EmptyNewsWidget(
                text:
                "Oops, it seems that you haven't added any bookmarks here.",
                imagePath: "assets/images/bookmark.png",
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length, //set to the length of the snapshot.data list, which contains the bookmarked articles.
                itemBuilder: (context, index) {
                  //The ChangeNotifierProvider is a Flutter widget that provides an instance of a ChangeNotifier to its descendants.
                  // It is typically used to share state between multiple widgets in a Flutter app.
                  //ChangeNotifierProvider is being used to provide a BookmarksModel object to the ArticleWidget widget
                  return ChangeNotifierProvider.value(
                      value: snapshot.data![index],
                      //The ChangeNotifierProvider provides the ArticleWidget with a reference to the bookmarked article,
                      // which allows the widget to access its properties and display its details.
                      child: const ArticleWidget(
                        isBookmark: true, //indicate that the article is bookmarked.
                      ));
                });
          })),
    );
  }
}
