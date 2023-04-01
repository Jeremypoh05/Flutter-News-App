import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/inner_screens/blog_details.dart';
import 'package:news_app/inner_screens/news_details_webview.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        //InkWell widget is a rectangular area that responds to touch in an application
        // It's used to create buttons, clickable containers, and other interactive elements in your app.
        child: GestureDetector(
          onTap: () {
            //Navigate to the in app details screen instead of web view
            Navigator.pushNamed(context, NewsDetailsScreen.routeName);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      //this is the flutter package. For more details, read here:https://pub.dev/packages/fancy_shimmer_image
                      child: FancyShimmerImage(
                          height: size.height * 0.12,
                          width: size.width * 0.23,
                          boxFit: BoxFit.fill,
                          //if the imageUrl doesn't work, it will throw this errorWidget
                          errorWidget: Image.asset("assets/images/empty_image.png"),
                          imageUrl:
                              "https://cdn-2.tstatic.net/jatim/foto/bank/images/Chat-GPT-merupakan-produk-dari-OpenAI.jpg"),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title ' * 58,
                              maxLines: 2,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              style: smallTextStyle),
                          const VerticalSpacing(8),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text('🕐 Reading Time',
                                  style: smallTextStyle)),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      //this is the package from flutter. For more details, read here: https://pub.dev/packages/page_transition
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const NewsDetailsWebView(),
                                          inheritTheme: true,
                                          ctx: context),
                                    );
                                  },
                                  icon: Icon(Icons.link),
                                  color: Colors.blue[800],
                                ),
                                Text('20/2/2023 ' * 2,
                                    maxLines: 1, style: smallTextStyle),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}