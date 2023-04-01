import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({Key? key}) : super(key: key);

  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  //This is a variable of type WebViewController that will hold a reference to the WebView's controller. The late keyword means that this variable will be initialized later.
  late WebViewController _webViewController;

  //This is a variable of type double that will hold the current progress of the web view's page loading progress. It is initially set to 0.0.
  double _progress = 0.0;

  //initialize url variable
  final url =
      "https://appsamurai.com/blog/your-complete-guide-to-mobile-news-category/";

  @override
  Widget build(BuildContext context) {
    //creates an instance of the Utils class with the current BuildContext as a parameter
    // and gets the current color scheme and using the getColor getter method from the ThemeProvider provider.
    final Color color = Utils(context).getColor;

    //WillPopScope widget allows you to intercept the back button press on Android devices.
    return WillPopScope(
      //onWillPop callback function is called when the user presses the back button. In this case,
      // it checks if the WebViewController can go back to a previous page by calling the canGoBack() method.
      // If it can go back, it calls the goBack() method to navigate to the previous page and returns false
      // to indicate that the back button press should not exit the app.
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          //stay inside the webpage
          return false;
          //If the WebViewController cannot go back, it returns true to indicate that the back button press should exit the app
        } else {
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            //back to HomeScreen
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrowLeft2),
            ),
            iconTheme: IconThemeData(color: color),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            centerTitle: true,
            title: Text("URL", style: TextStyle(color: color)),
            actions: [
              IconButton(
                  onPressed: () async {
                    //open the ModalSheet when pressing
                    await _showModalSheetFunction();
                  },
                  icon: const Icon(Icons.more_horiz))
            ],
          ),
          body: Column(
            children: [
              //show the linearProgressIndicator when the web view is being loaded
              LinearProgressIndicator(
                value: _progress,
                //when the _progress is not equal to zero, show the linearProgressIndicator color of blue, else show transparent
                color: _progress == 1.0 ? Colors.transparent : Colors.blue[700],
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              //This is a Flutter widget that displays a web view of a web page.
              //For more details, read here: https://pub.dev/packages/webview_flutter
              Expanded(
                child: WebView(
                  //The initial URL to load in the web view.
                  initialUrl: url,
                  zoomEnabled: true,
                  //Whether zooming is enabled or not.
                  //A callback function that is called whenever the progress of the web view's page loading changes.
                  // In this case, the setState method is called to update the _progress variable.
                  onProgress: (progress) {
                    setState(() {
                      // _progress is used to store the loading progress of the web page,
                      //When the onProgress callback is called, the current loading progress (passed as progress parameter)
                      // is divided by 100 and stored in the _progress variable.
                      //For example, if the loading progress is 50%, the value of _progress will be set to 0.5.
                      _progress = progress / 100;
                    });
                  },
                  //A callback function that is called when the web view is created.
                  // In this case, it sets the _webViewController variable to the controller instance.
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _showModalSheetFunction() async {
    //since showModalBottomSheet is Future type, we need to use Future method
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        //    //since we are inside the state class, we can access the context here
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              //indicates that the widget should be sized to its minimum intrinsic height or width,
              // depending on the main axis direction. This means that the widget will be as small as possible
              // in the main axis direction, while still accommodating its content.
              mainAxisSize: MainAxisSize.min,
              children: [
                const VerticalSpacing(20),
                Center(
                  child: Container(
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const VerticalSpacing(20),
                const Text(
                  "More Option",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const VerticalSpacing(20),
                const Divider(thickness: 2),
                const VerticalSpacing(20),
                ListTilesWidget(
                    label: "Share",
                    icon: Icons.share,
                    //since the reload() function is future type, we added async await
                    function: () async {
                      try {
                        //This is flutter package. For more details, read here: https://pub.dev/packages/share_plus
                        await Share.share('url', subject: 'Look what I made!');
                      } catch (error) {
                        //this method is an alertDialogBox which can be found in global_methods_dart (dynamic)
                        GlobalMethods.errorDialog(errorMessage: error.toString(), context: context);
                      }
                    }),
                ListTilesWidget(
                    label: "Open in browser",
                    icon: Icons.open_in_browser,
                    function: () async {
                      //the launchUrl is flutter package. For more details, read here: https://pub.dev/packages/url_launcher
                      // The Uri.parse() method is used to create a Uri object from a string representation of a URI.
                      //By passing Uri.parse(url) as an argument to launchUrl(), the url string is parsed into a Uri object,
                      // which is then used to launch the URL in the browser.
                      if (!await launchUrl(Uri.parse(url))) {
                        throw Exception('Could not launch $url');
                      }
                    }),
                ListTilesWidget(
                    label: "Refresh",
                    icon: Icons.refresh,
                    //since the reload() function is future type, we added async await
                    function: () async {
                      try {
                        await _webViewController.reload();
                      } catch (err) {
                        print("error occurred $err");
                      } finally {
                        Navigator.pop(context);
                      }
                    }),
              ],
            ),
          );
        });
  }
}

class ListTilesWidget extends StatelessWidget {
  const ListTilesWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.function,
  });

  // to make it more dynamic
  final String label; //initialize label variable
  final IconData icon; //initialize icon variable
  final Function function; //initialize function

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        function();
      },
    );
  }
}
