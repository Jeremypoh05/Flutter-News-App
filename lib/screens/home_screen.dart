import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/inner_screens/search_screen.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/services/news.api.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/widgets/tabs.dart';
import 'package:news_app/widgets/top_trending.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/news_model.dart';
import '../widgets/articles_widget.dart';
import '../widgets/empty_screen.dart';
import '../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//create a private class
class _HomeScreenState extends State<HomeScreen> {
  //initialize the variable
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  //"didChangeDependencies" method is a built-in method in Flutter that is called whenever the state of a widget changes.
  //In this example, the method is used to call the "getNewsList" method
  // The purpose of calling this package in this way is to retrieve the news articles as soon as the widget is loaded, so that the articles can be displayed in the widget's UI.
  // @override
  // void didChangeDependencies() {
  //   getNewsList();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    //creates an instance of the Utils class with the current BuildContext as a parameter
    // and gets the current color scheme and screen size using the getColor getter method and getScreenSize from the ThemeProvider provider.
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    //By calling Provider.of<NewsProvider>(context), we are retrieving the instance of the NewsProvider class that
    // and is being managed by the nearest ancestor Provider widget in the widget tree.
    //Once we have obtained an instance of the NewsProvider class, we can access its properties and methods using the dot notation
    final newsProvider = Provider.of<NewsProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: true,
          title: Text('News App',
              style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.8),
              )),
          //using google_
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  //this is the package from flutter. For more details, read here: https://pub.dev/packages/page_transition
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const SearchScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: const Icon(IconlyLight.search),
            )
          ],
        ),
        drawer: const DrawerWidget(),
        //call the DrawerWidget class
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  //TabsWidget is a custom widget, check tabs.dart
                  TabsWidget(
                      text: 'All News',
                      //if the newsType is equal to the allNews constant
                      // which has been declared in the vars.dart, then it will show
                      //Theme.of(context).cardColor, else show transparent.
                      color: newsType == NewsType.allNews
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                      function: () {
                        //this function will check, if the newsType is already equal to allNews constant,
                        //then it will return itself.
                        if (newsType == NewsType.allNews) {
                          return;
                        }
                        //otherwise,  it sets the newsType to NewsType.allNews when the tab is being clicked
                        setState(() {
                          newsType = NewsType.allNews;
                        });
                      },
                      fontSize: newsType == NewsType.allNews ? 22 : 14),

                  const SizedBox(width: 25),

                  TabsWidget(
                      text: 'Top Trending',
                      //if the newsType is equal to the topTrending constant
                      // which has been declared in the vars.dart, then it will show
                      //Theme.of(context).cardColor, else show transparent.
                      color: newsType == NewsType.topTrending
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                      function: () {
                        //this function will check, if the newsType is already equal to topTrending constant,
                        //then it will return itself.
                        if (newsType == NewsType.topTrending) {
                          return;
                        }
                        //otherwise,  it sets the newsType to NewsType.topTrending when the tab is being clicked
                        setState(() {
                          newsType = NewsType.topTrending;
                        });
                      },
                      fontSize: newsType == NewsType.topTrending ? 22 : 14),
                ],
              ),
              const VerticalSpacing(12),

              // --------showing pagination ---------
              //if newsType is not top trending, show the pagination
              newsType == NewsType.topTrending
                  ? Container()
                  : SizedBox(
                      height: kBottomNavigationBarHeight,
                      //ensure that your UI elements are properly positioned and sized relative to the bottom navigation bar.
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          paginationButtons(
                              function: () {
                                if (currentPageIndex == 0) {
                                  //when currentPageIndex is zero, and the prev button is being clicked, nothing will happen
                                  return;
                                }
                                setState(() {
                                  currentPageIndex -=
                                      1; //currentPageIndex - 1 when the prev button is being clicked
                                });
                              },
                              text: "Prev"),
                          //this Flexible widget help us to avoid overflow errors
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                //make it can scrollable with horizontal style
                                itemBuilder: ((context, index) {
                                  //for us to access the context
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      //we need material so that we can access the hover effect
                                      //check the currentPageIndex, if equal to index, show blue color
                                      color: currentPageIndex == index
                                          ? Colors.blue[800]
                                          : Theme.of(context).cardColor,
                                      //InkWell widget is a rectangular area that responds to touch in an application
                                      // It's used to create buttons, clickable containers, and other interactive elements in your app.
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentPageIndex =
                                                index; //set the currentPageIndex to that index that being clicked
                                          });
                                        },
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${index + 1}"),
                                        )),
                                      ),
                                    ),
                                  );
                                })),
                          ),
                          paginationButtons(
                              function: () {
                                if (currentPageIndex == 5) {
                                  //when currentPageIndex is zero, and the prev button is being clicked, nothing will happen
                                  return;
                                }
                                setState(() {
                                  currentPageIndex +=
                                      1; //currentPageIndex + 1 when the next button is being clicked
                                });
                              },
                              text: "Next"),
                        ],
                      ),
                    ),
              const VerticalSpacing(10),
              //check whether the newsType is topTrending or not. If yes just simply show
              //the container, else it will show the DropdownButton
              newsType == NewsType.topTrending
                  ? Container()
                  : Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton(
                              value: sortBy,
                              items: dropDownItems,
                              onChanged: (String? value) {
                                setState(() {
                                  //value! is using the "non-null assertion operator" to assert that the value variable is not null.
                                  sortBy = value!;
                                });
                              }),
                        ),
                      ),
                    ),
              //FutureBuilder widget is used to asynchronously fetch and display the news articles.
              FutureBuilder<List<NewsModel>>(
                  //When the FutureBuilder widget is first built, it initiates the future operation defined in its future property.
                  // In this case, we will check if newsType is top trending,
                  //call the fetchTopHeadlines() method of the NewsProvider class, which returns a future that resolves to a list of NewsModel objects.
                  //else we call the fetchAllNews along with the pageIndex and sortBy parameters
                  future: newsType == NewsType.topTrending
                      ? newsProvider.fetchTopHeadlines()
                      : newsProvider.fetchAllNews(
                          pageIndex: currentPageIndex + 1, sortBy: sortBy),
                  //In the builder callback, it checks the snapshot object's connectionState to see if the data is still loading,
                  // and returns a loading widget if it is. If there is an error, it returns an error widget. If the data is null, it returns an empty news widget
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return newsType == NewsType.allNews
                          ? LoadingWidget(newsType: newsType)
                          : Expanded(child: LoadingWidget(newsType: newsType));
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: EmptyNewsWidget(
                          text: "${snapshot.error}",
                          imagePath: 'assets/images/no_news.png',
                        ),
                      );
                    } else if (snapshot.data == null) {
                      return const Expanded(
                        child: EmptyNewsWidget(
                          text: "No news found",
                          imagePath: 'assets/images/no_news.png',
                        ),
                      );
                    }

                    //If the data is loaded successfully, it checks the newsType to determine which widget to display.
                    // If it is NewsType.allNews, it returns a ListView.builder widget to display a list of articles.
                    // If it is not, it returns a Swiper widget to display the top trending articles.
                    return newsType == NewsType.allNews
                        ? Expanded(
                            child: ListView.builder(
                                //sets the itemCount to the length of the snapshot.data,
                                // and returns an ArticleWidget for each article.
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  //The ChangeNotifierProvider.value is used to provide an existing ChangeNotifier object to a widget subtree.
                                  // The value parameter is used to pass the existing ChangeNotifier object to the widget subtree which is ArticleWidget
                                  return ChangeNotifierProvider.value(
                                    value: snapshot.data![index],
                                    child: const ArticleWidget(
                                        //These properties are retrieved from the snapshot object, which represents
                                        // the asynchronous data returned by the future property of the FutureBuilder widget.
                                        // The index parameter is used to specify the index of the news article to be displayed.
                                        // !means non null, so the data returned by the Future object is non-null and can be accessed safely.
                                        // imageUrl: snapshot.data![index].urlToImage,
                                        // dateToShow: snapshot.data![index].dateToShow,
                                        // readingTime: snapshot.data![index].readingTimeText,
                                        // title: snapshot.data![index].title,
                                        // url: snapshot.data![index].url,
                                        ),
                                  );
                                }),
                          )
                        : SizedBox(
                            height: size.height * 0.6,
                            child: Swiper(
                                autoplay: true,
                                autoplayDelay: 7000,
                                itemWidth: size.width * 0.85,
                                viewportFraction: 0.9,
                                // layout: SwiperLayout.STACK,
                                //viewPort become small a bit
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  //ChangeNotifierProvider.value is used to provide a
                                  // NewsModel instance (retrieved from snapshot.data![index]) to the TopTrendingWidget as a value
                                  return ChangeNotifierProvider.value(
                                    value: snapshot.data![index],
                                    //TopTrendingWidget will listen to changes to the NewsModel instance
                                    // and rebuild itself whenever any changes occur.
                                    child: const TopTrendingWidget(
                                      // url: snapshot.data![index].url,
                                    ),
                                  );
                                }),
                          );
                  })),
              //LoadingWidget(newsType: newsType),
              // LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(SortByEnum.relevancy.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
    ];
    return menuItem;
  }

  //to make it more dynamic (also can create a new class like drawer_widget.dart or tabs.dart
  Widget paginationButtons({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[800],
        padding: const EdgeInsets.all(6),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }

//------- Moved this to new widgets class called tabs.dart ------- //
// Widget tabsWidget({required Function function, required String text, required Color color, required double fontSize}) {
//   return GestureDetector(
//     onTap: () {
//       function();
//     },
//     child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15), color: color),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             text,
//             style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
//           ),
//         )),
//   );
// }
}
