import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:news_app/widgets/vertical_spacing.dart';

import '../services/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ----TextEditingController ---- //
  //TextEditingController is a class that is used to manage the text entered into a TextField widget in Flutter.
  //It allows you to listen for changes to the text field and to also set or get the value of the text field programmatically.
  //It also provides you with the ability to clear the text field's value or to dispose of the controller when it is no longer needed.
  late final TextEditingController _searchTextController;

  // ---- FocusNode ---- //
  //FocusNode class represents a node in the focus tree that can receive keyboard focus, allowing you to control when a widget is focused or unfocused
  // programmatically remove the focus from the TextField when the user hits the "submit" button or when the user taps outside the TextField. To do this, we can use the FocusNode instance associated with the TextField and call its unfocus() method.
  late final FocusNode focusNode;

  @override
  //This method is called when the widget is first inserted into the widget tree.
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  //this method is called when the widget is removed from the widget tree, the _searchTextController and focusNode are disposed of to free up resources.
  //dispose method is useful for cleaning up any resources that the widget may have acquired, such as streams, animations, or controllers.
  //In our case, TextEditingController and a FocusNode objects need to be disposed of when the widget is removed from the tree
  // to prevent any memory leaks or other issues.
  void dispose() {
    //The if (mounted) check in the dispose() method is used to ensure that the widget is still part of the widget tree before attempting to dispose of any resources.
    // if true, it is safe to dispose of its resources.
    if (mounted) {
      _searchTextController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // and gets the current color scheme and screen size using the getColor getter method and getScreenSize
    // from the ThemeProvider provider.
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); //this function is same as focusNode.unfocus();
        },
        child: Scaffold(
            body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      focusNode.unfocus(); //to hide the keyboard
                      Navigator.pop(
                          context); //removes the current Route from the stack of routes managed by the Navigator. So essentially, it is go back to HomeScreen
                    },
                    child: const Icon(IconlyLight.arrowLeft2),
                  ),
                  //Flexible takes only the needed space, and Expanded takes all available space, respecting the flex factor.
                  Flexible(
                      child: TextField(
                    //binds the previously declared FocusNode to the TextField, allowing the focus node to control when the TextField receives focus.
                    focusNode: focusNode,
                    //binds the previously declared TextEditingController to the TextField, allowing the text entered into the TextField to be managed by the controller.
                    controller: _searchTextController,
                    style: TextStyle(color: color),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    //change the icon of keyboard to search icon
                    keyboardType: TextInputType.text,
                    onEditingComplete: () {},
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Search",
                      enabledBorder: InputBorder.none,
                      //suffix is an attribute of InputDecoration widget, which is used to add a widget at the end of the input decoration's container.
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            _searchTextController.clear(); //remove the text
                            focusNode.unfocus(); //to hide the keyboard
                          },
                          child: const Icon(Icons.close,
                              size: 18, color: Colors.red),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            const VerticalSpacing(20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //this is the flutter package. For more details, read here: https://pub.dev/packages/flutter_staggered_grid_view
                child: MasonryGridView.count(
                  itemCount: searchKeywords.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: color),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 10),
                          child: Center(
                              child: Text(searchKeywords[
                                  index])), //call the searchKeyWords list from vars.dart
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const EmptyNewsWidget(
                text: "We're sorry! There is no results matching your search.",
                imagePath: "assets/images/search.png")
          ],
        )),
      ),
    );
  }
}
