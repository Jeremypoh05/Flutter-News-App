import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class NewsDetailsScreen extends StatefulWidget {
  //initialize the routeName variable and pass it to main.dart
  static const routeName = "/NewsDetailsScreen";

  const NewsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //creates an instance of the Utils class with the current BuildContext as a parameter
    // and gets the current color scheme using the getColor getter method from the ThemeProvider provider.
    final Color color = Utils(context).getColor;
    //By calling Provider.of<NewsProvider>(context), we are retrieving the instance of the NewsProvider class that
    // and is being managed by the nearest ancestor Provider widget in the widget tree.
    //Once we have obtained an instance of the NewsProvider class, we can access its properties and methods using the dot notation
    final newsProvider = Provider.of<NewsProvider>(context);
    //retrieves the value of the publishedAt argument passed to the current route using ModalRoute.of(context)!.settings.arguments.
    //The ! operator is used to assert that the ModalRoute and arguments are not null.
    final publishedAt = ModalRoute.of(context)!.settings.arguments as String;
    //initialize variable to access NewsProvider class's method(findByDate).
    final currentNews = newsProvider.findByDate(publishedAt: publishedAt);

    return Scaffold(
      appBar: AppBar(
        //approach 1 for set up icon
        iconTheme: IconThemeData(color: color),
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "By ${currentNews.authorName}",
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
        //approach 2 for set up icon
        leading: IconButton(
          icon: Icon(
            IconlyLight.arrowLeft,
            color: color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentNews.title,
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                const VerticalSpacing(25),
                Row(
                  children: [
                    Text(
                      currentNews.dateToShow,
                      style: smallTextStyle,
                    ),
                    const Spacer(),
                    Text(
                      currentNews.readingTimeText,
                      style: smallTextStyle,
                    ),
                  ],
                ),
                const VerticalSpacing(20),
              ],
            ),
          ),
          Stack(
            children: [
              //this is the flutter package. For more details, read here:https://pub.dev/packages/fancy_shimmer_image
              SizedBox(
                width: double.infinity,
                //this padding is used for the GestureDetector icon bottom there so that it looks like on the
                // middle of the screen(between icon and image)
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Hero(
                    //make sure the tag must be unique
                    tag: currentNews.publishedAt,
                    child: FancyShimmerImage(
                        boxFit: BoxFit.fill,
                        //if the imageUrl doesn't work, it will throw this errorWidget
                        errorWidget: Image.asset("assets/images/empty_image.png"),
                        imageUrl: currentNews.urlToImage),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 15,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            //This is flutter package. For more details, read here: https://pub.dev/packages/share_plus
                            await Share.share(currentNews.url,
                                subject: 'Look what I made!');
                          } catch (error) {
                            //this method is an alertDialogBox which can be found in global_methods_dart (dynamic)
                            GlobalMethods.errorDialog(
                                errorMessage: error.toString(),
                                context: context);
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.send,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 10,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            IconlyLight.bookmark,
                            size: 28,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const VerticalSpacing(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextContent(
                    label: 'Description',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                const VerticalSpacing(10),
                TextContent(
                    label: currentNews.description,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
                const VerticalSpacing(20),
                const TextContent(
                    label: 'Contents',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                const VerticalSpacing(10),
                TextContent(
                    label: currentNews.content,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ],
            ),
          )
        ],
      ),
    );
  }
}


//refactor a custom widget
class TextContent extends StatelessWidget {
  const TextContent({
    super.key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
  });

  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    //to make the text can be highlight when double clicked
    return SelectableText(
      label,
      textAlign: TextAlign.justify,
      style: GoogleFonts.roboto(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
