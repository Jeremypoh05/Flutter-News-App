import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../inner_screens/blog_details.dart';
import '../inner_screens/news_details_webview.dart';
import '../models/news_model.dart';
import '../services/utils.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//creates an instance of the Utils class with the current BuildContext as a parameter
    // and gets the current color scheme and screen size using the getColor getter method and getScreenSize
    // from the ThemeProvider provider.
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;

    // retrieve an instance of the NewsModel class from the widget tree using the Provider.of method
    final newsModelProvider = Provider.of<NewsModel>(context);
    // --------- Additional notes ---------
    //newsModelProvider is a variable that holds an instance of the NewsModel class,
    // which is a ChangeNotifier class. By using newsModelProvider in front of "property's name",
    // we are accessing the property of the NewsModel instance.
    // This means that if the property changes, the UI will automatically update to reflect the new value,
    // because the NewsModel class extends ChangeNotifier and notifies its listeners (in this case, the UI) of any changes to its properties.


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        //InkWell widget is a rectangular area that responds to touch in an application
        // It's used to create buttons, clickable containers, and other interactive elements in your app.
        child: InkWell(
          onTap: () {
            //push the NewsDetailsScreen onto the navigation stack
            //arguments parameter is used to pass data from the current screen to the NewsDetailsScreen
            //passing the publishedAt property of the newsModelProvider
            //so that NewsDetailsScreen know which news article was selected and display its details.
            Navigator.pushNamed(context, NewsDetailsScreen.routeName, arguments: newsModelProvider.publishedAt);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                //this is the flutter package. For more details, read here:https://pub.dev/packages/fancy_shimmer_image
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl: newsModelProvider.urlToImage,
                  height: size.height * 0.32,
                  width: double
                      .infinity, //indicate that FancyShimmerImage widget should expand to fill all available space along a particular axis
                  //FancyShimmerImage widget will have a width that spans the entire width of its parent widget, which is determined by the ClipRRect widget
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  newsModelProvider.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          //this is the package from flutter. For more details, read here: https://pub.dev/packages/page_transition
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child:NewsDetailsWebView(url: newsModelProvider.url),
                              inheritTheme: true,
                              ctx: context),
                        );
                      },
                      icon: Icon(
                        Icons.link,
                        color: color,
                      )),
                  const Spacer(),
                  //also can use MainAxisAlignment.spaceBetween in row
                  SelectableText(
                    newsModelProvider.dateToShow,
                    style: GoogleFonts.montserrat(fontSize: 16),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
