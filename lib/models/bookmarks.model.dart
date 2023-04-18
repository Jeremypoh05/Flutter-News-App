import 'dart:developer';

import 'package:flutter/cupertino.dart';

//ChangeNotifier is a way to make the NewsModel class a provider in Flutter,
// meaning that it can notify its listeners when its state changes.
//it capable of notifying its listeners about changes to its state.
//commonly used for classes that manage some kind of data in a Flutter app, such as a user profile, shopping cart
class BookmarksModel with ChangeNotifier {
  //several properties, which represent different attributes of a news article.
  String
      bookmarkKey,
      newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      dateToShow,
      content,
      readingTimeText;

  //constructor
  BookmarksModel({
    required this.bookmarkKey,
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });

  //this method is a special constructor that takes a dynamic object
  // (in this case, a JSON object) and returns an instance of the BookmarksModel class.
  //fromJson method: This is a factory method used to convert a JSON object to a BookmarksModel object.
  // It takes in a dynamic json object and a required bookmarkKey string parameter.
  // The method uses the json object to extract values for the properties of the BookmarksModel object.
   factory BookmarksModel.fromJson({required dynamic json, required bookmarkKey}) {
    return BookmarksModel(
      bookmarkKey: bookmarkKey,
      newsId: json['newsId'] ?? "", //we cannot control this key because it will come from the firebase
      sourceName: json['sourceName'] ?? "",
      authorName: json['authorName'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ??
          'https://cdn-icons-png.flaticon.com/512/833/833268.png',
      publishedAt: json['publishedAt'] ?? '',
      dateToShow: json['dateToShow'] ?? "",
      content: json['content'] ?? "",
      readingTimeText: json['readingTimeText'] ?? "",
    );
  }

  //This method takes in a dynamic json object and a list of allKeys as parameters.
  // It maps each of the keys in allKeys to an instance of the BookmarksModel class using the fromJson method.
  // It returns a list of BookmarksModel objects.
  static List<BookmarksModel> bookmarksFromSnapshot({required dynamic json, required List allKeys}) {
    print("bookmarksFromSnapshot called with json: $json");
    print("bookmarksFromSnapshot called with allKeys: $allKeys");

    //The map method returns an iterable, so the method then converts the iterable to a list by
    // calling the toList method on it, and finally returns the list of BookmarksModel objects.
    return allKeys.map((key) {
      return BookmarksModel.fromJson(json: json[key],bookmarkKey: key);
    }).toList();
  }

  //allows us to print data
  @override
  String toString() {
    return 'news {newsId: $newsId, sourceName: $sourceName, authorName: $authorName, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content,}';
  }
}