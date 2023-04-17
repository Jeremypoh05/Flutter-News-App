import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

import '../consts/api_consts.dart';
import '../models/bookmarks.model.dart';
import '../services/news.api.dart';

//ChangeNotifier is a special class that enables the class to notify its listeners when a change is made to its data.
class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> bookmarkList = [];

  //By declaring getBookMarkList as a getter method, we can access the contents of bookmarkList
  // from outside the class where it is declared without allowing direct modification of the list.
  List<BookmarksModel> get getBookMarkList {
    return bookmarkList;
  }

  //fetchBookmarks method is a method that returns a future that resolves to a list of bookmarksModel objects.
  //It fetches the bookmarks data using the NewsAPIServices.getBookmarks() method,
  // which is an asynchronous method that returns a list of Bookmarks objects.
  Future<List<BookmarksModel>> fetchBookmarks() async {
    try {
      bookmarkList = await NewsAPIServices.getBookmarks() ?? [];
    } catch (error) {
      log('Error in fetchBookmarks: $error');
    }
    notifyListeners(); //listen to the action, whether the user delete or add bookmark
    return bookmarkList;
  }

  //this method sends a POST request to a Firebase Realtime Database endpoint to add new data.
  //required NewsModel object parameter and returns a Future object that does not return a value.
  Future<void> addToBookmark({required NewsModel newsModel}) async {
    //try-catch block is used to catch any errors that might occur during the HTTP request and log them to the console using the log function
    try {
      //BASEURL_FIREBASE parameter representing the base URL of the Firebase project
      // bookmarks.json" representing the endpoint where the data will be added.
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");

      //Sends a POST request to the uri endpoint using the http.post method from the http package.
      //json.encode(newsModel.toJson()) is a method call that encodes the newsModel object
      // to JSON format. json is a built-in library in Dart that provides methods for encoding and decoding JSON data.
      var response = await http.post(uri,
          body: json.encode(
            newsModel.toJson(),
          ));
      notifyListeners(); //listen to the action, whether the user delete or add bookmark
      //print the error code and its message
      log('Response status for adding bookmark: ${response.statusCode}');
      log('Response body for adding bookmark: ${response.body}');
    } catch (error) {
      rethrow; //rethrow is used to re-throw any errors caught in the catch block to the calling code for further handling.
    }
  }

  Future<void> deleteBookmark({required String key}) async {
    try {
      //BASEURL_FIREBASE parameter representing the base URL of the Firebase project
      // bookmarks.json" representing the endpoint where the data will be added.
      var uri =
          Uri.https(BASEURL_FIREBASE, "bookmarks/$key.json");

      //Sends a delete request to the uri endpoint using the http.delete method from the http package.
      var response = await http.delete(uri);
      notifyListeners(); //listen to the action, whether the user delete or add bookmark
      log('Response status for delete bookmark: ${response.statusCode}');
      log('Response body for delete bookmark: ${response.body}');
    } catch (error) {
      rethrow; //rethrow is used to re-throw any errors caught in the catch block to the calling code for further handling.
    }
  }
}
