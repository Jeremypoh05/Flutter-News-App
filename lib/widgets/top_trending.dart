import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../inner_screens/blog_details.dart';
import '../inner_screens/news_details_webview.dart';
import '../services/utils.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({Key? key, required this.url}) : super(key: key);

  //initialize url variable
  //this url will
  final String url;

  @override
  Widget build(BuildContext context) {
//creates an instance of the Utils class with the current BuildContext as a parameter
    // and gets the current color scheme and screen size using the getColor getter method and getScreenSize
    // from the ThemeProvider provider.
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    //InkWell widget is a rectangular area that responds to touch in an application
    // It's used to create buttons, clickable containers, and other interactive elements in your app.
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, NewsDetailsScreen.routeName);
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
                  imageUrl:
                      "https://cdn-2.tstatic.net/jatim/foto/bank/images/Chat-GPT-merupakan-produk-dari-OpenAI.jpg",
                  height: size.height * 0.32,
                  width: double
                      .infinity, //indicate that FancyShimmerImage widget should expand to fill all available space along a particular axis
                  //FancyShimmerImage widget will have a width that spans the entire width of its parent widget, which is determined by the ClipRRect widget
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                              child:NewsDetailsWebView(url: url),
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
                    '20-2-2023',
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
